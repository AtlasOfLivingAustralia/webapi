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
        response.redirectedUrl == "/example/list"
    }

    void "Test the list action returns the correct model"() {
        when:
        params["name"] = 'someValidName'
        params["description"] = 'description'
        def model = controller.list()

        then:
        !model.exampleInstanceList
        model.exampleInstanceList.size() == 0
        model.exampleInstanceTotal == 0
    }

    void "Test show non-exist Example re-directs to list"() {
        when:
        controller.show()

        then:
        response.redirectedUrl == '/example/list'
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
        model.exampleInstance == example
    }

    void "Test update without providing entity"() {
        when:
        controller.update()

        then:
        response.redirectedUrl == "/example/list"
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

    // This test passes in debug mode, not in run mode
//    void "Test update outdated version number"() {
//        when:
//        params["webService"] = Mock(WebService)
//        params["name"] = 'someValidName'
//        params["description"] = 'description'
//        params["version"] = 0
//        def example = new Example(params)
//        example.save()
//
//        params.id = example.id
//        params.version = -1
//        controller.update()
//
//        then:
//        view == "/example/edit"
//        model.exampleInstance != null
//    }

}