package au.org.ala.webapi

class WebServiceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    static defaultAction = "list"
    static scaffold = WebService

    def combinedCacheService

    def list(Integer max) {
        params.max = Math.min(max ?: 1000, 1000)
        respond WebService.list(params), model: [webServiceCount: WebService.count()]
    }

    def create() {

        if(params.id){
            def webService = WebService.findById(params.id)
            def clone = new WebService([
                    app: webService.app,
                    name: "Copy of " + webService.name,
                    description: webService.description,
                    httpMethod: webService.httpMethod,
                    deprecated: webService.deprecated,
                    url: webService.url,
                    outputFormat: webService.outputFormat,
                    exampleOutput: webService.exampleOutput,
                    categories: webService.categories
            ])
            def clonedParams = []
            webService.params.each { param ->
               clonedParams << new Param([
                       name:param.name,
                       description: param.description,
                       type: param.type,
                       mandatory: param.mandatory,
                       deprecated : param.deprecated,
                       includeInTitle : param.includeInTitle,
                       format : param.format
               ])
            }
            clone.params = clonedParams
            combinedCacheService.clearCache()
            respond clone
        } else {
            combinedCacheService.clearCache()
            respond new WebService(params)
        }
    }

    def save() {
        def webServiceInstance = new WebService(params)
        if (!webServiceInstance.save(flush: true)) {
            render(view: "create", model: [webServiceInstance: webServiceInstance])
            return
        }

        storeParams(webServiceInstance, params)

        combinedCacheService.clearCache()
        flash.message = message(code: 'default.created.message', args: [message(code: 'webService.label', default: 'WebService'), webServiceInstance.id])
        if(params.returnTo){
            redirect(url: params.returnTo)
        } else {
            redirect(action: "show", id: webServiceInstance.id)
        }
    }

    def update(Long id, Long version) {

        def webServiceInstance = WebService.get(id)
        if (!webServiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'webService.label', default: 'WebService'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (webServiceInstance.version > version) {
                webServiceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'webService.label', default: 'WebService')] as Object[],
                          "Another user has updated this WebService while you were editing")
                render(view: "edit", model: [webServiceInstance: webServiceInstance])
                return
            }
        }

        webServiceInstance.properties = params

        if (!webServiceInstance.save(flush: true)) {
            render(view: "edit", model: [webServiceInstance: webServiceInstance])
            return
        }

        //reconcile params

        //save the parameters
        def paramIds = params.list('paramId')
        def paramNames = params.list('paramName')
        def paramTypes = params.list('paramType')
        def paramMandatorys = params.list('_paramMandatory')
        def paramDeprecateds = params.list('_paramDeprecated')
        def paramIncludeInTitles = params.list('_paramIncludeInTitle')
        def paramDescriptions = params.list('paramDescription')

        //existing params for this service
        def currentParamIds = webServiceInstance.params.collect { it.id }

        def restoredParamIds = []

        paramNames.eachWithIndex { paramName, i ->
            def paramId = paramIds[i]
            def paramType = paramTypes[i]
            def paramMandatory = Boolean.parseBoolean(paramMandatorys[i])
            def paramDeprecated = Boolean.parseBoolean(paramDeprecateds[i])
            def paramIncludeInTitle = Boolean.parseBoolean(paramIncludeInTitles[i])
            def paramDescription = paramDescriptions[i]

            if(paramId){
                restoredParamIds << Long.parseLong(paramId)
                Param p = Param.findById(paramId)
                p.mandatory = paramMandatory
                p.name = paramName
                p.deprecated = paramDeprecated
                p.includeInTitle = paramIncludeInTitle
                p.type = paramType
                p.description = paramDescription
                p.save(flush:true)
            } else {
                Param p = new Param([webService: webServiceInstance, name: paramName,
                        type: paramType, mandatory: paramMandatory, deprecated:paramDeprecated, description: paramDescription])
                p.save(flush: true)
                webServiceInstance.params << p
            }
        }

        currentParamIds.removeAll(restoredParamIds)

        currentParamIds.each {
            def paramToGo = Param.findById(it)
            webServiceInstance.removeFromParams(paramToGo)
            paramToGo.delete(flush:true)
        }

        webServiceInstance.save(flush:true)

         //add new

        combinedCacheService.clearCache()
        flash.message = message(code: 'default.updated.message', args: [message(code: 'webService.label', default: 'WebService'), webServiceInstance.id])
        if(params.returnTo){
            redirect(url: params.returnTo)
        } else {
            redirect(action: "show", id: webServiceInstance.id)
        }
    }

    private void storeParams(webServiceInstance, params) {
        //save the parameters
        def paramNames = params.list('paramName')
        def paramTypes = params.list('paramType')
        def paramMandatorys = params.list('_paramMandatory')
        def paramDeprecateds = params.list('_paramDeprecated')
        def paramIncludeInTitles = params.list('_paramIncludeInTitle')
        def paramDescriptions = params.list('paramDescription')

        if(!webServiceInstance.params){
            webServiceInstance.params = []
        }

        paramNames.eachWithIndex { paramName, i ->

            def paramType = paramTypes[i]
            def paramMandatory = Boolean.parseBoolean(paramMandatorys[i])
            def paramDeprecated = Boolean.parseBoolean(paramDeprecateds[i])
            def paramIncludeInTitle = Boolean.parseBoolean(paramIncludeInTitles[i])
            def paramDescription = paramDescriptions[i]

            Param p = new Param([webService: webServiceInstance,
                    name: paramName,
                    type: paramType,
                    mandatory: paramMandatory,
                    deprecated: paramDeprecated,
                    description: paramDescription,
                    includeInTitle:paramIncludeInTitle])
            p.save(flush: true)
            webServiceInstance.params << p
        }
    }
}
