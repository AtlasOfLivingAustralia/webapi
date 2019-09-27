package au.org.ala.webapi

import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.*

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@TestFor(App)
class AppSpec extends Specification {

    def app
    def setup() {
        app = new App(name: 'someName', shortDescription: 'short', description: 'desc').save(flush: true)
    }

    def cleanup() {
        app = null
    }

    void 'test App saved' () {
        expect:
        App.count() == 1
    }

    void 'test name cannot be null'() {
        when:
        domain.name = null

        then:
        !domain.validate(['name'])
        domain.errors['name'].code == 'nullable'
    }

    void 'test shortDescription cannot be null'() {
        when:
        domain.shortDescription = null

        then:
        !domain.validate(['shortDescription'])
        domain.errors['shortDescription'].code == 'nullable'
    }

    void 'test description cannot be null'() {
        when:
        domain.description = null

        then:
        !domain.validate(['description'])
        domain.errors['description'].code == 'nullable'
    }
}