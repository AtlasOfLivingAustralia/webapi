<%@ page import="au.org.ala.webapi.Format" %>



<div class="fieldcontain ${hasErrors(bean: formatInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="format.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${formatInstance?.name}"/>
</div>

