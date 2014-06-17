<%@ page import="au.org.ala.webapi.Example" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-example" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        %{--<li><g:link class="create" action="create"><g:message code="default.new.label"--}%
                                                              %{--args="[entityName]"/></g:link></li>--}%
    </ul>
</div>

<div id="list-example" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <p class="lead">
        To add an example, select the <g:link controller="webserviceList" action="byCategory">webservice</g:link> first, and then use the
        "Add example" button.
    </p>

    <table>
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'example.name.label', default: 'Name')}"/>

            <th><g:message code="example.webService.label" default="Web Service"/></th>

            <g:sortableColumn property="description"
                              title="${message(code: 'example.description.label', default: 'Description')}"/>

            <g:sortableColumn property="dateCreated"
                              title="${message(code: 'example.dateCreated.label', default: 'Date Created')}"/>

            <g:sortableColumn property="lastUpdated"
                              title="${message(code: 'example.lastUpdated.label', default: 'Last Updated')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${exampleInstanceList}" status="i" var="exampleInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${exampleInstance.id}">${fieldValue(bean: exampleInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: exampleInstance, field: "webService")}</td>

                <td>${fieldValue(bean: exampleInstance, field: "description")}</td>

                <td><g:formatDate date="${exampleInstance.dateCreated}"/></td>

                <td><g:formatDate date="${exampleInstance.lastUpdated}"/></td>


            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${exampleInstanceTotal}"/>
    </div>
</div>
</body>
</html>
