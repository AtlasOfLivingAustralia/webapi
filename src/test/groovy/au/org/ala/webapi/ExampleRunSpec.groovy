package au.org.ala.webapi

import grails.test.mixin.TestFor
import spock.lang.Shared
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(ExampleRun)
class ExampleRunSpec extends Specification {

    @Shared Example example = new Example(name: "Example")

    @Unroll
    void 'Test url #url is #validity'() {
        expect:
        runWithUrl(url).validate() == valid

        where:
        url                 | valid | validity
        null                | false | "invalid"
        "http://google.com" | true  | "valid"
        'http://biocache.ala.org.au/ws/ogc/ows?q=genus:Macropus' | true | "valid"
        'http://bie.ala.org.au/ws/species/urn:lsid:biodiversity.org.au:afd.taxon:aa745ff0-c776-4d0e-851d-369ba0e6f537.json?callback=myJsonpCallback' | true | "valid"
    }

    @Unroll
    void 'Test #end ms the same time as or after #start ms is #validity'() {
        expect:
        runWithTimes(start, end).validate() == valid

        where:
        start   | end   | valid | validity
        1000    | 0     | false | "invalid"
        1000    | 1000  | true  | "invalid"
        1000    | 2000  | true  | "valid"
    }

    def runWithTimes(long start, long end) {
        new ExampleRun(example: example, url: "http://www.ala.org.au", start: start, end: end)
    }

    def runWithUrl(String url) {
        new ExampleRun(example: example, url: url, start: 1000, end: 2000)
    }
}
