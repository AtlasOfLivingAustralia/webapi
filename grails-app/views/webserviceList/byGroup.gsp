<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Web service API</title>

        <style type="text/css">
           .httpMethod-GET {
               background-color: #0f6ab4;
               color: #FFFFFF;
               padding:5px;
               -webkit-border-radius: 5px;
               -moz-border-radius: 5px;
               border-radius: 5px;
           }

           .httpMethod-POST {
               background-color: #10a54a;
               color: #FFFFFF;
               padding:5px;
               -webkit-border-radius: 5px;
               -moz-border-radius: 5px;
               border-radius: 5px;
           }

           .httpMethod-DELETE {
               background-color: #0f6ab4;
               color: #FFFFFF;
               padding:5px;
               -webkit-border-radius: 5px;
               -moz-border-radius: 5px;
               border-radius: 5px;
           }

           .outputFormat {
               background-color: grey;
               color: #FFFFFF;
               padding:5px;
               -webkit-border-radius: 5px;
               -moz-border-radius: 5px;
               border-radius: 5px;
               text-transform:uppercase;
               margin-right:10px;
           }

           .categoryHdr { margin-top: 30px; }

           .webService {
            background-color: #e7f0f7;
            border: 1px solid #c3d9ec;
            padding-left:5px;
            cursor:pointer;
           }

           .examples {
               margin-bottom:20px;
           }

        </style>
	</head>
	<body>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div class="pull-right">
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
                    <li><g:link controller="webService">Webservices</g:link></li>
                    <li><g:link controller="category">Categories</g:link></li>
                    <li><g:link controller="example">Examples</g:link></li>
                </ul>
              </li>
            </ul>
        </div>

		<div  role="main">
			<h1>Web service API</h1>
            <p class="lead">
                The (nearly) complete listing of the web services for the ALA. Send complements/issues to support@ala.org.au.
            </p>

            <g:each in="${wsByGroup.keySet()}" var="group">

                <g:if test="${wsByGroup[group]}">
                <h2 class="categoryHdr">${group.name} <span><small> - ${group.description}</small></span></h2>
                <ul style="list-style: none; margin:0;">
                <g:each in="${wsByGroup[group]}" var="webService">
                    <li id="webService-${webService.id}" class="webService">
                        <h4>
                            <span class="httpMethod-${webService.httpMethod} webServiceShowDetails">${webService.httpMethod}</span>
                            <span class="outputFormat webServiceShowDetails">${webService.outputFormat}</span>
                            <span class="webserviceName webServiceShowDetails">${webService.name}</span>
                            -
                            <span class="webserviceUrl webServiceShowDetails">${webService.getQueryUrl()}</span>

                           <span class="pull-right" style="padding-right:10px;">
                               %{--<a href="javascript:void(0);" class=" webServiceShowDetails btn btn-small">Show details</a>--}%
                               <g:link controller="webService" action="edit" id="${webService.id}" class="btn btn-small">Edit</g:link>
                               <g:link controller="example" action="createForWS" params="[id:webService.id]" class="btn btn-small">Add example</g:link>
                           </span>
                        </h4>

                        <div id="webService-details-${webService.id}" class="webServiceDetails hide">
                            <p><markdown:renderHtml>${webService.description}</markdown:renderHtml></p>

                            <g:if test="${webService.params}">
                                <table class="table table-bordered table-striped  table-condensed">
                                <g:each in="${webService.getSortedParams()}" var="param">
                                   <tr>
                                       <td>${param.name}
                                        <g:if test="${param.mandatory}"><span class="required-indicator">*</span></g:if>
                                        <g:if test="${param.deprecated}"><span class="required-indicator">(deprecated)</span></g:if>
                                       </td>
                                       <td>${param.type}</td>
                                       <td>
                                           %{--<span class="pull-right">--}%
                                               %{--<g:link controller="param" action="edit" id="${param.id}" class="btn btn-small">Edit</g:link>--}%
                                           %{--</span>--}%
                                           <span class="paramDescription">
                                           <markdown:renderHtml>${param.description}</markdown:renderHtml>
                                           </span>
                                       </td>
                                   </tr>
                                </g:each>
                                </table>
                            </g:if>

                            <g:if test="${webService.examples}">
                                <div class="examples">
                                    <h4>Examples</h4>
                                    <ul>
                                    <g:each in="${webService.examples}" var="example">
                                       <li>
                                           <span class="pull-right" style="padding-right:10px;">
                                               <g:link controller="example" action="edit" id="${example.id}" class="btn btn-small">Edit</g:link>
                                           </span>

                                           <h5>${example.name}</h5>
                                           <p><markdown:renderHtml>${example.description}</markdown:renderHtml></p>
                                           <p>
                                               URL: <a href="${example.getQueryUrl()}">${example.getQueryUrl()}</a>
                                           </p>
                                       </li>
                                    </g:each>
                                    </ul>
                                </div>
                            </g:if>
                        </div>
                    </li>
                </g:each>
                </ul>
                </g:if>
            </g:each>
		</div>
	</body>
<r:script>

$(function() {
    //add click events for links
    $( ".webServiceShowDetails" ).click(function() {
      $( this).parent().parent().children( ".webServiceDetails" ).toggle( "slow", function() {
        // Animation complete.
      });
    });
 });
</r:script>

</html>
