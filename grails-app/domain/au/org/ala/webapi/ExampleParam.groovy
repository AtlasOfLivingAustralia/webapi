package au.org.ala.webapi

class ExampleParam {

    Param param
    String value = ""
    Date dateCreated
    Date lastUpdated

    static belongsTo = [example:Example]

    String toString(){
       param.name + "=" + value
    }

    static constraints = {
        param(nullable:false)
        value(nullable:false)
    }
}
