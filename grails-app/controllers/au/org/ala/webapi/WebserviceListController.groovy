package au.org.ala.webapi

class WebserviceListController {

    def index() {

      def categories = au.org.ala.webapi.Category.list()

      def wsByCategory = [:]

      categories.each { category ->
          def webservices = WebService.getByCategory(category)
          wsByCategory[category] = webservices
      }

      [wsByCategory: wsByCategory]
    }
}
