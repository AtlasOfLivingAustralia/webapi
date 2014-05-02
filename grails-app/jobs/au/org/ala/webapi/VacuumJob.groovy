package au.org.ala.webapi

/**
 * Created by bea18c on 24/04/2014.
 */
class VacuumJob {

    static triggers = {
        cron name:'oncePerDayAt1AM', startDelay:0, cronExpression: '0 13 1 * * ?' // execute job once per day at 01:13
        //simple repeatInterval: 30000
    }

    def exampleService

    def execute() {
        log.info("Running VacuumJob")
        def n = exampleService.removeOldExampleRuns(7)
        log.info("VacuumJob complete, removed ${n} ExampleRun objects from database")
    }

}
