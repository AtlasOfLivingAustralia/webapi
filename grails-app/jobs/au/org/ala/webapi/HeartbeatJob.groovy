package au.org.ala.webapi

import org.quartz.JobExecutionContext

class HeartbeatJob {
    static triggers = {
        cron name:'oncePerHour', startDelay:0, cronExpression: '0 29 * * * ?' // execute job once per hour
        //simple repeatInterval: 30000
    }

    // prevents concurrent execution by Quartz
    def concurrent = false

    def exampleService

    def execute(JobExecutionContext context) {
        log.info("Running HeartbeatJob")

        exampleService.sendHeartbeatRequestToExamples()

        log.info("HeartbeatJob complete")
    }

}
