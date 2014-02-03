import au.org.ala.webapi.Example
import au.org.ala.webapi.ExampleParam
import au.org.ala.webapi.WebService

class BootStrap {

    def addCategory(name, description){
        def category = au.org.ala.webapi.Category.findByName(name)
        if(!category){
            category = new au.org.ala.webapi.Category([name:name, description:description])
            category.save(flush:true)
        }
        category
    }

    def addApp(name, description, baseUrl){
        def app =  au.org.ala.webapi.App.findByName(name)
        if(!app){
            app = new au.org.ala.webapi.App([name:name, description:description, baseUrl:baseUrl])
            app.save(flush:true)
        }
        app
    }

    def addWebservice(app, name, description, url, List categories){
        def webService = au.org.ala.webapi.WebService.findByName(name)
        if(!webService){
            webService = new au.org.ala.webapi.WebService([app: app, name:name, description:description, url:url])
            webService.save(flush:true)
            webService.categories = categories
            webService.save(flush:true)
        }

        webService
    }

    def addParam(WebService webService, name, description, type){
        def param = au.org.ala.webapi.Param.findByWebServiceAndName(webService, name)
        if(!param){
            param = new au.org.ala.webapi.Param([webService:webService, name:name, description:description, type:type])
            param.save(flush:true)
            if(param.hasErrors()){
               param.errors.each { println it }
            }
        } else {
            log.debug(webService.toString() + " : " + name + " - already exists....")
        }
        param
    }

    def addEndemismParams(WebService webService){

        addParam(webService,'q', """The initial query. q=*:* will query anything, q=macropus will do a free text search for macropus,
                q=kingdom:Fungi will search for records with a kingdom of Fungi.
                For a listing of the fields that can be queried in a q=INDEXEDFIELD:VALUE fashion, see /index/fields.
                This will restrict the records that are considered in then region.
                For example this could allow people to restrict the service to endemic birds.""",'String')
        addParam(webService,'fq',"""Filters to be applied to the original query. These are additional params of the form fq=INDEXEDFIELD:VALUE e.g. fq=kingdom:Fungi.
                Again, see /index/fields for all the fields that a queryable.""",'String')
        addParam(webService, 'wkt', """The Well Known Text Area in which to provide the endemic species.""",'String')
        addParam(webService, 'facets', """The field on which to based the species list. This can be taxon_concept_lsid or species_guid""",'String')
    }


    def addOccurrenceParams(WebService webService){
        addParam(webService, 'q', 'Query of the form field:value e.g. q=genus:Macropus or a free text search e.g. q=Macropus', 'String')
        addParam(webService, 'fq', 'Filter query of the form field:value e.g. q=genus:Macropus', 'String')
        addParam(webService, 'facet', """Supported values are "off" or "on". By default, its "on". This is worth switching off if facetting is not required, to reduce the JSON being sent.""", 'String')
        addParam(webService, 'facets', 'Comma separated list of the fields to create facets on e.g. facets=basis_of_record.', 'String')
        addParam(webService, 'pageSize', 'Number of records to return', 'Integer')
        addParam(webService, 'startIndex', 'Record offset, to enable paging', 'Integer')
        addParam(webService, 'sort', 'The indexed field to sort by', 'Integer')
        addParam(webService, 'dir', """Supports "asc" or "desc" """, 'Integer')
        addParam(webService, 'flimit', 'Maximum number of facet values to return', 'Integer')
        addParam(webService, 'fsort', """Method in which to sort the facets either "count" or "index" """, 'Integer')
        addParam(webService, 'foffset', """Facet offset, to enable paging""", 'Integer')
        addParam(webService, 'fprefix', """Limits facets to values that start with the supplied value""", 'Integer')
        addParam(webService, 'lat', 'The decimal latitude to limit records to. Use with lon and radius to specify a "search" circle', 'Double')
        addParam(webService, 'lon', 'The decimal latitude to limit records to. Use with lon and radius to specify a "search" circle', 'Double')
        addParam(webService, 'radius', 'The radius in which to limit records (relative to the lat, lon point). Use with lat and lon to specify a "search" circle.', 'Double')
        addParam(webService, 'wkt', 'The polygon area in which to limit records. For information on Well known text', 'Integer')
    }

    def addSpeciesParams(WebService webService){
        addParam(webService, 'q', """Query of the form field:value e.g. q=genus:Macropus or a free text search e.g. q=Macropus """, 'String')
        addParam(webService, 'fq', """Filter query of the form field:value e.g. q=genus:Macropus""", 'String')
    }

    def addExample(au.org.ala.webapi.WebService webService, String name, List params){
       def example = new Example([webService:webService, name:name])
       example.save(flush:true)

       params.each {
           def param = au.org.ala.webapi.Param.findByWebServiceAndName(webService, it.name)
           if(param){
             new ExampleParam([example:example,param:param,value:it.value]).save(flush:true)
           } else {
               log.debug "Couldnt find param for webservice: " + webService + ", with name "+ it.name
           }
       }
    }

    def init = { servletContext ->

        //apps
        def biocache = addApp("Biocache", "Occurrence & Mapping services", "http://biocache.ala.org.au/ws")
        def bvp = addApp("BVP", "Crowd sourcing", "http://volunteer.ala.org.au")
        def analysis = addApp("Analysis", "Spatial analysis","http://spatial.ala.org.au/alaspatial/ws")
        def layers = addApp("Layers", "Layer services including intersect","http://spatial.ala.org.au/ws")
        def bie = addApp("BIE", "Species names and profiles", "http://bie.ala.org.au/ws")
        def ecodata = addApp("Ecodata", "Occurrence & Mapping services", "http://ecodata.ala.org.au")
        def lists = addApp("Lists", "Species lists", "http://lists.ala.org.au/ws")

        //categories
        def species = addCategory("Species profile", "Taxonomic name, concept lookups, autocomplete services ")
        def occurrence = addCategory("Occurrence", "Specimen & observation data searching")
        def geospatial = addCategory("Geospatial", "Including intersection services and gazetteer information")
        def mapping = addCategory("Mapping", "Creating maps with WMS services, static heat maps")
        def endemism = addCategory("Endemism", "Services for reports on endemism for an area")
        def duplicates = addCategory("Data duplication", "Reports on the details of a duplication detection")
        def parsing = addCategory("Parsing", "Services for parsing ad hoc occurrence data")
        def dq = addCategory("Data quality", "Services for reporting on data quality for records")
        def outliers = addCategory("Outlier detection", "Reporting the on outlier details for records")
        def literature = addCategory("Literature", "Biodiversity Heritage Library free text search")
        def collectionsMetadata = addCategory("Collections", "Collections metadata including taxonomic scope, attribution")
        def dataResourcesMetadata = addCategory("Data resources", "Data resource metadata including taxonomic scope, attribution")
        def dataProvidersMetadata = addCategory("Data providers", "Data provider metadata including taxonomic scope, attribution")
        def institutionMetadata = addCategory("Institution", "Institution metadata including taxonomic scope, attribution")
        def crowdsourcing = addCategory("Crowd sourcing", "Crowd sourcing information")

        //species
        def speciesSearch = addWebservice(bie, "Species search", "JSON species search", "/search", [species])
        addSpeciesParams(speciesSearch)
        def speciesDownload = addWebservice(bie, "Species download", "JSON species download", "/species/download", [species])
        addSpeciesParams(speciesDownload)

        //occurrence
        def occurrenceSearch = addWebservice(biocache, "Occurrence search", "JSON occurrence search", "/occurrences/search", [occurrence])
        addOccurrenceParams(occurrenceSearch)

        def occurrenceDownload = addWebservice(biocache, "Occurrence download", "CSV occurrence download", "/occurrences/download",  [occurrence])
        addOccurrenceParams(occurrenceDownload)

        //density map
        def densityMap = addWebservice(biocache, "Static heat map ", "JSON species search", "/density/map", [mapping])
        addOccurrenceParams(densityMap)

        //WMS GetCapabilities
        def getCapabilities = addWebservice(biocache, "WMS GetCapabilities", "", "/ogc/ows", [mapping])
        addOccurrenceParams(getCapabilities)

        def getMetadata = addWebservice(biocache, "WMS GetMetadata", "Returns Marine community Profile XML", "/ogc/getMetadata", [mapping])
        addOccurrenceParams(getMetadata)

        def getFeatureInfo = addWebservice(biocache, "WMS GetFeatureInfo", "", "/ogc/getFeatureInfo", [mapping])
        addOccurrenceParams(getFeatureInfo)

        def getMap = addWebservice(biocache, "WMS GetMap", "", "/mapping/wms/reflect", [mapping])
        addOccurrenceParams(getMap)

        def legend = addWebservice(biocache, "WMS Legend", "", "/mapping/legend", [mapping])
        addOccurrenceParams(legend)

        //layers
        def layersWS = addWebservice(layers, "Layers listing", "Get a list of all layers", "/layers", [geospatial])
        def layersGridded = addWebservice(layers, "Gridded layers listing", "Get a list of all environmental/gridded layers", "/layers/grids", [geospatial])
        def layersShapes = addWebservice(layers, "Shape layers listing", "Get a list of all  contextual layers (e.g. political boundaries)", "/layers/shapes", [geospatial])

        //gazetteer

        //endemism
        def e1 = addWebservice(biocache, "Count endemic species", "Count of distinct endemic species within an area", "/explore/counts/endemic", [endemism])
        addEndemismParams(e1)
        def e2 = addWebservice(biocache, "Endemic Species list", "List endemic species within an area", "/explore/endemic/species", [endemism])
        addEndemismParams(e2)
        def e3 = addWebservice(biocache, "Endemic Species list (CSV)", "List endemic species within an area", "/explore/endemic/species.csv", [endemism])
        addEndemismParams(e3)

        //validation rules


        //volunteer portal
        addWebservice(bvp, "Expeditions", "Listing of expeditions in volunteer portal", "/ajax/expeditionInfo", [crowdsourcing])
        addWebservice(bvp, "User contributions", "Listing of user contributions in volunteer portal", "/ajax/stats", [crowdsourcing])
        addWebservice(bvp, "Transcriptions", "Number of transcriptions per month in volunteer portal", "/ajax/statsValidationsByMonth", [crowdsourcing])
        addWebservice(bvp, "Validation", "Validations per month in volunteer portal", "/ajax/statsTranscriptionsByMonth", [crowdsourcing])
        def taskInfo = addWebservice(bvp, "Task information", "Information for a specific task in volunteer portal", "/ajax/taskInfo", [crowdsourcing])
        addParam(taskInfo, 'taskId', 'The identifier for the task', 'String')
        addWebservice(bvp, "User report", "Validations per month in volunteer portal (requires privileges", "/ajax/userReport", [crowdsourcing])

        //examples
        addExample(occurrenceSearch, "Search for the records for the genus Macropus", [ [name:"q", value:"genus:Macropus"] ])
    }

    def destroy = {
    }
}
