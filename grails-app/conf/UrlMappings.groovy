class UrlMappings {

	static mappings = {

		"/"(controller:'webserviceList', action: "byCategory")
		"/categories"(controller:'webserviceList', action: "byCategory")
		"/apps"(controller:'webserviceList', action: "byApp")
		"/apps/$name"(controller:'webserviceList', action: "bySpecificApp")

		"/admin/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"500"(view:'/error')
	}
}
