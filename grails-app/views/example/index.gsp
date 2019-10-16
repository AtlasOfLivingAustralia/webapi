<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label"
                                                                             args="[entityName]"/></g:link>

<div id="list-example" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <p class="lead">${message(code: "example.list.label", default: "To add an example, you can also select the webservice first, and then use the \"New Example\" button.")}</p>

    <f:table collection="${exampleList}"
             properties="${['name', 'webService', 'description', 'dateCreated', 'lastUpdated']}"/>

    <div class="pagination">
        <g:paginate total="${exampleCount ?: 0}"/>
    </div>
</div>
</body>
</html>