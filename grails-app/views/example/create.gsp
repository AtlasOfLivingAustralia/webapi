<%@ page import="au.org.ala.webapi.Param; au.org.ala.webapi.Example" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/> | Web service API | ${grailsApplication.config.skin.orgNameLong}</title>
</head>

<body>
<a href="#create-example" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                default="Skip to content&hellip;"/></a>
<ul class="breadcrumb" role="navigation">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
    <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
    <li class="active"><g:message code="default.create.label" args="[entityName]" /></li>
</ul>

<div id="create-example" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/>
    <g:if test="${webService}">
        <g:message code="default.create.for.service.label" default="for service"/>
        <g:link controller="webService" action="show" id="${webService.id}">
            ${webService.name}
        </g:link>
    </g:if>
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${exampleInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${exampleInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save">
        <fieldset class="form">
            <g:render template="form"/>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</div>

<table id="tableTemplate" class="hide">
    <tr class="paramRowTemplate">
        <g:render template="param"/>
    </tr>
</table>

</body>
</html>
