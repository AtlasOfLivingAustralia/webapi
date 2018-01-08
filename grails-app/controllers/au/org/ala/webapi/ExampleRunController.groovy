package au.org.ala.webapi

import org.grails.web.util.GrailsApplicationAttributes

class ExampleRunController {

    def response(Long id) {
        def exampleRunInstance = ExampleRunResponse.get(id)
        if (!exampleRunInstance) {
            render(status: 404)
            return
        }

        // Disable Grails View Rendering for this request, which will interfere with HTML responses
        def webRequest = request.getAttribute(GrailsApplicationAttributes.WEB_REQUEST)
        webRequest.setRenderView(false)

        response.contentType = exampleRunInstance.contentType
        response.outputStream << exampleRunInstance.body
        response.outputStream.flush()
    }

}
