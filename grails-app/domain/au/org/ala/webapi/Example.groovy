package au.org.ala.webapi

class Example {

    String name
    String description = ""    // use markdown
    WebService webService
    String urlPath = ""
    String onlineViewer = ""
    boolean machineCallable = true
    Date dateCreated
    Date lastUpdated

    static def sideEffectFree(boolean machineCallable = true) {
        Example.executeQuery("select e from Example e join e.webService ws where 'GET' in elements(ws.httpMethod) and e.machineCallable = :callable", [callable: machineCallable])
    }

    static hasMany = [params:ExampleParam, runs:ExampleRun]
    static belongsTo = [webService: WebService]

    def getSortedParams(){
        params.sort { it.id }
    }

    def getQueryUrl(){

        if(urlPath){
            this.webService.app.baseUrl + this.urlPath
        } else {
            def paramString = ""

            if(this.webService.httpMethod.contains("GET")){
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
            this.webService.app.baseUrl + this.webService.url + paramString
        }
    }

    String toString(){
        return name
    }

    static constraints = {
        name(nullable:false)
        description(nullable:false, widget: 'textarea')
        urlPath(nullable:true, maxSize: Integer.MAX_VALUE)
        onlineViewer(nullable:true)
    }

    static mapping = {
      description type: 'text'
      urlPath type: 'text'
      machineCallable default: true
      params cascade: "all-delete-orphan"
      runs cascade: "all-delete-orphan"
    }
}
