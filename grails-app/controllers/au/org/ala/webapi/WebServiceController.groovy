package au.org.ala.webapi

import org.springframework.dao.DataIntegrityViolationException

class WebServiceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        [webServiceInstanceList: WebService.list(params), webServiceInstanceTotal: WebService.count()]
    }

    def create() {
        [webServiceInstance: new WebService(params)]
    }

    def save() {
        def webServiceInstance = new WebService(params)
        if (!webServiceInstance.save(flush: true)) {
            render(view: "create", model: [webServiceInstance: webServiceInstance])
            return
        }

        //save the parameters
//        def paramNames = params.list('paramName')
//        def paramTypes = params.list('paramType')
//        def paramMandatorys = params.list('_paramMandatory')
//        def paramDescriptions = params.list('paramDescription')
//
//        paramNames.eachWithIndex { entry,  i ->
//
//            def paraName = entry
//            def paramType = paramTypes[i]
//            def paramMandatory = Boolean.parseBoolean(paramMandatorys[i])
//            def paramDescription = paramDescriptions[i]
//
//            Param p = new Param([webService:webServiceInstance, name:paraName,
//                    type:paramType, mandatory:paramMandatory, description:paramDescription])
//            p.save(flush:true)
//        }
        storeParams(webServiceInstance, params)

        flash.message = message(code: 'default.created.message', args: [message(code: 'webService.label', default: 'WebService'), webServiceInstance.id])
        redirect(action: "show", id: webServiceInstance.id)
    }

    def show(Long id) {
        def webServiceInstance = WebService.get(id)
        if (!webServiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'webService.label', default: 'WebService'), id])
            redirect(action: "list")
            return
        }

        [webServiceInstance: webServiceInstance]
    }

    def edit(Long id) {
        def webServiceInstance = WebService.get(id)
        if (!webServiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'webService.label', default: 'WebService'), id])
            redirect(action: "list")
            return
        }

        [webServiceInstance: webServiceInstance]
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
        def paramDescriptions = params.list('paramDescription')

        //existing params for this service
        def currentParamIds = webServiceInstance.params.collect { it.id }

        def restoredParamIds = []

        paramNames.eachWithIndex { paramName, i ->
            def paramId = paramIds[i]
            def paramType = paramTypes[i]
            def paramMandatory = Boolean.parseBoolean(paramMandatorys[i])
            def paramDeprecated = Boolean.parseBoolean(paramDeprecateds[i])
            def paramDescription = paramDescriptions[i]

            if(paramId){
                restoredParamIds << Long.parseLong(paramId)
                Param p = Param.findById(paramId)
                p.mandatory = paramMandatory
                p.name = paramName
                p.deprecated = paramDeprecated
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

        flash.message = message(code: 'default.updated.message', args: [message(code: 'webService.label', default: 'WebService'), webServiceInstance.id])
        redirect(action: "show", id: webServiceInstance.id)
    }
//
    private void storeParams(webServiceInstance, params) {
        //save the parameters
        def paramNames = params.list('paramName')
        def paramTypes = params.list('paramType')
        def paramMandatorys = params.list('_paramMandatory')
        def paramDescriptions = params.list('paramDescription')

        paramNames.eachWithIndex { paramName, i ->

            def paramType = paramTypes[i]
            def paramMandatory = Boolean.parseBoolean(paramMandatorys[i])
            def paramDescription = paramDescriptions[i]

            Param p = new Param([webService: webServiceInstance, name: paramName,
                    type: paramType, mandatory: paramMandatory, description: paramDescription])
            p.save(flush: true)
            webServiceInstance.params << p
        }
    }

    def delete(Long id) {
        def webServiceInstance = WebService.get(id)
        if (!webServiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'webService.label', default: 'WebService'), id])
            redirect(action: "list")
            return
        }

        try {
            webServiceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'webService.label', default: 'WebService'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'webService.label', default: 'WebService'), id])
            redirect(action: "show", id: id)
        }
    }
}
