package au.org.ala.webapi

class WebserviceListController {

    def authService
    def listCacheService
    def grailsCacheAdminService

    def byCategory() {
      render(view: "byGroup", model: [wsByGroup: listCacheService.byCategory(), byCategory:true, isEditor: authService.userInRole("ROLE_API_EDITOR")])
    }

    def clearCache(){
        // clear the cache used by the blocks tag…
        grailsCacheAdminService.clearBlocksCache()

        // clear the cache used by the render tag…
        grailsCacheAdminService.clearTemplatesCache()

        listCacheService.clearCache()

        redirect( controller: 'webserviceList', action:'byCategory')
    }

    def byApp() {

      def apps = au.org.ala.webapi.App.list()

      def wsByApp = [:]

      apps.each { app ->
          wsByApp[app] = app.webservices
      }

      render(view: "byGroup", model: [wsByGroup: wsByApp, byCategory:false, isEditor: authService.userInRole("ROLE_API_EDITOR")])
    }

    def bySpecificApp() {

      def app = App.findByNameIlike(params.name)

      def wsByApp = [:]

      wsByApp[app] = app.webservices

      render(view: "byGroup", model: [wsByGroup: wsByApp, byCategory:false, isEditor: authService.userInRole("ROLE_API_EDITOR")])
    }
}
