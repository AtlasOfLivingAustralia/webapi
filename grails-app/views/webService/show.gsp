
<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'webService.label', default: 'WebService')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-webService" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-webService" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list webService">
			
				<g:if test="${webServiceInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="webService.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${webServiceInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="webService.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${webServiceInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.url}">
				<li class="fieldcontain">
					<span id="url-label" class="property-label"><g:message code="webService.url.label" default="Url" /></span>
					
						<span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${webServiceInstance}" field="url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.httpMethod}">
				<li class="fieldcontain">
					<span id="httpMethod-label" class="property-label"><g:message code="webService.httpMethod.label" default="Http Method" /></span>
					
						<span class="property-value" aria-labelledby="httpMethod-label"><g:fieldValue bean="${webServiceInstance}" field="httpMethod"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.deprecated}">
				<li class="fieldcontain">
					<span id="deprecated-label" class="property-label"><g:message code="webService.deprecated.label" default="Deprecated" /></span>
					
						<span class="property-value" aria-labelledby="deprecated-label"><g:formatBoolean boolean="${webServiceInstance?.deprecated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.outputFormat}">
				<li class="fieldcontain">
					<span id="outputFormat-label" class="property-label"><g:message code="webService.outputFormat.label" default="Output Format" /></span>
					
						<span class="property-value" aria-labelledby="outputFormat-label"><g:fieldValue bean="${webServiceInstance}" field="outputFormat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.app}">
				<li class="fieldcontain">
					<span id="app-label" class="property-label"><g:message code="webService.app.label" default="App" /></span>
					
						<span class="property-value" aria-labelledby="app-label"><g:link controller="app" action="show" id="${webServiceInstance?.app?.id}">${webServiceInstance?.app?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.categories}">
				<li class="fieldcontain">
					<span id="categories-label" class="property-label"><g:message code="webService.categories.label" default="Categories" /></span>
					
						<g:each in="${webServiceInstance.categories}" var="c">
						<span class="property-value" aria-labelledby="categories-label"><g:link controller="category" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="webService.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${webServiceInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.examples}">
				<li class="fieldcontain">
					<span id="examples-label" class="property-label"><g:message code="webService.examples.label" default="Examples" /></span>
					
						<g:each in="${webServiceInstance.examples}" var="e">
						<span class="property-value" aria-labelledby="examples-label"><g:link controller="example" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="webService.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${webServiceInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${webServiceInstance?.getSortedParams()}">
                <h4>Parameters</h4>

				<table class="table table-bordered table-striped">
                    <thead>
                        <th>Parameter name</th>
                        <th>Data type</th>
                        <th>Properties</th>
                        <th>Description</th>
                    </thead>
                    <g:each in="${webServiceInstance.getSortedParams()}" var="p">
                    <tr>
                       <td>${p.name}</td>
                       <td>${p.type}</td>
                       <td>
                           Mandatory: ${p.mandatory?'YES':'no'} <br/>
                           Deprecated: ${p.deprecated?'YES':'no'} <br/>
                           Included in title: ${p.includeInTitle?'YES':'no'}
                       </td>
                       <td><markdown:renderHtml>${p.description}</markdown:renderHtml>
                       </td>
                    </tr>
                    </g:each>
				</table>
				</g:if>
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${webServiceInstance?.id}" />
					<g:link class="edit" action="edit" id="${webServiceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
