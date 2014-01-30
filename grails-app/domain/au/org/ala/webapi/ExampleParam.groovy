package au.org.ala.webapi

class ExampleParam {

    Example example
    Param param
    String value
    Date dateCreated
    Date lastUpdated

    String toString(){
       param.name + "=" + value
    }

    static constraints = {
        param(nullable:false)
        value(nullable:false)
    }
}
