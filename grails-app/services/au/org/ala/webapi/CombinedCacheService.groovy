package au.org.ala.webapi

class CombinedCacheService {

    static transactional = false

    def grailsCacheAdminService
    def listCacheService

    private def clearCache() {

        // clear the cache used by the blocks tag…
        grailsCacheAdminService.clearBlocksCache()

        // clear the cache used by the render tag…
        grailsCacheAdminService.clearTemplatesCache()

        listCacheService.clearCache()
    }
}
