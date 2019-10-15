<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.skin.layout}"/>
		<g:set var="entityName" value="${message(code: 'webService.label', default: 'WebService')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /> </title>
        <asset:stylesheet src="webapi"></asset:stylesheet>
        <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
	</head>
	<body>
		<div id="edit-webService" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /> </h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
            <g:hasErrors bean="${this.webService}">
			<ul class="errors" role="alert">
                <g:eachError bean="${this.webService}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
                <g:hiddenField name="id" value="${this.webService?.id}"/>
                <g:hiddenField name="version" value="${this.webService?.version}"/>
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
        <table id="tableTemplate" class="hide">
            <tr class="paramRowTemplate">
                <g:render template="param"/>
            </tr>
        </table>
	</body>
</html>
