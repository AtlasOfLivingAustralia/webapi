<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <asset:stylesheet src="webapi"></asset:stylesheet>
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}"/>
    <meta name="breadcrumbs"
          content="${createLink(uri: '/')},${grailsApplication.config.application.title}\\${createLink(class: 'list', action:'index')},${message(code: 'default.list.label', args: [entityName])}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div id="edit-example" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.example}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.example}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form resource="${this.example}" method="PUT">
        <g:hiddenField name="version" value="${this.example?.version}"/>
        <fieldset class="form">
            <f:all bean="example" except="params,runs,webService"/>
        </fieldset>


        <table id="tableTemplate" style="display:none">
            <tr class="paramRowTemplate">
                <g:render template="param"/>
            </tr>
        </table>

        <div class="well well-small" style="margin-top:30px;">

            <h3>Parameters

                <span class="pull-right">
                    <a href="javascript:void(0);" class="btn btn-ala" id="addRowBtn"><i
                            class="fa fa-plus"></i>&nbsp;Add&nbsp;parameter</a>
                </span>
            </h3>
            <table class="table">
                <thead id="paramThead" class="${this.example.params ? '' : 'hide'}">
                <th>Name</th>
                <th>Value</th>
                <th></th>
                </thead>
                <tbody id="paramsTBody">
                <g:if test="${this.example.params}">
                    <g:each in="${this.example.getSortedParams()}" var="param" status="paramStatus">
                        <tr>
                            <g:render template="param" model="[param: param, paramStatus: paramStatus]"/>
                        </tr>
                    </g:each>
                </g:if>
                </tbody>
            </table>
        </div>

        <fieldset class="buttons">
            <input class="save" type="submit"
                   value="${message(code: 'default.button.update.label', default: 'Update')}"/>
        </fieldset>

    </g:form>

</div>

<asset:script>
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
</asset:script>
</body>
</html>
