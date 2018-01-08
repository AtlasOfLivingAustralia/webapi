
<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.skin.layout}"/>
		<g:set var="entityName" value="${message(code: 'webService.label', default: 'WebService')}" />
		<title><g:message code="default.show.label" args="[entityName]" /> | Web service API | ${grailsApplication.config.skin.orgNameLong}</title></title>
        <asset:stylesheet src="webapi"></asset:stylesheet>
        <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
	</head>
	<body>
		<div id="show-webService" class="content scaffold-show" role="main">
            <h1>${this.webService?.name}</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <div class="row">
                <span class="col-md-4">
			<ol class="property-list webService">

                <g:if test="${this.webService?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="webService.description.label" default="Description" /></span>

                    <span class="property-value" aria-labelledby="description-label"><g:fieldValue
                            bean="${this.webService}" field="description"/></span>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.url}">
				<li class="fieldcontain">
					<span id="url-label" class="property-label"><g:message code="webService.url.label" default="Url" /></span>

                    <span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${this.webService}"
                                                                                           field="url"/></span>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.httpMethod}">
				<li class="fieldcontain">
					<span id="httpMethod-label" class="property-label"><g:message code="webService.httpMethod.label" default="Http Method" /></span>

                    <span class="property-value" aria-labelledby="httpMethod-label"><g:fieldValue
                            bean="${this.webService}" field="httpMethod"/></span>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.deprecated}">
				<li class="fieldcontain">
					<span id="deprecated-label" class="property-label"><g:message code="webService.deprecated.label" default="Deprecated" /></span>

                    <span class="property-value" aria-labelledby="deprecated-label"><g:formatBoolean
                            boolean="${this.webService?.deprecated}"/></span>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.outputFormat}">
				<li class="fieldcontain">
					<span id="outputFormat-label" class="property-label"><g:message code="webService.outputFormat.label" default="Output Format" /></span>

                    <span class="property-value" aria-labelledby="outputFormat-label"><g:fieldValue
                            bean="${this.webService}" field="outputFormat"/></span>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.app}">
				<li class="fieldcontain">
					<span id="app-label" class="property-label"><g:message code="webService.app.label" default="App" /></span>

                    <span class="property-value" aria-labelledby="app-label"><g:link controller="app" action="show"
                                                                                     id="${this.webService?.app?.id}">${this.webService?.app?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.categories}">
				<li class="fieldcontain">
					<span id="categories-label" class="property-label"><g:message code="webService.categories.label" default="Categories" /></span>

                    <g:each in="${this.webService.categories}" var="c">
						<span class="property-value" aria-labelledby="categories-label"><g:link controller="category" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="webService.dateCreated.label" default="Date Created" /></span>

                    <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            date="${this.webService?.dateCreated}"/></span>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.examples}">
				<li class="fieldcontain">
					<span id="examples-label" class="property-label"><g:message code="webService.examples.label" default="Examples" /></span>

                    <g:each in="${this.webService.examples}" var="e">
						<span class="property-value" aria-labelledby="examples-label"><g:link controller="example" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>

                <g:if test="${this.webService?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="webService.lastUpdated.label" default="Last Updated" /></span>

                    <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                            date="${this.webService?.lastUpdated}"/></span>
					
				</li>
				</g:if>
			</ol>
            </span>
                <span class="col-md-8">
                    <g:if test="${this.webService?.getSortedParams()}">
                    <h4>Parameters</h4>

                    <table class="table table-bordered table-striped">
                        <thead>
                        <th>Parameter name</th>
                        <th>Data type</th>
                        <th>Properties</th>
                        <th>Description</th>
                        </thead>
                        <g:each in="${this.webService.getSortedParams()}" var="p">
                            <tr>
                                <td>${p.name}</td>
                                <td>${p.type}</td>
                                <td>
                                    Mandatory:${p.mandatory?'YES':'no'}<br/>
                                    Deprecated:${p.deprecated?'YES':'no'}<br/>
                                    In title:${p.includeInTitle?'YES':'no'}
                                </td>
                                <td><markdown:renderHtml>${p.description}</markdown:renderHtml>
                                </td>
                            </tr>
                        </g:each>
                    </table>
                </g:if>
            </span>

            </div>

			<g:form>
				<fieldset class="buttons">
                    <g:hiddenField name="id" value="${this.webService?.id}"/>
                    <g:link class="edit" action="edit" id="${this.webService?.id}"><g:message
                            code="default.button.edit.label" default="Edit"/></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    <g:link class="btn btn-primary" controller="example" action="create"
                            params="${[webService: this.webService.id]}">Create example</g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
