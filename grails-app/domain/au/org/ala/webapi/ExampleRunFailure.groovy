package au.org.ala.webapi

import groovy.transform.ToString

@ToString
class ExampleRunFailure extends ExampleRun {

    final static def MAX_MESSAGE_SIZE = 2000 // chars

    String exceptionClass
    String message // from exception

    static constraints = {
        exceptionClass(blank: false)
        message(nullable: false, maxSize: MAX_MESSAGE_SIZE)
    }
}
