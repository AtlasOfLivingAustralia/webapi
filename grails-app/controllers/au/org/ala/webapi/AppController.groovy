package au.org.ala.webapi



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AppController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond App.list(params), model:[appInstanceCount: App.count()]
    }

    def show(App appInstance) {
        respond appInstance
    }

    def create() {
        respond new App(params)
    }

    @Transactional
    def save(App appInstance) {
        if (appInstance == null) {
            notFound()
            return
        }

        if (appInstance.hasErrors()) {
            respond appInstance.errors, view:'create'
            return
        }

        appInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'appInstance.label', default: 'App'), appInstance.id])
                redirect appInstance
            }
            '*' { respond appInstance, [status: CREATED] }
        }
    }

    def edit(App appInstance) {
        respond appInstance
    }

    @Transactional
    def update(App appInstance) {
        if (appInstance == null) {
            notFound()
            return
        }

        if (appInstance.hasErrors()) {
            respond appInstance.errors, view:'edit'
            return
        }

        appInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'App.label', default: 'App'), appInstance.id])
                redirect appInstance
            }
            '*'{ respond appInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(App appInstance) {

        if (appInstance == null) {
            notFound()
            return
        }

        appInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'App.label', default: 'App'), appInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'appInstance.label', default: 'App'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
