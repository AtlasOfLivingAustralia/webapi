package au.org.ala.webapi

import grails.transaction.Transactional

@Transactional(readOnly = true)
class CategoryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    static scaffold = Category

    def index(Integer max) {
        params.max = Math.min(max ?: 1000, 1000)
        respond Category.list(params), model: [categoryCount: Category.count()]
    }
}
