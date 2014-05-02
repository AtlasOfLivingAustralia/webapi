package au.org.ala.webapi

import groovy.transform.ToString

@ToString(excludes="body")
class ExampleRunResponse extends ExampleRun {

    final static def MAX_BODY_SIZE = 65536 // bytes

    int responseCode
    String contentType
    byte[] body // TODO Does this actually need to be persisted?

    static constraints = {
        responseCode(range: 100..599)
        body(nullable: false, maxSize: MAX_BODY_SIZE)
    }

}
