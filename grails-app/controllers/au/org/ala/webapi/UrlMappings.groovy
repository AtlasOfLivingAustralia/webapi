package au.org.ala.webapi

class UrlMappings {

	static mappings = {

		name homePage: "/"(controller:'webserviceList', action: "byCategory")
		name byCategory: "/categories"(controller:'webserviceList', action: "byCategory")
		name byApps: "/apps"(controller:'webserviceList', action: "byApp")

		name App: "/admin/apps"(controller: 'app', action: "index")
		name Category: "/admin/category"(controller: 'category', action: "index")
		name Example: "/admin/example"(controller: 'example', action: "index")
		name LastRuns: "/admin/example/lastRuns"(controller: 'example', action: "lastRuns")
		name Format: "/admin/format"(controller: 'format', action: "index")
		name WebService: "/admin/webService"(controller: 'webService', action: "index")

		"/apps/$name"(controller:'webserviceList', action: "bySpecificApp")

        "/heartbeat/$id"(controller: 'example', action: 'graph')

		"/admin/$controller/$action?/$id?(.$format)?"{
			constraints {
				// apply constraints here
			}
		}

		"/logout/$action?/$id?"(controller:'logout'){
			constraints {
				// apply constraints here
			}
		}

		"500"(view:'/error')
		"400"(view:'/error')
		"404"(view:'/notFound')
	}
}
