
<%@ page import="au.org.ala.webapi.App" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.skin.layout}"/>
		<g:set var="entityName" value="${message(code: 'app.label', default: 'Application')}" />
		<title><g:message code="default.list.label" args="[entityName]" /> | Web service API | ${grailsApplication.config.skin.orgNameLong}</title>
	</head>
	<body>
		<a href="#list-app" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <ul class="breadcrumb" role="navigation">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
            <li class="active"><g:message code="default.list.label" args="[entityName]" /></li>
        </ul>

		<div id="list-app" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" />
                <g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
            </h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>

            <p class="lead">
                A listing of applications supplying webservices.
            </p>

			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'app.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="shortDescription" title="${message(code: 'app.shortDescription.label', default: 'Short Description')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'app.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="baseUrl" title="${message(code: 'app.baseUrl.label', default: 'Base Url')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'app.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'app.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${appInstanceList}" status="i" var="appInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${appInstance.id}">${fieldValue(bean: appInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: appInstance, field: "shortDescription")}</td>
					
						<td>${fieldValue(bean: appInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: appInstance, field: "baseUrl")}</td>
					
						<td><g:formatDate date="${appInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${appInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${appInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
