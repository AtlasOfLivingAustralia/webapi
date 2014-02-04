package au.org.ala.webapi

class Example {

    String name
    String description = ""    // use markdown
    WebService webService
    Date dateCreated
    Date lastUpdated

    static hasMany = [params:ExampleParam]

    def getSortedParams(){
        params.sort { it.id }
    }

    def getQueryUrl(){

        def paramString = ""

        if(webService.httpMethod == "GET"){
            if(params){
               params.eachWithIndex { elem, idx ->
                 if(idx == 0){
                     paramString = "?"
                 } else {
                     paramString = paramString + "&"
                 }
                 paramString = paramString + elem.param.name + "=" + elem.value
               }
            }
        }
        webService.app.baseUrl + webService.url + paramString
    }

    String toString(){
        return name
    }

    static constraints = {
        name(nullable:false)
        description(nullable:false)
    }

    static mapping = {
      description type: 'text'
      params cascade: "all-delete-orphan"
    }
}
