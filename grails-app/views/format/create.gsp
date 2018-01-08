<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <g:set var="entityName" value="${message(code: 'format.label', default: 'Format')}"/>
    <meta name="breadcrumbs"
          content="${createLink(uri: '/')},${grailsApplication.config.application.title}\\${createLink(class: 'list', action:'index')},${message(code: 'default.list.label', args: [entityName])}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div id="create-format" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.format}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.format}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form resource="${this.format}" method="POST">
        <fieldset class="form">
            <f:all bean="format"/>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
