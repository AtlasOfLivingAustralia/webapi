package au.org.ala.webapi

import grails.test.mixin.TestFor
import grails.test.mixin.Mock
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(CategoryController)
@Mock(Category)
class CategoryControllerSpec extends Specification {

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.appList
        model.categoryCount == 0
    }
}
