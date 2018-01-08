package au.org.ala.webapi

class App {

    String name
    String shortDescription = ""
    String description = "" // use markdown
    String baseUrl = "http://"
    Date dateCreated
    Date lastUpdated

    static hasMany = [webservices:WebService]

    String toString(){
        return name
    }

    static constraints = {
        name(nullable:false)
        shortDescription(nullable:false, maxSize: 200)
        description(nullable: false, maxSize: 2000, widget: 'textarea')
    }
}
