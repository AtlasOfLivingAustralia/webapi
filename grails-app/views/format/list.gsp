
<%@ page import="au.org.ala.webapi.Format" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.skin.layout}"/>
		<g:set var="entityName" value="${message(code: 'format.label', default: 'Format')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-format" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <ul class="breadcrumb" role="navigation">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
            <li class="active"><g:message code="default.list.label" args="[entityName]" /></li>
        </ul>

		<div id="list-format" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" />
            <g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
            </h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <p class="lead">
                A list of supported formats. Add formats here to reuse in webservice description.
            </p>

			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'format.name.label', default: 'Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${formatInstanceList}" status="i" var="formatInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${formatInstance.id}">${fieldValue(bean: formatInstance, field: "name")}</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${formatInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
