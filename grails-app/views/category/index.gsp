<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}"/>
    <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label"
                                                                             args="[entityName]"/></g:link>

<div id="list-category" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <p class="lead">${message(code: "category.list.label", default: "Categories for webservices. A webservice can be tied to 1 or more categories.")}</p>

    <f:table collection="${categoryList}" class="table table-striped table-bordered table-condensed"
             properties="${['name', 'shortDescription']}"/>

    <div class="pagination">
        <g:paginate total="${categoryCount ?: 0}"/>
    </div>
</div>
</body>
</html>