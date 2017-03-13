
<%@ page import="au.org.ala.webapi.Format" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.skin.layout}"/>
		<g:set var="entityName" value="${message(code: 'format.label', default: 'Format')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-format" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <ul class="breadcrumb" role="navigation">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
            <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
            <li class="active"><g:message code="default.show.label" args="[entityName]" /></li>
        </ul>
		<div id="show-format" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list format">
			
				<g:if test="${formatInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="format.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${formatInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${formatInstance?.id}" />
					<g:link class="edit" action="edit" id="${formatInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
