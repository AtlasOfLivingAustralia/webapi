<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <g:set var="entityName" value="${message(code: 'app.label', default: 'App')}"/>
    <meta name="breadcrumbs"
          content="${createLink(uri: '/')},${grailsApplication.config.application.title}\\${createLink(class: 'list', action:'index')},${message(code: 'default.list.label', args: [entityName])}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div id="edit-app" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.app}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.app}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form resource="${this.app}" method="PUT">
        <g:hiddenField name="version" value="${this.app?.version}"/>
        <fieldset class="form">
            <f:all bean="app"/>
        </fieldset>
        <fieldset class="buttons">
            <input class="save btn btn-primary" type="submit"
                   value="${message(code: 'default.button.update.label', default: 'Update')}"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
