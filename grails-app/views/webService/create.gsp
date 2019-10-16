<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.skin.layout}"/>
		<g:set var="entityName" value="${message(code: 'webService.label', default: 'WebService')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
        <asset:stylesheet src="webapi"></asset:stylesheet>
        <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
	</head>
	<body>
		<div id="create-webService" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
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
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
                    <g:submitButton name="create" class="save btn btn-primary"
                                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
				</fieldset>
			</g:form>
		</div>

        <table id="tableTemplate" class="hide">
            <tr class="paramRowTemplate" >
                <g:render template="param"/>
            </tr>
        </table>

	</body>
</html>
