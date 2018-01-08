package au.org.ala.webapi

class BootStrap {

    def addFormats() {
        def f = ['json', 'csv', 'zip', 'xml', 'png', 'jpg', 'kml', 'kmz', 'shp', 'gzip', 'eml', 'rif-cs', 'rdf+xml', 'text', 'wkt', 'wfs', 'mcp', 'dwc-a']
        f.each {
            def ff = Format.findByName(it)
            if (!ff) {
                new Format(name: it).save(flush: true)
            }
        }
    }

    def init = { servletContext ->
        addFormats()
    }
    def destroy = {
    }
}
