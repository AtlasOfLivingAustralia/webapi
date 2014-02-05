package au.org.ala.webapi

class WebService {

    String name
    String description = "."
    String url = "" // excluding the baseUrl
    String httpMethod = "GET"
    Boolean deprecated = false
    String outputFormat = "json"
    String exampleOutput = ""

    Date dateCreated
    Date lastUpdated

    static belongsTo = [app:App]

    String toString(){
        return name
    }

    def getSortedParams(){
        params.sort { it.id }
    }

    def getQueryUrl(){

        def paramString = ""

        if(httpMethod == "GET"){
            def params = Param.findAllByWebServiceAndIncludeInTitle(this, true)
            if(params){
               params.eachWithIndex { elem, idx ->
                 if(idx == 0){
                     paramString = "?"
                 } else {
                     paramString = paramString + "&"
                 }
                 paramString = paramString + elem.name + "={"  + elem.name +"}"
               }
            }
        }
        app.baseUrl + url + paramString
    }

    static def getByCategory(Category category){
        WebService.withCriteria{
            categories {
                eq('id', category.id)
            }
        }
    }


    static hasMany = [params:Param, examples:Example, categories:Category]

    static httpMethods = ['GET','POST','PUT','DELETE']

    static format = ['json', 'png', 'csv', 'zip', 'xml', 'jpg', 'kml', 'shp', 'gzip', 'eml', 'rif-cs','rdf+xml','text', 'wkt']

    static constraints = {
        name(nullable:false)
        description(nullable:false, maxSize: 2000)
        url(nullable:false)
        httpMethod(nullable:false)
        deprecated(nullable:false)
        httpMethod(nullable:false, inList:httpMethods)
        outputFormat(nullable:false, inList:format)
        exampleOutput(nullable:false, maxSize: 2000)
    }

    static mapping = {
      description type: 'text'
      params cascade: "all-delete-orphan"
    }
}
