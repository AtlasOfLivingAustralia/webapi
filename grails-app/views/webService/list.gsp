
<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.skin.layout}"/>
		<g:set var="entityName" value="${message(code: 'webService.label', default: 'WebService')}" />
        <asset:stylesheet src="webapi"></asset:stylesheet>
        <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
		<title><g:message code="default.list.label" args="[entityName]" /> | Web service API | ${grailsApplication.config.skin.orgNameLong}</title>
	</head>
	<body>
		<a href="#list-webService" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <ul class="breadcrumb" role="navigation">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
            <li class="active"><g:message code="default.list.label" args="[entityName]" /></li>
        </ul>
		<div id="list-webService" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]"/> - ${this.webServiceTotal} listed
                <g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
            </h1>

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
            <table class="table table-bordered table-striped">
				<thead>
					<tr>

                        <g:sortableColumn property="name" mapping="${webServiceList[0]?.class?.simpleName}"
                                          title="${message(code: 'webService.name.label', default: 'Name')}"/>

                        <g:sortableColumn property="description" mapping="${webServiceList[0]?.class?.simpleName}"
                                          title="${message(code: 'webService.description.label', default: 'Description')}"/>

                        <g:sortableColumn property="url" mapping="${webServiceList[0]?.class?.simpleName}"
                                          title="${message(code: 'webService.url.label', default: 'Url')}"/>

                        <g:sortableColumn property="app" mapping="${webServiceList[0]?.class?.simpleName}"
                                          title="${message(code: 'webService.url.label', default: 'App')}"/>

                        <g:sortableColumn property="httpMethod" mapping="${webServiceList[0]?.class?.simpleName}"
                                          title="${message(code: 'webService.httpMethod.label', default: 'Http Method')}"/>

                        <g:sortableColumn property="deprecated" mapping="${webServiceList[0]?.class?.simpleName}"
                                          title="${message(code: 'webService.deprecated.label', default: 'Deprecated')}"/>

                        <g:sortableColumn property="outputFormat" mapping="${webServiceList[0]?.class?.simpleName}"
                                          title="${message(code: 'webService.outputFormat.label', default: 'Output Format')}"/>

                        <th>Edit</th>
					
					</tr>
				</thead>
				<tbody>
                <g:each in="${webServiceList}" status="i" var="webService">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show"
                                    id="${webService.id}">${fieldValue(bean: webService, field: "name")}</g:link></td>

                        <td>${fieldValue(bean: webService, field: "description")}</td>

                        <td>${fieldValue(bean: webService, field: "url")}</td>

                        <td>${fieldValue(bean: webService, field: "app")}</td>

                        <td>${fieldValue(bean: webService, field: "httpMethod")}</td>

                        <td><g:formatBoolean boolean="${webService.deprecated}"/></td>

                        <td>${fieldValue(bean: webService, field: "outputFormat")}</td>

                        <td>
                            <g:link class="btn btn-xs btn-primary" controller="webService" action="edit"
                                    id="${webService.id}">Edit&nbsp;details</g:link>
                            <g:link class="btn btn-xs btn-primary" controller="example" action="create"
                                    params="${[webService: webService.id]}">Add&nbsp;example</g:link>
                            <g:link class="btn btn-xs btn-primary" controller="webService" action="create"
                                    id="${webService.id}">Create&nbsp;copy</g:link>
                        </td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
                <g:paginate total="${this.webServiceCount}"/>
			</div>
		</div>
	</body>
</html>
