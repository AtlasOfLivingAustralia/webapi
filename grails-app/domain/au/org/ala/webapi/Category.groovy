package au.org.ala.webapi

class Category {

    String name
    String description

    String toString(){
        return name
    }

    static constraints = {
        name(nullable:false)
        description(nullable:true)
    }

    static mapping = {
      description type: 'text'
    }
}
