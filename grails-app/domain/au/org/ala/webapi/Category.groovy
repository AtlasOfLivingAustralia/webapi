package au.org.ala.webapi

class Category {

    String name
    String shortDescription = ""
    String description = ""

    String toString(){
        return name
    }

    static constraints = {
        name(nullable:false)
        shortDescription(nullable:false, maxSize: 200)
        description(nullable: false, maxSize: 2000, widget: 'textarea')
    }

    static mapping = {
      description type: 'text'
    }
}
