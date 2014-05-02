package au.org.ala.webapi

class DigestMailJob {
    static triggers = {
        cron name:'oncePerDayAt5AM', startDelay:0, cronExpression: '0 5 5 * * ?' // execute job once per day at 05:05
        //simple repeatInterval: 30000
    }

    def exampleService

    def execute() {
        log.info("Running DigestMailJob")
        exampleService.sendBrokenWebServicesDigest()
        log.info("DigestMailJob complete")
    }
}