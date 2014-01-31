package au.org.ala.webapi

class ExampleParam {

    Param param
    String value = ""
    Date dateCreated
    Date lastUpdated

    static belongsTo = [example:Example, param:Param]

    String toString(){
       param.name + "=" + value
    }

    static constraints = {
        param(nullable:false)
        value(nullable:false)
    }
}
