package au.org.ala.webapi

class WebService {

    App app
    String name
    String description = "To be added..."
    String url = "" // excluding the baseUrl
    String httpMethod = "GET"
    Boolean deprecated = false
    String outputFormat = "json"

    Date dateCreated
    Date lastUpdated

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

    static format = ['json', 'png', 'csv', 'zip', 'xml', 'jpg']

    static constraints = {
        name(nullable:false)
        description(nullable:false, maxSize: 2000)
        url(nullable:false)
        httpMethod(nullable:false)
        deprecated(nullable:false)
        httpMethod(nullable:false, inList:httpMethods)
        outputFormat(nullable:false, inList:format)
    }

    static mapping = {
      description type: 'text'
    }
}
