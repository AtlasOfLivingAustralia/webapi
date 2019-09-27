package au.org.ala.webapi

import grails.test.mixin.TestFor
import spock.lang.Shared
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(ExampleRunFailure)
class ExampleRunFailureSpec extends Specification {

    static long MAX_SIZE = ExampleRunFailure.MAX_MESSAGE_SIZE

    @Shared Example example = new Example(name: "Example")

    @Shared def largeMessage
    @Shared def veryLargeMessage

    def setup() {
        def chars = new char[MAX_SIZE]
        Arrays.fill(chars, 'a' as char)
        largeMessage = new String(chars)
        chars = new char[MAX_SIZE+1]
        Arrays.fill(chars, 'a' as char)
        veryLargeMessage = new String(chars)
    }

    @Unroll
    void 'Test validate with exception class #exceptionClass is #valid'() {
        expect:
        failureWithExceptionClass(exceptionClass).validate() == valid

        where:
        exceptionClass  | valid
        null            | false
        ""              | false
        "au.org.ala.CrazyException"| true
    }

    @Unroll
    void 'Test validate with message'() {
        expect:
        failureWithMessage(message).validate() == valid

        where:
        message             | valid
        null                | false
//        ""                  | true
        "hullo there this is a reasonably sized message"| true
        largeMessage        | true
        veryLargeMessage    | false
    }

    def failureWithMessage(message) {
        new ExampleRunFailure(example: example, start: 1, end: 2, url: "http://google.com", exceptionClass: "au.org.ala.CrazyException", message: message)
    }


    def failureWithExceptionClass(exceptionClass) {
        new ExampleRunFailure(example: example, start: 1, end: 2, url: "http://google.com", exceptionClass: exceptionClass, message: "hello")
    }
}
