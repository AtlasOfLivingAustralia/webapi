package au.org.ala.webapi

import grails.test.mixin.Mock
import grails.test.mixin.TestFor

@TestFor(ExampleController)
@Mock(Example)
class ExampleControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/example/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.exampleInstanceList.size() == 0
        assert model.exampleInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.exampleInstance != null
    }

    void testSave() {
        controller.save()

        assert model.exampleInstance != null
        assert view == '/example/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/example/show/1'
        assert controller.flash.message != null
        assert Example.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/example/list'

        populateValidParams(params)
        def example = new Example(params)

        assert example.save() != null

        params.id = example.id

        def model = controller.show()

        assert model.exampleInstance == example
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/example/list'

        populateValidParams(params)
        def example = new Example(params)

        assert example.save() != null

        params.id = example.id

        def model = controller.edit()

        assert model.exampleInstance == example
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/example/list'

        response.reset()

        populateValidParams(params)
        def example = new Example(params)

        assert example.save() != null

        // test invalid parameters in update
        params.id = example.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/example/edit"
        assert model.exampleInstance != null

        example.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/example/show/$example.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        example.clearErrors()

        populateValidParams(params)
        params.id = example.id
        params.version = -1
        controller.update()

        assert view == "/example/edit"
        assert model.exampleInstance != null
        assert model.exampleInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/example/list'

        response.reset()

        populateValidParams(params)
        def example = new Example(params)

        assert example.save() != null
        assert Example.count() == 1

        params.id = example.id

        controller.delete()

        assert Example.count() == 0
        assert Example.get(example.id) == null
        assert response.redirectedUrl == '/example/list'
    }
}
