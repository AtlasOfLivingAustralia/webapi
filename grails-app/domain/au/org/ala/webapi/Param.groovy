package au.org.ala.webapi

class Param {

    String name
    String description
    String type = 'String'
    Boolean mandatory = false
    Boolean deprecated = false
    Boolean includeInTitle = false
    Boolean restfulParam = false
    String format = ''  // for dates eg. yyyy-mm-dd
    Date dateCreated
    Date lastUpdated

    String toString(){
        return name + ": " + type
    }

    static hasMany = [exampleParams:ExampleParam]

    static belongsTo = [webService:WebService]

    static paramTypes = ['String','Integer','Date', 'Double','Boolean']

    static constraints = {
        webService(nullable:false)
        name(nullable:false)
        description(nullable:true)
        type(nullable: false, inList: ['String', 'Integer', 'Date', 'Double', 'Boolean'])
        format(nullable:true)
    }

    static mapping = {
      description type: 'text'
      exampleParams cascade: "all-delete-orphan"
    }
}
