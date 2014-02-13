package au.org.ala.webapi

class Format {

    String name

    String toString(){
        name
    }

    static constraints = {
    }

    static def stringList(){
        def list = []
        Format.list().each { list << it.name}
        list
    }
}
