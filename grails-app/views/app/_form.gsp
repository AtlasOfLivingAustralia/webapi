<%@ page import="au.org.ala.webapi.App" %>



<div class="fieldcontain ${hasErrors(bean: appInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="app.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${appInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: appInstance, field: 'shortDescription', 'error')} ">
	<label for="shortDescription">
		<g:message code="app.shortDescription.label" default="Short Description" />
		
	</label>
	<g:textField name="shortDescription" maxlength="200" value="${appInstance?.shortDescription}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: appInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="app.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${appInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: appInstance, field: 'baseUrl', 'error')} ">
	<label for="baseUrl">
		<g:message code="app.baseUrl.label" default="Base Url" />
		
	</label>
	<g:textField name="baseUrl" value="${appInstance?.baseUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: appInstance, field: 'webservices', 'error')} ">
	<label for="webservices">
		<g:message code="app.webservices.label" default="Webservices" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${appInstance?.webservices?}" var="w">
    <li><g:link controller="webService" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="webService" action="create" params="['app.id': appInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'webService.label', default: 'WebService')])}</g:link>
</li>
</ul>

</div>

