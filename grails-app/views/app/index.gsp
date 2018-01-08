<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <g:set var="entityName" value="${message(code: 'app.label', default: 'App')}"/>
    <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label"
                                                                             args="[entityName]"/></g:link>

<div id="list-app" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <p class="lead">${message(code: "app.list.label", default: "A listing of applications supplying webservices.")}</p>

    <f:table collection="${appList}" class="table table-striped table-bordered table-condensed"
             properties="${['name', 'shortDescription', 'description', 'baseUrl', 'dateCreated', 'lastUpdated']}"/>

    <div class="pagination">
        <g:paginate total="${appCount ?: 0}"/>
    </div>
</div>
</body>
</html>