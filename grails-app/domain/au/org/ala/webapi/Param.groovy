package au.org.ala.webapi

class Param {

    String name
    String description
    String type = 'String'
    Boolean mandatory = false
    Boolean includeInTitle = false
    String format = ''  // for dates eg. yyyy-mm-dd
    Date dateCreated
    Date lastUpdated

    String toString(){
        return name + ": " + type
    }

    static belongsTo = [webService:WebService]

    static paramTypes = ['String','Integer','Date', 'Double']

    static constraints = {
        webService(nullable:false)
        name(nullable:false)
        description(nullable:true)
        type(nullable:false, inList: paramTypes)
        format(nullable:true)
    }

    static mapping = {
      description type: 'text'
    }
}
