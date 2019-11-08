package au.org.ala.webapi

import com.opencsv.CSVWriter
import grails.config.Config
import grails.core.support.GrailsConfigurationAware

import static org.springframework.http.HttpStatus.OK

class ExampleController implements GrailsConfigurationAware {

    static scaffold = Example

    def exampleService
    def combinedCacheService

    String csvMimeType
    String encoding

    @Override
    void setConfiguration(Config co) {
        csvMimeType = co.getProperty('grails.mime.types.csv', String, 'text/csv')
        encoding = co.getProperty('grails.converters.encoding', String, 'UTF-8')

    }

    def index(Integer max) {
        params.max = Math.min(max ?: 1000, 1000)
        respond Example.list(params), model: [exampleCount: Example.count()]
    }

    def createForWS() {
        def webService = WebService.get(params.webService)
        def wsParams = webService.getSortedParams()
        def exampleParams = []
        if(wsParams){
            wsParams.eachWithIndex { wsParam, idx -> exampleParams.add(idx, new ExampleParam(param:wsParam))  }
        }

        def example = new Example(params)
        example.params = exampleParams
        example.webService = webService

        combinedCacheService.clearCache()
        render(view:'create', model:[example: example, webService: webService])
    }

    def save() {
        def exampleInstance = new Example(params)
        if (!exampleInstance.save(flush: true)) {
            render(view: "create", model: [example: exampleInstance])
            return
        }

        storeParams(exampleInstance, params)

        flash.message = message(code: 'default.created.message', args: [message(code: 'example.label', default: 'Example'), exampleInstance.id])

        combinedCacheService.clearCache()
        if(params.returnTo){
            redirect(url: params.returnTo)
        } else {
            redirect(action: "show", id: exampleInstance.id)
        }
    }

    def exportAsCsv(Long id) {
        List outputList
        final String filename = 'output.csv'

        if (id) {
            def app = App.findById(id)
            log.debug "app = ${app}"
            def webServices = WebService.findAllByApp(app)
            filename = "${app}.csv"
            log.debug "webServices = ${webServices}"

            if (webServices) {
                def examples = Example.findAllByWebServiceInList(webServices)
                log.debug "Found ${examples.size()} examples => ${examples}"
                outputList = examples.collect { [it.name, it.description, it.webService.httpMethod.join("; "), it.webService.outputFormat.join("; "), it.queryUrl] as String[] }
            }

        } else {
            return render(status: 400, text: "App id not provided - choose one of: ${App.list().collect{it.id + ' = '  + it.name}.join(' | ')}")
        }

        OutputStream outs = response.outputStream
        response.status = OK.value()
        response.contentType = "${csvMimeType};charset=${encoding}";
        response.setHeader "Content-disposition", "attachment; filename=${filename}"

        Writer outputStreamWriter = new OutputStreamWriter(outs);
        CSVWriter writer = new CSVWriter(outputStreamWriter)
        writer.writeNext(["Name", "Description", "http method", "output format", "URL"] as String[]) // header line

        outputList.each { String[] entry ->
            writer.writeNext(entry)
        }

        writer.flush()
        writer.close()
        outs.flush()
        outs.close()
    }

    def show(Long id) {
        def exampleInstance = Example.get(id)
        if (!exampleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "index")
            return
        }
        [example: exampleInstance]
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

    def update(Long id, Long version) {
        def exampleInstance = Example.get(id)
        if (!exampleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "index")
            return
        }

        if (version != null) {
            if (exampleInstance.version > version) {
                exampleInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'example.label', default: 'Example')] as Object[],
                          "Another user has updated this Example while you were editing")
                render(view: "edit", model: [example: exampleInstance])
                return
            }
        }

        exampleInstance.properties = params

        if (!exampleInstance.save(flush: true)) {
            render(view: "edit", model: [example: exampleInstance])
            return
        }

        //remove old params
        exampleInstance.params?.clear()
        exampleInstance.save(flush:true)

        //add new
        storeParams(exampleInstance, params)

        combinedCacheService?.clearCache()
        flash.message = message(code: 'default.updated.message', args: [message(code: 'example.label', default: 'Example'), exampleInstance.id])
        if(params.returnTo){
            redirect(url: params.returnTo)
        } else {
            redirect(action: "show", id: exampleInstance.id)
        }
    }

    def graph(Long id) {

        def example = Example.get(id)
        if (!example) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'example.label', default: 'Example'), id])
            redirect(action: "list")
            return
        }
        def now = new Date()
        def then = now - 3
        def sortedRuns = ExampleRun
                .executeQuery("select new map(er.class as clazz, er.id as id, er.start as start, er.duration as duration, er.url as url, er.responseCode as responseCode, er.exceptionClass as exceptionClass, er.message as message) from ExampleRun er where er.example.id = :id and start > :start order by er.start", ["id": id, "start" : then.time])

        sortedRuns.each {
            it.start = new Date(it.start)
        }

        def max = sortedRuns.max {it.duration}
        def min = sortedRuns.min {it.duration}
        ["example" : example, "sortedRuns" : sortedRuns, "min" : min, "max" : max]
    }

    /** list all machine runnable examples and web services with no examples */
    def lastRuns() {
        def services = Timer.time {
            WebService.executeQuery("from WebService ws where 'GET' in elements(ws.httpMethod) and true not in (select e.machineCallable from Example as e where e.webService.id = ws.id) order by name")
        }

        def sort = params.sort in ['example.name', 'responseCode', 'start', 'duration'] ? params.sort : 'example.name'
        def order = params.order in ['asc', 'desc'] ? params.order : 'asc'

        def latestRuns = Timer.time {
            //ExampleRun.executeQuery("select new map(er.id as id, er.example as example, er.responseCode as responseCode, er.message as message, er.duration as duration, er.start as start) from ExampleRun as er where (er.example.id, er.start) in (select er2.example.id, max(er2.start) from ExampleRun as er2 group by er2.example.id) order by er.$sort $order")
            // The above generates a really slow query for MySQL 5.0 (but seemingly not for 5.6)
            // so do the following instead
            final lastExamples = ExampleRun.executeQuery("select new map(er2.example.id as exampleId, max(er2.start) as maxStart) from ExampleRun as er2 group by er2.example.id")
            final values = lastExamples.collect { ExampleRun.executeQuery("select new map(er.id as id, er.example as example, er.responseCode as responseCode, er.message as message, er.duration as duration, er.start as start) from ExampleRun as er where (er.example.id, er.start) =  (:exampleId, :maxStart)", [exampleId: it.exampleId, maxStart: it.maxStart])}.flatten()

            if (sort) {
                values.sort(true) { self, other ->
                    final o1, o2
                    switch (sort) {
                        case 'example.name':
                            o1 = self.example.name
                            o2 = other.example.name
                            break
                        case 'responseCode':
                            o1 = self.responseCode
                            o2 = other.responseCode
                            break
                        case 'start':
                            o1 = self.start
                            o2 = other.start
                            break
                        case 'duration':
                            o1 = self.duration
                            o2 = other.duration
                            break
                        default:
                            o1 = self.id
                            o2 = other.id
                            break
                    }
                    final val
                    if (order == 'desc') val = o2?.compareTo(o1 ?: 0) ?: -1
                    else if (o1 == null && o2 == null) val = 0
                    else val = o1?.compareTo(o2 ?: 0) ?: 1
                    val
                }
            }
            values
        }

        latestRuns.value.each {
            it.start = new Date(it.start)
        }

        [services: services, latestRuns: latestRuns]
    }

    def callExample(Long id) {
        final example = show(id).example
        if (!example) return

        final run = exampleService.callExample(example)
        exampleService.saveOrLogValidationErrors(run)
        final message
        switch(run) {
            case ExampleRunResponse:
                message = "with response code ${run.responseCode} and content type ${run.contentType}"
                break
            case ExampleRunFailure:
                message = "with exception ${run.exceptionClass} and message ${run.message}"
                break
            default:
                message =""
                break
        }
        flash.message = "${example.name} called in ${run.end - run.start}ms ${message}"
        redirect(action: 'lastRuns')
        return
    }

    def brokenServicesEmail() {
        final now = new Date()
        final then = now - 1
        final brokenServices = exampleService.findBrokenWebServices(then, now, 2)
        render(view:"/digestmail/brokenServices", model:[examples: brokenServices])
    }
}
