package au.org.ala.webapi

class WebService {

    String name
    String description = "."
    String url = "" // excluding the baseUrl
    Boolean deprecated = false
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

        if(httpMethod.contains("GET")){
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
//                fetchMode 'params', FetchMode.JOIN
//                fetchMode 'outputFormat', FetchMode.JOIN
//                fetchMode 'httpMethod', FetchMode.JOIN
//                fetchMode 'examples', FetchMode.JOIN
            }
        }
    }

    static hasMany = [outputFormat:String, httpMethod: String, params:Param, examples:Example, categories:Category]

    static httpMethods = ['GET','POST','PUT','DELETE','HEAD']

    static constraints = {
        name(nullable:false)
        description(nullable: true, maxSize: Integer.MAX_VALUE, widget: 'textarea')
        url(nullable:false)
        deprecated(nullable:false)
        exampleOutput(nullable: true, maxSize: Integer.MAX_VALUE, widget: 'textarea')
    }

    static mapping = {
      description type: 'text'
      params cascade: "all-delete-orphan"
    }
}
