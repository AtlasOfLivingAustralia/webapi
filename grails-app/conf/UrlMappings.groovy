class UrlMappings {

	static mappings = {

		name homePage: "/"(controller:'webserviceList', action: "byCategory")
		name byCategory: "/categories"(controller:'webserviceList', action: "byCategory")
		name byApps: "/apps"(controller:'webserviceList', action: "byApp")
		"/apps/$name"(controller:'webserviceList', action: "bySpecificApp")

		"/admin/$controller/$action?/$id?"{
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
	}
}
