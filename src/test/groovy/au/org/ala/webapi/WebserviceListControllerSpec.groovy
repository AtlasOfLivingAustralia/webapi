package au.org.ala.webapi

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

import au.org.ala.web.AuthService

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(WebserviceListController)
@Mock([WebService, App, AuthService, ListCacheService])
class WebserviceListControllerSpec extends Specification {

    def authService = Mock(AuthService)
    def listCacheService = Mock(ListCacheService)

    void setup() {
        controller.authService = authService
        controller.listCacheService = listCacheService
    }

    void "Test byCategory"() {

        when:
        controller.byCategory()

        then:
        view == '/webserviceList/byCategory'
        !model.wsByGroup
        model.byCategory == true
    }

    void "Test byApp"() {
        setup:
        params["name"] = "appName"
        params["webservices"] = Mock(WebService)
        App app = new App(params)
        app.save(flush:true)

        when:
        controller.byApp()

        then:
        view == '/webserviceList/byApp'
        model.wsByGroup
        model.byCategory == false
    }

    void "Test bySpecificApp"() {
        setup:
        params["name"] = "appName"
        params["webservices"] = Mock(WebService)
        App app = new App(params)
        app.save(flush:true)

        when:
        params["name"] = "appName"
        controller.bySpecificApp()

        then:
        view == '/webserviceList/byApp'
        model.wsByGroup
        model.byCategory == false
    }
}
