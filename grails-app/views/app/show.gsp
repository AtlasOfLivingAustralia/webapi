
<%@ page import="au.org.ala.webapi.App" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'app.label', default: 'App')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <r:require module="font-awesome"/>
	</head>
	<body>
		<a href="#show-app" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <ul class="breadcrumb" role="navigation">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
            <li><g:link class="list"><g:message code="default.list.label" args="[entityName]" /></g:link> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
            <li class="active"><g:message code="default.show.label" args="[entityName]" /></li>
        </ul>

		<div id="show-app" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list app">
			
				<g:if test="${appInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="app.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${appInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${appInstance?.shortDescription}">
				<li class="fieldcontain">
					<span id="shortDescription-label" class="property-label"><g:message code="app.shortDescription.label" default="Short Description" /></span>
					
						<span class="property-value" aria-labelledby="shortDescription-label"><g:fieldValue bean="${appInstance}" field="shortDescription"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${appInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="app.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${appInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${appInstance?.baseUrl}">
				<li class="fieldcontain">
					<span id="baseUrl-label" class="property-label"><g:message code="app.baseUrl.label" default="Base Url" /></span>
					
						<span class="property-value" aria-labelledby="baseUrl-label"><g:fieldValue bean="${appInstance}" field="baseUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${appInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="app.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${appInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${appInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="app.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${appInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${appInstance?.webservices}">
				<li class="fieldcontain">
					<span id="webservices-label" class="property-label"><g:message code="app.webservices.label" default="Webservices" /></span>
					
						<g:each in="${appInstance.webservices}" var="w">
						<span class="property-value" aria-labelledby="webservices-label"><g:link controller="webService" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:appInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${appInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
