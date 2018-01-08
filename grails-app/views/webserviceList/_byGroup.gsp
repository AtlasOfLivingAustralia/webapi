<%@ page import="au.org.ala.webapi.WebService" %>
<g:each in="${wsByGroup.keySet()}" var="group">

    <g:if test="${wsByGroup[group]}">
        <h2 class="categoryHdr">${group.name} <span class="hidden-xs"><small>${group.shortDescription}</small></span>
        </h2>
        <g:if test="${group.description}">
            <p>
                <markdown:renderHtml>${encodeAs([codec: 'raw'], group.description)}</markdown:renderHtml>
            </p>
        </g:if>

        <ul class="container" style="list-style: none; margin:0;">
            <g:each in="${wsByGroup[group]}" var="webService">
                <li id="webService-${webService.id}" class="row webService">
                    <h4>
                        <span class="editorFunctions">
                            <span class="pull-right" style="padding-right:10px;">
                                <g:link controller="webService" action="edit" id="${webService.id}"
                                        params="[returnTo: returnTo]" class="btn btn-xs btn-ala"
                                        title="Edit the definition of this webservice"
                                >
                                    <i class="fa fa-edit"></i>
                                    <span class="hidden-xs">Edit</span>
                                </g:link>
                                <g:link controller="example" action="create" params="${webService.id}"
                                        params="[returnTo: returnTo]" class="btn btn-xs btn-ala"
                                        title="Add an example usage of this webservice"
                                >
                                    <i class="fa fa-plus"></i>
                                    <span class="hidden-xs">Example</span>
                                </g:link>
                                <g:link controller="webService" action="create" id="${webService.id}"
                                        title="Create a webservice based on this webservice"
                                        params="[returnTo: returnTo]" class="btn btn-xs btn-ala">
                                    <i class="fa fa-cog"></i>
                                    <span class="hidden-xs">Copy</span>
                                </g:link>
                            </span>
                        </span>

                        <div class="row" style="margin-bottom:20px;display: inline-block;">

                            <div class="col-md-12 webserviceName webServiceShowDetails" style="float:none">
                                <span><a href="#ws${webService.id}" id="ws${webService.id}" name="ws${webService.id}" style="text-decoration: none; color:black;">${webService.name}</a></span>
                                <span class="hidden-xs hidden-sm">-</span>
                                <span class="urlLarge hidden-xs hidden-sm">${webService.getQueryUrl()}</span>
                                <span class="hidden-xs">&nbsp;</span>
                                <span class="urlSmall visible-xs visible-sm">${webService.getQueryUrl()}</span>
                            </div>
                        </div>

                        <div class="row">

                            <span class="col-md-12 hidden-xs">
                                <span class="httpMethods webServiceShowDetails">
                                    <g:each in="${webService.httpMethod}" var="httpMethod">
                                        <span class="httpMethod httpMethod-${httpMethod}">
                                            <a href="#" class="wsLabel" data-toggle="tooltip" data-placement="top" title="" data-original-title="This service supports HTTP ${httpMethod} request">
                                                ${httpMethod}
                                            </a>
                                        </span>
                                    </g:each>
                                </span>

                                <span class="outputLabels webServiceShowDetails">
                                    <g:each in="${webService.outputFormat}" var="outputFormat">
                                        <span class="outputFormat">
                                            <a href="#" class="wsLabel" data-toggle="tooltip" data-placement="top" title="" data-original-title="This service returns data in ${outputFormat.toUpperCase()} format">
                                                ${outputFormat?.toUpperCase()}
                                            </a>
                                        </span>
                                    </g:each>
                                    <g:if test="${webService.deprecated}">
                                        <span class="deprecatedLabel webServiceShowDetails">
                                            <a href="#" class="wsLabel" data-toggle="tooltip" data-placement="top" title="" data-original-title="This service is deprecated and may be removed in future versions">
                                                DEPRECATED
                                            </a>
                                        </span>
                                    </g:if>
                                </span>
                            </span>

                            <span class="col-md-12 visible-xs">
                                <ul class="inline">
                                    <g:each in="${webService.httpMethod}" var="httpMethod">
                                        <li class="label label-http-${httpMethod}">${httpMethod}</li>
                                    </g:each>
                                    <g:each in="${webService.outputFormat}" var="outputFormat">
                                        <li class="label">${outputFormat?.toUpperCase()}</li>
                                    </g:each>
                                    <g:if test="${webService.deprecated}">
                                        <li class="label label-important">DEPRECATED</li>
                                    </g:if>
                                </ul>
                            </span>
                        </div>

                        <g:set var="returnTo" value="/#ws${webService.id}"/>
                    </h4>

                    <div id="webService-details-${webService.id}" class="webServiceDetails" style="display:none">
                        <p><markdown:renderHtml>${encodeAs([codec: 'raw'], webService.description)}</markdown:renderHtml></p>

                        <g:if test="${webService.params}">
                            <table class="table table-bordered table-striped table-condensed">
                                <g:each in="${webService.getSortedParams()}" var="param">
                                    <tr>
                                        <td>${param.name}
                                            <g:if test="${param.mandatory}"><span class="required-indicator">*</span></g:if>
                                            <g:if test="${param.deprecated}"><span class="deprecated-indicator text-warning">(deprecated)</span></g:if>
                                        </td>
                                        <td>${param.type}</td>
                                        <td>
                                            <span class="paramDescription">
                                                <markdown:renderHtml>${encodeAs([codec: 'raw'], param.description)}</markdown:renderHtml>
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
                                            <span class="editorFunctions" style="">
                                                <span class="pull-right" style="z-index: 100;">
                                                    <g:link controller="example" action="edit" id="${example.id}"
                                                            params="[returnTo: returnTo]" class="btn btn-xs btn-ala"><i
                                                            class="fa fa-edit"></i>Edit</g:link>
                                                </span>
                                            </span>

                                            <h5 class="" style="display: inline-block;">${example.name}</h5>

                                            <p><markdown:renderHtml>${encodeAs([codec: 'raw'], example.description)}</markdown:renderHtml></p>
                                            <p>
                                                URL: <a href="${example.getQueryUrl()}">${example.getQueryUrl()}</a>
                                                <g:if test="${example.onlineViewer}">
                                                    <br/>
                                                    Online demo: <a href="${example.onlineViewer}">${example.onlineViewer}</a>
                                                </g:if>
                                                <br/>
                                                <g:if test='${example.machineCallable && webService.httpMethod.contains("GET")}'>
                                                    <a href="${createLink(controller: 'example', action: 'graph', id: example.id)}">History</a>
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