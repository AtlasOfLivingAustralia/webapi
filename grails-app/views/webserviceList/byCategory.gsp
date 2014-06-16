<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Web service API</title>
        <r:require modules="webapi,tooltip"/>
        <g:if test="${!isEditor}">
            <style type="text/css">
            .editorFunctions { display:none; }
            </style>
        </g:if>
	</head>
	<body>
        <a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="pull-right editorFunctions">
                <ul class="nav nav-pills">
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
                        <li><g:link controller="example" action="lastRuns">Latest heart beats</g:link> </li>
                        <li><g:link controller="webserviceList" action="sendHeartbeat">Send heart beat</g:link></li>
                        <li><g:link controller="webserviceList" action="clearCache">Clear page cache</g:link></li>
                    </ul>
                  </li>
                </ul>
            </div>

		<div  role="main">
			<h1>Web service API</h1>
            <p class="lead">
                <span class="hidden-phone">The (nearly) complete listing of the web services for the ALA. Send complements/issues to support@ala.org.au. <br/></span>

                <g:if test="${byCategory}">
                    The webservices are listed by category. To list by application, <g:link action="byApp">click here</g:link>.
                </g:if>
                <g:else>
                    The webservices are listed by application. To list by category, <g:link action="byCategory">click here</g:link>.
                </g:else>
            </p>
            <cache:block>
                <g:render template="byGroup" model="[wsByGroup:wsByGroup]"/>
            </cache:block>
		</div>
	</body>
<r:script>

$(function() {
    //add click events for links
    $( ".webServiceShowDetails" ).click(function() {
      $( this).parent().parent().parent().children( ".webServiceDetails" ).toggle( "slow", function() {
        // Animation complete.
      });
    });
    $('.wsLabel').tooltip({});
 });
</r:script>

</html>
