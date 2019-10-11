<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}"/>
    <meta name="breadcrumbs"
          content="${createLink(uri: '/')},${grailsApplication.config.application.title}\\${createLink(class: 'list', action:'index')},${message(code: 'default.list.label', args: [entityName])}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div id="show-example" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <f:display bean="example" except="runs"/>
    <g:form resource="${this.example}" method="DELETE">
        <fieldset class="buttons">
            <g:link class="edit btn btn-primary" action="edit" resource="${this.example}"><g:message code="default.button.edit.label"
                                                                                     default="Edit"/></g:link>
            <input class="delete btn btn-primary" type="submit"
                   value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                   onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
