package au.org.ala.webapi

import org.springframework.dao.DataIntegrityViolationException

class FormatController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [formatInstanceList: Format.list(params), formatInstanceTotal: Format.count()]
    }

    def create() {
        [formatInstance: new Format(params)]
    }

    def save() {
        def formatInstance = new Format(params)
        if (!formatInstance.save(flush: true)) {
            render(view: "create", model: [formatInstance: formatInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'format.label', default: 'Format'), formatInstance.id])
        redirect(action: "show", id: formatInstance.id)
    }

    def show(Long id) {
        def formatInstance = Format.get(id)
        if (!formatInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'format.label', default: 'Format'), id])
            redirect(action: "list")
            return
        }

        [formatInstance: formatInstance]
    }

    def edit(Long id) {
        def formatInstance = Format.get(id)
        if (!formatInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'format.label', default: 'Format'), id])
            redirect(action: "list")
            return
        }

        [formatInstance: formatInstance]
    }

    def update(Long id, Long version) {
        def formatInstance = Format.get(id)
        if (!formatInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'format.label', default: 'Format'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (formatInstance.version > version) {
                formatInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'format.label', default: 'Format')] as Object[],
                        "Another user has updated this Format while you were editing")
                render(view: "edit", model: [formatInstance: formatInstance])
                return
            }
        }

        formatInstance.properties = params

        if (!formatInstance.save(flush: true)) {
            render(view: "edit", model: [formatInstance: formatInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'format.label', default: 'Format'), formatInstance.id])
        redirect(action: "show", id: formatInstance.id)
    }

    def delete(Long id) {
        def formatInstance = Format.get(id)
        if (!formatInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'format.label', default: 'Format'), id])
            redirect(action: "list")
            return
        }

        try {
            formatInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'format.label', default: 'Format'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'format.label', default: 'Format'), id])
            redirect(action: "show", id: id)
        }
    }
}
