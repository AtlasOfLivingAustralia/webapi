<%@ page import="au.org.ala.webapi.Example" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/> | Web service API | ${grailsApplication.config.skin.orgNameLong}</title>
</head>

<body>
<a href="#show-example" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>
<ul class="breadcrumb" role="navigation">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
    <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
    <li class="active"><g:message code="default.show.label" args="[entityName]"/></li>
</ul>

<div id="show-example" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list example">

        <g:if test="${exampleInstance?.name}">
            <li class="fieldcontain">
                <span id="name-label" class="property-label"><g:message code="example.name.label"
                                                                        default="Name"/></span>

                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${exampleInstance}"
                                                                                        field="name"/></span>

            </li>
        </g:if>

        <g:if test="${exampleInstance?.description}">
            <li class="fieldcontain">
                <span id="description-label" class="property-label"><g:message code="example.description.label"
                                                                               default="Description"/></span>

                <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${exampleInstance}"
                                                                                               field="description"/></span>

            </li>
        </g:if>

        <g:if test="${exampleInstance?.dateCreated}">
            <li class="fieldcontain">
                <span id="dateCreated-label" class="property-label"><g:message code="example.dateCreated.label"
                                                                               default="Date Created"/></span>

                <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                        date="${exampleInstance?.dateCreated}"/></span>

            </li>
        </g:if>

        <g:if test="${exampleInstance?.lastUpdated}">
            <li class="fieldcontain">
                <span id="lastUpdated-label" class="property-label"><g:message code="example.lastUpdated.label"
                                                                               default="Last Updated"/></span>

                <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                        date="${exampleInstance?.lastUpdated}"/></span>

            </li>
        </g:if>

        <g:if test="${exampleInstance?.params}">
            <li class="fieldcontain">
                <span id="params-label" class="property-label"><g:message code="example.params.label"
                                                                          default="Params"/></span>

                <g:each in="${exampleInstance.params}" var="p">
                    <span class="property-value" aria-labelledby="params-label"><g:link controller="exampleParam"
                                                                                        action="show"
                                                                                        id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
                </g:each>

            </li>
        </g:if>

        <li class="fieldcontain">
            <span id="machineCallable-label" class="property-label"><g:message code="example.machineCallable.label"
                                                                           default="Machine Callable"/></span>

            <span class="property-value" aria-labelledby="machineCallable-label">
                <g:fieldValue bean="${exampleInstance}" field="machineCallable"/>
            </span>

        </li>

        <g:if test="${exampleInstance?.webService}">
            <li class="fieldcontain">
                <span id="webService-label" class="property-label"><g:message code="example.webService.label"
                                                                              default="Web Service"/></span>

                <span class="property-value" aria-labelledby="webService-label"><g:link controller="webService"
                                                                                        action="show"
                                                                                        id="${exampleInstance?.webService?.id}">${exampleInstance?.webService?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${exampleInstance?.id}"/>
            <g:link class="edit" action="edit" id="${exampleInstance?.id}"><g:message code="default.button.edit.label"
                                                                                      default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
