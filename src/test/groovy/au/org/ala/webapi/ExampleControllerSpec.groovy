package au.org.ala.webapi

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.*

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(ExampleController)
@Mock(Example)
class ExampleControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Test index"() {
        when:
        controller.index()

        then:
        !model.exampleList
        model.exampleCount == 0
    }

    void "Test show non-exist Example re-directs to list"() {
        when:
        controller.show()

        then:
        response.redirectedUrl == '/example/index'
    }

    void "Test show existing Example returns the correct Example"() {
        when:
        params["webService"] = Mock(WebService)
        params["name"] = 'someValidName'
        params["description"] = 'description'
        def example = new Example(params)
        example.save()

        params.id = example.id
        def model = controller.show()

        then:
        model.example == example
    }

    void "Test update without providing entity"() {
        when:
        controller.update()

        then:
        response.redirectedUrl == "/example/index"
    }

    void "Test update valid values"() {
        when:
        params["webService"] = Mock(WebService)
        params["name"] = 'someValidName'
        params["description"] = 'description'
        def example = new Example(params)
        example.save()

        params.id = example.id
        params["description"] = 'updated description'
        controller.update()

        then:
        response.redirectedUrl == "/example/show/$example.id"
    }

    void "Test update outdated version number"() {
        when:
        params["webService"] = Mock(WebService)
        params["name"] = 'someValidName'
        params["description"] = 'description'
        params["version"] = 0
        def example = new Example(params)
        example.save(flush: true)

        params.id = example.id
        params.version = -1
        controller.update()

        then:
        view == "/example/edit"
        model.example != null
    }

}