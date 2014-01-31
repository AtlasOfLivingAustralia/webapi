package au.org.ala.webapi

import org.springframework.dao.DataIntegrityViolationException

class ExampleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [exampleInstanceList: Example.list(params), exampleInstanceTotal: Example.count()]
    }

    def create() {
        [exampleInstance: new Example(params)]
    }

    def createForWS() {
        def webService = WebService.get(params.id)
        def wsParams = webService.getSortedParams()
        def exampleParams = []
        if(wsParams){
            wsParams.eachWithIndex { wsParam, idx -> exampleParams.add(idx, new ExampleParam(param:wsParam))  }
        }

        def example = new Example(params)
        example.params = exampleParams
        example.webService = webService

        render(view:'create', model:[exampleInstance: example, webService:webService])
    }

    def save() {
        def exampleInstance = new Example(params)
        if (!exampleInstance.save(flush: true)) {
            render(view: "create", model: [exampleInstance: exampleInstance])
            return
        }

        storeParams(exampleInstance, params)

        flash.message = message(code: 'default.created.message', args: [message(code: 'example.label', default: 'Example'), exampleInstance.id])
        redirect(action: "show", id: exampleInstance.id)
    }

    def show(Long id) {
        def exampleInstance = Example.get(id)
        if (!exampleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "list")
            return
        }

        [exampleInstance: exampleInstance]
    }

    private void storeParams(exampleInstance, params) {
        //save the parameters
        def paramValues = params.list('paramValue')
        def paramIds = params.list('paramId')
        if(exampleInstance.params == null){
            exampleInstance.params = []
        }
        paramValues.eachWithIndex { paramValue, i ->
            if(paramValue){
                def paramId = paramIds[i]
                def param = Param.findById( paramId)
                def ep = new ExampleParam(example:exampleInstance, param:param, value: paramValue)
                ep.save(flush: true)
                exampleInstance.params << ep
            }
        }
    }

    def edit(Long id) {
        def exampleInstance = Example.get(id)
        if (!exampleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "list")
            return
        }

        [exampleInstance: exampleInstance]
    }

    def update(Long id, Long version) {
        def exampleInstance = Example.get(id)
        if (!exampleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (exampleInstance.version > version) {
                exampleInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'example.label', default: 'Example')] as Object[],
                          "Another user has updated this Example while you were editing")
                render(view: "edit", model: [exampleInstance: exampleInstance])
                return
            }
        }

        exampleInstance.properties = params

        if (!exampleInstance.save(flush: true)) {
            render(view: "edit", model: [exampleInstance: exampleInstance])
            return
        }

        //remove old params
        exampleInstance.params.clear()
        exampleInstance.save(flush:true)

        //add new
        storeParams(exampleInstance, params)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'example.label', default: 'Example'), exampleInstance.id])
        redirect(action: "show", id: exampleInstance.id)
    }

    def delete(Long id) {
        def exampleInstance = Example.get(id)
        if (!exampleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "list")
            return
        }

        try {
            exampleInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "show", id: id)
        }
    }
}
