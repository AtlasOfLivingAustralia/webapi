package au.org.ala.webapi

import grails.transaction.Transactional

@Transactional(readOnly = true)
class AppController {

    static scaffold = App

    def index(Integer max) {
        params.max = Math.min(max ?: 1000, 1000)
        respond App.list(params), model: [appCount: App.count()]
    }
}
