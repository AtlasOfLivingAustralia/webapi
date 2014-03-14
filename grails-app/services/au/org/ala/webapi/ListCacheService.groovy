package au.org.ala.webapi

class ListCacheService {

    private def wsByCategory = [:]

    def serviceMethod() {
    }

    def clearCache(){
        wsByCategory = [:]
    }

    def byCategory() {

        if(!wsByCategory){
            def categories = au.org.ala.webapi.Category.list()
            categories.each { category ->
                def webservices = WebService.getByCategory(category)
                wsByCategory[category] = webservices
            }
        }
        wsByCategory
    }
}
