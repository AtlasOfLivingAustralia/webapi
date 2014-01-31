package au.org.ala.webapi

class App {

    String name
    String description = "To be added" // use markdown
    String baseUrl = "http://"
    Date dateCreated
    Date lastUpdated

    static hasMany = [webservices:WebService]

    String toString(){
        return name
    }

    static constraints = {
        name(nullable:false)
        description(nullable:false, maxSize: 2000)
    }
}
