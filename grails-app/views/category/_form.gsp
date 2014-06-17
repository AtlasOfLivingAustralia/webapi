<%@ page import="au.org.ala.webapi.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="category.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${categoryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'shortDescription', 'error')} ">
	<label for="shortDescription">
		<g:message code="category.shortDescription.label" default="Short Description" />
		
	</label>
	<g:textField name="shortDescription" maxlength="200" value="${categoryInstance?.shortDescription}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="category.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${categoryInstance?.description}"/>
</div>

