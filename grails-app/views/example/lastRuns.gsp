<%@ page import="org.joda.time.Duration" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Last run examples</title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</div>

<div id="list-example" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="['Latest Example Runs']"/></h1>

    <g:if test="${flash.message}">
        <div class="message well alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <p class="lead">
        List of the last time each Example was called from the webapi server.
    </p>

    <table class="table">
        <thead>
        <tr>
            <g:sortableColumn property="example.name" title="${message(code: 'exampleRun.example.name.label', default: 'Example Name')}"/>
            <g:sortableColumn property="responseCode" title="${message(code: 'exampleRunResponse.responseCode.label', default: 'Response')}"/>
            <g:sortableColumn property="start" title="${message(code: 'exampleRun.start.label', default: 'When')}"/>
            <g:sortableColumn property="duration" title="${message(code: 'exampleRun.duration.label', default: 'Duration')}"/>
            <th><g:message code="exampleRun.links" default="Links"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${latestRuns.value}" status="i" var="exampleRun">
            <tr>
                <td><g:link controller="example" action="show" id="${exampleRun.example.id}">
                    <g:fieldValue field="name" bean="${exampleRun.example}" />
                    <br/>
                    <small>
                        <g:fieldValue field="name" bean="${exampleRun.example.webService}" />
                    </small>
                     </g:link>
                </td>
                <td >
                    <span class="well ${exampleRun.responseCode < 300 ? 'label label-success' : ' label label-important'}" style="padding:5px; color:#FFFFFF;">
                        ${(exampleRun.responseCode ?: exampleRun.message).encodeAsHTML()}
                    </span>
                </td>
                <td><prettytime:display date="${exampleRun.start}" /></td>
                <td><joda:formatPeriod value="${new Duration(exampleRun.duration)}" /></td>
                <td>
                    <g:link class="btn btn-small" controller="exampleRun" action="response" id="${exampleRun.id}">Body</g:link>
                    <g:link class="btn btn-small" controller="example" action="callExample" id="${exampleRun.example.id}">Run Now</g:link>
                    <g:link class="btn btn-small" controller="example" action="graph" id="${exampleRun.example.id}">History</g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="well-small well"><small>Retrieved in <joda:formatPeriod value="${new Duration(latestRuns.start, latestRuns.end)}"/></small></div>

    <h1>Web Services with a GET method and without machine callable examples</h1>
    <table class="table">
    <g:each in="${services.value}" status="i" var="service">
        <tr>
            <td><g:link controller="webService" action="show" id="${service.id}"><g:fieldValue field="name" bean="${service}" /></g:link></td>
            <td><g:link class="btn btn-mini" controller="example" action="createForWS" id="${service.id}">Add example</g:link></td>
        </tr>
    </g:each>
    </table>
    <div class="well-small well"><small>Retrieved in <joda:formatPeriod value="${new Duration(services.start, services.end)}"/></small></div>

</div>
</body>
</html>