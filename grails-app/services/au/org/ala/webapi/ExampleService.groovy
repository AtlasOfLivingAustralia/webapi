package au.org.ala.webapi

import com.google.common.base.Charsets
import grails.util.Holders
import groovy.time.TimeCategory
import org.apache.commons.lang.time.DateUtils
import org.springframework.transaction.annotation.Transactional

import java.util.concurrent.Callable
import java.util.concurrent.CompletionService
import java.util.concurrent.ExecutorCompletionService
import java.util.concurrent.Future

class ExampleService {

    static transactional = false

    def mailService
    def httpExecutor
    def messageSource

    def findBrokenWebServices(Date start, Date end, long failureThreshold) {
        Example.executeQuery("from Example e where (select count(*) from ExampleRun f where f.example = e and f.start between :start and :end and (f.exceptionClass is not null or f.responseCode > 299)) > :threshold",
                ["start":start.time, "end": end.time, "threshold": failureThreshold])
    }

    def sendBrokenWebServicesDigest() {
        final today = DateUtils.truncate(new Date(), Calendar.DAY_OF_MONTH)
        final yesterday = today - 1
        final examples = findBrokenWebServices(yesterday, today, Holders.config.webapi.digest.threshold)
        if (examples) {
            mailService.sendMail {
                to Holders.config.webapi.support.email
                from Holders.config.grails.mail.default.from
                subject "Possible broken web services"
                body( view:"/digestmail/brokenServices",
                        model:[examples: examples])
            }
        }
    }

    /**
     * Removes all ExampleRun instances from the database which began at least daysAgo days ago.
     * @param daysAgo The number of days of ExampleRuns to keep
     * @return The number of records removed from the database
     */
    def removeOldExampleRuns(int daysAgo) {
        assert daysAgo >= 0
        def then = new Date() - daysAgo
        ExampleRun.where {
            lte "start", then.time
        }.deleteAll()
    }

    /**
     * Call Examples in the database that are marked machine callable and are side effect free.  All the results
     * are collected as ExampleRun instances and saved to the database
     * @return The results of calling each example.
     */
    @Transactional(readOnly = false)
    Iterable<ExampleRun> sendHeartbeatRequestToExamples() {
        final ExecutorCompletionService<Map<String,Object>> ecs = new ExecutorCompletionService<>(httpExecutor)

        // Find GET examples only, since they shouldn't cause side effects
        final Map<Long, Example> requests =
                Example.sideEffectFree().
                each {
                    callExample(it, ecs)  // queue a call to the web service on the completion service
                }.
                collectEntries {
                    [it.id, it] // map id to example for collecting results
                }

        final results = []
        for (int i=0; i < requests.size(); ++i) {
            log.debug "Taking ${i+1} of ${requests.size()} from queue"
            final result = ecs.take().get()
            final id = result.id
            final example = requests[id]
            final response = result.response
            def run = createExampleRun(response, example)
            saveOrLogValidationErrors(run)
            results << run
        }

        results
    }

    private ExampleRun createExampleRun(Timer<Try<HttpResponse>> response, Example example) {
        final start = response.start
        final end = response.end
        final run
        switch (response.value) {
            case Success:
                final HttpResponse value = response.value.value
                logErrorResponse(example, value)
                run = new ExampleRunResponse(example: example, url: value.url, responseCode: value.responseCode, contentType: value.contentType, body: value.body, start: start, end: end)
                break
            case Failure:
                final Exception exception = response.value.exception
                log.warn("Exception while performing heartbeat check for ${example}", exception)
                run = new ExampleRunFailure(example: example, url: example.queryUrl, exceptionClass: exception.class.name, message: exception.message, start: start, end: end)
                break
            default:
                run = null
                assert false
                break
        }
        run
    }

    /**
     * Call the URL for an Example and construct an ExampleRun from the results of calling that URL
     *
     * @param example The example to call
     * @return The ExampleRun for the call
     */
    ExampleRun callExample(Example example) {
        createExampleRun(Timer.time { Try.apply { callUrl(example.queryUrl.toURL()) } }, example)
    }

    /**
     * Calls the URL for the given Example, returning a Future that will contain a Map with keys 'id' and 'response'.
     * 'id' will return the id of the Example that created it and 'response will contain a Timer<Try<HttpResponse>>.
     *
     * @param example The example to run
     * @param executor The executor to run it on
     * @return The future that will contain the response.
     */
    Future<Map<String, Object>> callExample(Example example, CompletionService<Map<String, Object>> executor) {
        final queryUrl = example.queryUrl.toURL()
        final id = example.id
        log.debug("Queueing ${queryUrl} on ${executor}")
        executor.submit({
            return [id: id, response: Timer.time { Try.apply { callUrl(queryUrl) } }]
        } as Callable)
    }

    private HttpResponse callUrl(URL url) {
        log.debug("Calling ${url}")
        url.openConnection().asType(HttpURLConnection).with {
            use(TimeCategory) {
                connectTimeout = 60.seconds.toMilliseconds()  // TODO get from config?
                readTimeout = 5.minutes.toMilliseconds()
            }
            setRequestProperty("User-Agent", "ALA API Heart Beat")
            requestMethod = "GET"
            final stream
            if ((200..299).contains(responseCode)) {
                stream = inputStream
            } else {
                stream = errorStream
            }
            def bytes = stream.bytes
            def ct = contentType
            if (bytes.length > ExampleRunResponse.MAX_BODY_SIZE ) {
                ct = "text/plain; charset=utf-8"
                bytes = "body too large".getBytes(Charsets.UTF_8)
            }

            new HttpResponse(url.toString(), responseCode, ct, bytes)
        }
    }

    private void logErrorResponse(Example example, HttpResponse run) {
        if ((300..399).contains(run.responseCode)) {
            log.warn("Redirected while checking ${example}: ${run}")
        } else if (!(200..299).contains(run.responseCode)) {
            log.warn("Error response while checking ${example}: ${run}")
        } else {
            log.debug("Got response for ${example}: ${run}")
        }
    }

    /**
     * Save an example run or log the validation failures.
     * @param run The run to save
     * @return true if the ExampleRun saved or false if it's failed validation.
     */
    boolean saveOrLogValidationErrors(ExampleRun run) {
        final result = run.save(validate: true)
        if (!result) {
            log.error("${run.example} - ${run} is invalid and won't be saved\n\n Validation Errors:\n\n${run.errors.allErrors.collect { " * ${messageSource.getMessage(it, Locale.default)}" }.join("\n")}\n")
        }
    }
}
