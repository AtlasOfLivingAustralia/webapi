package au.org.ala.webapi

import grails.test.mixin.TestFor
import spock.lang.Shared
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(ExampleRunResponse)
class ExampleRunResponseSpec extends Specification {

    static long MAX_SIZE = ExampleRunResponse.MAX_BODY_SIZE

    @Shared Example example = new Example(name: "Example")

    @Unroll
    void 'Test validate with response code #responseCode is #valid'() {
        expect:
        responseWithCode(responseCode).validate() == valid

        where:
        responseCode    | valid
        99              | false
        600             | false
        359             | true
    }

    @Unroll
    void 'Test validate with content type #contentType is #valid'() {
        expect:
        responseWithContentType(contentType).validate() == valid

        where:
        contentType | valid
        null        | false
//        ""          | true
        "application/hal+json"| true
    }

    @Unroll
    void 'Test validate with body of size #bytes.length is #validity'() {
        expect:
        responseWithBody(bytes).validate() == valid

        where:
        bytes                 | valid | validity
        null                  | false | "invalid"
        new byte[0]           | true  | "valid"
        new byte[10240]       | true  | "valid"
        new byte[MAX_SIZE]    | true  | "valid"
        new byte[MAX_SIZE+1]  | false | "invalid"
    }

    def responseWithBody(byte[] bytes) {
        new ExampleRunResponse(example: example, url: "http://www.ala.org.au", responseCode: 200, body: bytes, contentType: "text/plain", start: 0, end: 0)
    }

    def responseWithContentType(String contentType) {
        new ExampleRunResponse(example: example, url: "http://www.ala.org.au", responseCode: 200, body: "{}".bytes, contentType: contentType, start: 0, end: 0)
    }

    def responseWithCode(int code) {
        new ExampleRunResponse(example: example, url: "http://www.ala.org.au", responseCode: code, body: "{}".bytes, contentType: "text/plain", start: 0, end: 0)
    }

}