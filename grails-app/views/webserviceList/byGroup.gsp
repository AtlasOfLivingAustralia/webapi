<%@ page import="au.org.ala.webapi.WebService" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Web service API</title>
        <r:require modules="webapi,tooltip"/>
	</head>
	<body>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <g:if test="${isEditor}">
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
                        <li><g:link controller="format">Output formats</g:link></li>
                        <li><g:link controller="webService">Webservices</g:link></li>
                        <li><g:link controller="category">Categories</g:link></li>
                        <li><g:link controller="example">Examples</g:link></li>
                    </ul>
                  </li>
                </ul>
            </div>
        </g:if>

		<div  role="main">
			<h1>Web service API</h1>
            <p class="lead">
                The (nearly) complete listing of the web services for the ALA. Send complements/issues to support@ala.org.au.
                <br/>
                <g:if test="${byCategory}">
                    The webservices are listed by category. To list by application, <g:link action="byApp">click here</g:link>.
                </g:if>
                <g:else>
                    The webservices are listed by application. To list by category, <g:link action="byCategory">click here</g:link>.
                </g:else>
            </p>

            <g:each in="${wsByGroup.keySet()}" var="group">

                <g:if test="${wsByGroup[group]}">
                <h2 class="categoryHdr">${group.name} <span class="hidden-phone"><small> - ${group.shortDescription}</small></span></h2>
                <g:if test="${group.description}">
                    <p>
                      <markdown:renderHtml>${group.description}</markdown:renderHtml>
                    </p>
                </g:if>

                <ul style="list-style: none; margin:0;">
                <g:each in="${wsByGroup[group]}" var="webService">
                    <li id="webService-${webService.id}" class="webService">
                        <h4>

                           <g:if test="${isEditor}">
                               <span class="pull-right" style="padding-right:10px;">
                                   <g:link controller="webService" action="edit" id="${webService.id}" params="[returnTo:returnTo]" class="btn btn-small">Edit</g:link>
                                   <g:link controller="example" action="createForWS" id="${webService.id}" params="[returnTo:returnTo]" class="btn btn-small">
                                       Add example</g:link>
                                   <g:link controller="webService" action="create" id="${webService.id}"
                                       title="Create a webservice based on this webservice"
                                           params="[returnTo:returnTo]" class="btn btn-small hidden-phone">
                                       Create copy</g:link>
                               </span>
                           </g:if>

                                <div class="row-fluid" style="margin-bottom:10px;">

                                    <div class="webserviceName webServiceShowDetails">
                                        <span><a href="#ws${webService.id}" id="ws${webService.id}" name="ws${webService.id}" style="text-decoration: none; color:black;">${webService.name}</a></span>
                                        <span class="separator hidden-phone hidden-tablet"> - </span>
                                        <span class="urlLarge hidden-phone hidden-tablet">${webService.getQueryUrl()}</span>
                                        <span class="urlSmall separator visible-phone visible-tablet">${webService.getQueryUrl()}</span>
                                    </div>
                                </div>

                                <div class="row-fluid">

                                    <span class="httpMethods webServiceShowDetails hidden-phone">
                                        <g:each in="${webService.httpMethod}" var="httpMethod">
                                        <span class="httpMethod httpMethod-${httpMethod}">
                                            <a href="#" class="wsLabel" data-toggle="tooltip" data-placement="top" title="" data-original-title="This service supports HTTP ${httpMethod} request">
                                                ${httpMethod}
                                            </a>
                                        </span>
                                        </g:each>
                                    </span>

                                    <span class="outputLabels webServiceShowDetails hidden-phone">
                                        <g:each in="${webService.outputFormat}" var="outputFormat">
                                        <span class="outputFormat">
                                            <a href="#" class="wsLabel" data-toggle="tooltip" data-placement="top" title="" data-original-title="This service returns data in ${outputFormat.toUpperCase()} format">
                                            ${outputFormat?.toUpperCase()}
                                            </a>
                                        </span>
                                        </g:each>
                                    </span>

                                    <span class="visible-phone">
                                        <ul class="inline">
                                        <g:each in="${webService.httpMethod}" var="httpMethod">
                                            <li class="label label-http-${httpMethod}">${httpMethod}</li>
                                        </g:each>
                                        <g:each in="${webService.outputFormat}" var="outputFormat">
                                            <li class="label">${outputFormat?.toUpperCase()}</li>
                                        </g:each>
                                       </ul>
                                    </span>

                                    <g:if test="${webService.deprecated}">
                                        <span class="deprecatedLabel webServiceShowDetails">
                                            <span>DEPRECATED</span>
                                        </span>
                                    </g:if>
                                </div>

                                <g:set var="returnTo" value="/#ws${webService.id}"/>

                        </h4>

                        <div id="webService-details-${webService.id}" class="webServiceDetails hide">
                            <p><markdown:renderHtml>${webService.description}</markdown:renderHtml></p>

                            <g:if test="${webService.params}">
                                <table class="table table-bordered table-striped  table-condensed">
                                <g:each in="${webService.getSortedParams()}" var="param">
                                   <tr>
                                       <td>${param.name}
                                        <g:if test="${param.mandatory}"><span class="required-indicator">*</span></g:if>
                                        <g:if test="${param.deprecated}"><span class="deprecated-indicator text-warning">(deprecated)</span></g:if>
                                       </td>
                                       <td>${param.type}</td>
                                       <td>
                                           <span class="paramDescription">
                                           <markdown:renderHtml>${param.description}</markdown:renderHtml>
                                           </span>
                                       </td>
                                   </tr>
                                </g:each>
                                </table>
                            </g:if>

                            <g:if test="${webService.exampleOutput}">
                                <div class="exampleOutput">
                                    <h4>Example output</h4>
                                    <pre><code>${webService.exampleOutput}</code></pre>
                                </div>
                            </g:if>

                            <g:if test="${webService.examples}">
                                <div class="examples">
                                    <h4>Examples</h4>
                                    <ul>
                                    <g:each in="${webService.examples}" var="example">
                                       <li>
                                           <span class="pull-right" style="padding-right:10px;">
                                               <g:link controller="example" action="edit" id="${example.id}" params="[returnTo:returnTo]" class="btn btn-small">Edit</g:link>
                                           </span>

                                           <h5>${example.name}</h5>
                                           <p><markdown:renderHtml>${example.description}</markdown:renderHtml></p>
                                           <p>
                                               URL: <a href="${example.getQueryUrl()}">${example.getQueryUrl()}</a>
                                               <g:if test="${example.onlineViewer}">
                                                   <br/>
                                                   Online demo: <a href="${example.onlineViewer}">${example.onlineViewer}</a>
                                               </g:if>
                                            </p>
                                       </li>
                                    </g:each>
                                    </ul>
                                </div>
                            </g:if>

                            <g:if test="${!webService.examples && !webService.params}">
                                <div class="examples">
                                    View : <a href="${webService.getQueryUrl()}">${webService.getQueryUrl()}</a>
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
      $( this).parent().parent().parent().children( ".webServiceDetails" ).toggle( "slow", function() {
        // Animation complete.
      });
    });
    $('.wsLabel').tooltip({});
//    if(window.location.hash){
//        var hashValue = window.location.hash.substring(1);
//        alert('hash: ' + hashValue);
//        $(hashValue).parent().parent().children( ".webServiceDetails" ).toggle( "slow", function() {});
//    }
 });
</r:script>

</html>
