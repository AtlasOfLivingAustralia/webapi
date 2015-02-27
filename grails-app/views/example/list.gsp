<%@ page import="au.org.ala.webapi.Example" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <r:require module="font-awesome"/>
</head>

<body>
<a href="#list-example" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>
<ul class="breadcrumb" role="navigation">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
    <li class="active"><g:message code="default.list.label" args="[entityName]" /></li>
</ul>


<div id="list-example" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/>
        <g:link class="create btn btn-primary pull-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <p>
        To add an example, you can also select the <g:link controller="webserviceList" action="byCategory">webservice</g:link> first, and then use the
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
