<%@ page import="au.org.ala.webapi.WebService" %>

<input type="hidden" name="returnTo" value="${params.returnTo}"/>

<div class="row-fluid">

<div class="span9">

<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'app', 'error')} required">
	<label for="app">
		<g:message code="webService.app.label" default="App" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="app" name="app.id" from="${au.org.ala.webapi.App.list()}" optionKey="id" required="" value="${webServiceInstance?.app?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="webService.name.label" default="Name" />
        <span class="required-indicator">*</span>
	</label>
	<g:textField name="name" value="${webServiceInstance?.name}" class="input-xxlarge  span12"/>
</div>

<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'url', 'error')} ">
	<label for="url">
		<g:message code="webService.url.label" default="Url (must start with / and exclude the base URL for the webapp)" />
	</label>
	<g:textField name="url" value="${webServiceInstance?.url}" class="input-xxlarge  span12"/>
</div>

<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="webService.description.label" default="Description (use markdown if required)" />
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" class="input-xxlarge span12" value="${webServiceInstance?.description}"/>
</div>

</div>
<div class="span3">

<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'httpMethod', 'error')} ">
	<label for="httpMethod">
		<g:message code="webService.httpMethod.label" default="Http Method" />
		
	</label>
	<g:select name="httpMethod" from="${webServiceInstance.constraints.httpMethod.inList}" value="${webServiceInstance?.httpMethod}" valueMessagePrefix="webService.httpMethod" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'deprecated', 'error')} ">

    <label class="checkbox">
      <g:checkBox name="deprecated" value="${webServiceInstance?.deprecated}" />
      <g:message code="webService.deprecated.label" default="Deprecated" />
    </label>

</div>

<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'outputFormat', 'error')} ">
	<label for="outputFormat">
		<g:message code="webService.outputFormat.label" default="Output Format" />
		
	</label>
	<g:select name="outputFormat" from="${webServiceInstance.constraints.outputFormat.inList}" value="${webServiceInstance?.outputFormat}" valueMessagePrefix="webService.outputFormat" noSelection="['': '']"/>
</div>


<div class="fieldcontain ${hasErrors(bean: webServiceInstance, field: 'categories', 'error')} ">
	<label for="categories">
		<g:message code="webService.categories.label" default="Categories (multi-select)" />
		
	</label>
	<g:select name="categories" from="${au.org.ala.webapi.Category.list()}" multiple="multiple" optionKey="id" size="8" value="${webServiceInstance?.categories*.id}" class="many-to-many"/>
</div>

</div>

</div> <!-- row fluid -->

<div class="well well-small">

<h3>Parameters

<span class="pull-right">
    <a href="javascript:void(0);" class="btn" id="addRowBtn"><i class="icon-plus"></i>&nbsp;Add&nbsp;parameter</a>
</span>

</h3>

<g:if test="${webServiceInstance.id && webServiceInstance.examples}">
<h4 class="text-warning">
Note this service has ${webServiceInstance.examples.size()} example${webServiceInstance.examples.size()>1 ?'s':''} associated with it. <br/>
Removing/changing field names may affect existing examples if they are using the parameters you change.
</h4>
</g:if>

<table class="table">
    <thead id="paramThead" class="${webServiceInstance.params ? '' : 'hide'}">
        <th>Name</th>
        <th>Data type</th>
        <th></th>
        <th>Description (use markdown for formatting)</th>
        <th></th>
    </thead>
    <tbody id="paramsTBody">
        <g:if test="${webServiceInstance.params}">
            <g:each in="${webServiceInstance.getSortedParams()}" var="param" status="paramStatus">
                <tr>
                    <g:render template="param" model="[param:param, paramStatus:paramStatus]"/>
                </tr>
            </g:each>
       </g:if>
    </tbody>
</table>

</div>


<r:script>
    $(function(){
        $('#addRowBtn').click(function(){
            var clone = $('#tableTemplate').find('.paramRowTemplate').clone();
            clone.find('.deleteParam').click(function(){
                 $(this).parent().parent().remove();
            });
            $('#paramsTBody').append(clone);
            $('#paramThead').show();
        });

        $('.deleteParam').click(function(){
            $(this).parent().parent().remove();
        });

        $('.paramCheckbox').click(function(){
            var $this = $(this);
            if($this.is(':checked')){
                $this.siblings('input').val('true')
            } else {
                $this.siblings('input').val('false')
            }
        });
    })
</r:script>
