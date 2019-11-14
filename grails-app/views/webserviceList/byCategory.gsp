<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="breadcrumb" content="${grailsApplication.config.application.title}"/>
    <title>${grailsApplication.config.application.title} | ${grailsApplication.config.skin.orgNameLong}</title>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <asset:javascript src="bootstrap-tooltip"></asset:javascript>
    <asset:javascript src="webServiceToggle"></asset:javascript>
    <g:if test="${!isEditor}">
        <style type="text/css">
        .editorFunctions {
            display: none;
        }
        </style>
    </g:if>
</head>

<body onload="expandOnIndividualService()">
<div class="editorFunctions">
    <ul class="pull-right nav nav-pills">
        <li class="dropdown">
            <a class="dropdown-toggle"
               data-toggle="dropdown"
               href="#">
                Admin
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
                <li><g:link controller="webService" action="create">Add Webservice</g:link></li>
                <li><g:link controller="app">Apps</g:link></li>
                <li><g:link controller="format">Output formats</g:link></li>
                <li><g:link controller="webService">Webservices</g:link></li>
                <li><g:link controller="category">Categories</g:link></li>
                <li><g:link controller="example">Examples</g:link></li>
                <li><g:link controller="example" action="lastRuns">Latest heart beats</g:link></li>
                <li><g:link controller="webserviceList" action="sendHeartbeat">Send heart beat</g:link></li>
                <li><g:link controller="webserviceList" action="clearCache">Clear page cache</g:link></li>
            </ul>
        </li>
    </ul>
</div>

<div role="main">
    <h1>Web service API</h1>

    <p>
        <g:if test="${byCategory}">
            The webservices are listed by category. To list by application, <g:link action="byApp">click here</g:link>.
        </g:if>
        <g:else>
            The webservices are listed by application. To list by category, <g:link
                action="byCategory">click here</g:link>.
        </g:else>
    </p>

    <div class="pull-right">
        <div class="btn btn-primary" onclick="expandApis()"><i class="fa fa-plus"></i> Expand All</div>

        <div class="btn btn-primary" onclick="collapseApis()"><i class="fa fa-minus"></i> Collapse All</div>
    </div>
    <cache:block>
        <g:render template="byGroup" model="[wsByGroup: wsByGroup]"/>
    </cache:block>
</div>
</body>
</html>
