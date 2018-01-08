<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
    <g:set var="entityName" value="${message(code: 'format.label', default: 'Format')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label"
                                                                             args="[entityName]"/></g:link>

<div id="list-format" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <p class="lead">${message(code: "format.list.label", default: "A list of supported formats. Add formats here to reuse in webservice description.")}</p>
    <f:table collection="${formatList}" class="table table-striped table-bordered table-condensed"/>

    <div class="pagination">
        <g:paginate total="${formatCount ?: 0}"/>
    </div>
</div>
</body>
</html>