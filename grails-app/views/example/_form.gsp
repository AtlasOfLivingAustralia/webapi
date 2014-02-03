<%@ page import="au.org.ala.webapi.Param; au.org.ala.webapi.Example" %>

<div class="fieldcontain ${hasErrors(bean: exampleInstance, field: 'webService', 'error')} required">
    <g:if test="${webService}">
        %{--<g:textField name="webService.name" value="${webService?.name} />--}%
        <g:hiddenField name="webService.id" value="${webService.id}"/>
    </g:if>
    <g:else>
        <label for="webService">
            <g:message code="example.webService.label" default="Web Service"/>
            <span class="required-indicator">*</span>
        </label>
        <g:select id="webService" name="webService.id" from="${au.org.ala.webapi.WebService.list()}" optionKey="id"
                  required="" value="${exampleInstance?.webService?.id}" class="many-to-one"/>
    </g:else>
</div>

<div class="fieldcontain ${hasErrors(bean: exampleInstance, field: 'name', 'error')} ">
    <label for="name">
        <g:message code="example.name.label" default="Name of the example e.g. Search for kangaroo"/>

    </label>
    <g:textField name="name" value="${exampleInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exampleInstance, field: 'description', 'error')} ">
    <label for="description">
        <g:message code="example.description.label" default="Description (use markdown if you wish)"/>
    </label>
    <g:textArea name="description" class="input-xxlarge" rows="5" value="${exampleInstance?.description}"/>
</div>

<div class="well well-small">

<h3>Parameters

<span class="pull-right">
    <a href="javascript:void(0);" class="btn" id="addRowBtn"><i class="icon-plus"></i>&nbsp;Add&nbsp;parameter</a>
</span>

</h3>
<table class="table">
    <thead id="paramThead" class="${exampleInstance.params ? '' : 'hide'}">
        <th>Name</th>
        <th>Value</th>
        <th></th>
    </thead>
    <tbody id="paramsTBody">
        <g:if test="${exampleInstance.params}">
            <g:each in="${exampleInstance.params}" var="param">
                <tr>
                     <g:render template="param"/>
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
    })
</r:script>
