package au.org.ala.webapi

import grails.test.mixin.Mock
import grails.test.mixin.TestFor

@TestFor(WebServiceController)
@Mock(WebService)
class WebServiceControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/webService/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.webServiceInstanceList.size() == 0
        assert model.webServiceInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.webServiceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.webServiceInstance != null
        assert view == '/webService/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/webService/show/1'
        assert controller.flash.message != null
        assert WebService.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/webService/list'

        populateValidParams(params)
        def webService = new WebService(params)

        assert webService.save() != null

        params.id = webService.id

        def model = controller.show()

        assert model.webServiceInstance == webService
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/webService/list'

        populateValidParams(params)
        def webService = new WebService(params)

        assert webService.save() != null

        params.id = webService.id

        def model = controller.edit()

        assert model.webServiceInstance == webService
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/webService/list'

        response.reset()

        populateValidParams(params)
        def webService = new WebService(params)

        assert webService.save() != null

        // test invalid parameters in update
        params.id = webService.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/webService/edit"
        assert model.webServiceInstance != null

        webService.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/webService/show/$webService.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        webService.clearErrors()

        populateValidParams(params)
        params.id = webService.id
        params.version = -1
        controller.update()

        assert view == "/webService/edit"
        assert model.webServiceInstance != null
        assert model.webServiceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/webService/list'

        response.reset()

        populateValidParams(params)
        def webService = new WebService(params)

        assert webService.save() != null
        assert WebService.count() == 1

        params.id = webService.id

        controller.delete()

        assert WebService.count() == 0
        assert WebService.get(webService.id) == null
        assert response.redirectedUrl == '/webService/list'
    }
}
