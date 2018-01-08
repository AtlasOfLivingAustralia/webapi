<%@ page import="au.org.ala.webapi.Format; au.org.ala.webapi.WebService" %>

<input type="hidden" name="returnTo" value="${params.returnTo}"/>

<div class="container-fluid">
    <div class="row">

        <div class="col-md-7">
            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'app', 'error')} required">
                <label for="app">
                    <g:message code="webService.app.label" default="App"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:select id="app" name="app.id" from="${au.org.ala.webapi.App.list()}" optionKey="id" required=""
                          value="${this.webService?.app?.id}" class="many-to-one"/>
            </div>

            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'name', 'error')} ">
                <label for="name">
                    <g:message code="webService.name.label" default="Name"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:textField name="name" value="${this.webService?.name}" class="input-xxlarge  span12"/>
            </div>

            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'url', 'error')} ">
                <label for="url">
                    <g:message code="webService.url.label"
                               default="Url (must start with / and exclude the base URL for the webapp)"/>
                </label>
                <g:textField name="url" value="${this.webService?.url}" class="input-xxlarge  span12"/>
            </div>

            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'description', 'error')} ">
                <label for="description">
                    <g:message code="webService.description.label" default="Description (use markdown if required)"/>
                </label>
                <g:textArea name="description" cols="40" rows="5" maxlength="${java.lang.Integer.MAX_VALUE}"
                            class="input-xxlarge span12" value="${this.webService?.description}"/>
            </div>

            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'exampleOutput', 'error')} ">
                <label for="exampleOutput">
                    <g:message code="webService.exampleOutput.label"
                               default="Example output (use markdown if required)"/>
                </label>
                <g:textArea name="exampleOutput" cols="40" rows="5" maxlength="${java.lang.Integer.MAX_VALUE}"
                            class="input-xxlarge span12" value="${this.webService?.exampleOutput}"/>
            </div>
        </div>

        <div class="col-md-5">

            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'httpMethod', 'error')} ">
                <label for="httpMethod">
                    <g:message code="webService.httpMethod.label" default="Http Method"/>

                </label>
                <g:select name="httpMethod" multiple="true" from="${this.webService.httpMethods}"
                          value="${this.webService?.httpMethod}" valueMessagePrefix="webService.httpMethod"
                          noSelection="['': '']"/>
            </div>

            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'deprecated', 'error')} ">

                <label class="checkbox">
                    <g:checkBox name="deprecated" value="${this.webService?.deprecated}"/>
                    <g:message code="webService.deprecated.label" default="Deprecated"/>
                </label>

            </div>

            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'outputFormat', 'error')} ">
                <label for="outputFormat">
                    <g:message code="webService.outputFormat.label" default="Output Format"/>

                </label>
                <g:select name="outputFormat" multiple="true" from="${Format.stringList()}"
                          value="${this.webService?.outputFormat}" valueMessagePrefix="webService.outputFormat"
                          noSelection="['': '']"/>
            </div>


            <div class="fieldcontain ${hasErrors(bean: this.webService, field: 'categories', 'error')} ">
                <label for="categories">
                    <g:message code="webService.categories.label" default="Categories (multi-select)"/>

                </label>
                <g:select name="categories" from="${au.org.ala.webapi.Category.list()}" multiple="multiple"
                          optionKey="id"
                          size="8" value="${this.webService?.categories*.id}" class="many-to-many"/>
            </div>

        </div>
</div>

</div> <!-- row fluid -->

<div class="well well-small" style="padding-bottom:50px;margin-top:30px;">

    <h3>Parameters

    </h3>

    <g:if test="${this.webService.id && this.webService.examples}">
        <h4 class="text-warning">
            Note this service has ${this.webService.examples.size()} example${this.webService.examples.size() > 1 ? 's' : ''} associated with it. <br/>
            Removing/changing field names may affect existing examples if they are using the parameters you change.
        </h4>
    </g:if>

    <table class="table">
        <thead id="paramThead">
        <th>Name</th>
        <th>Data type</th>
        <th></th>
        <th>Description (use markdown for formatting)</th>
        <th></th>
        </thead>
        <tbody id="paramsTBody">
        <g:if test="${this.webService.params}">
            <g:each in="${this.webService.getSortedParams()}" var="param" status="paramStatus">
                <tr>
                    <g:render template="param" model="[param: param, paramStatus: paramStatus]"/>
                </tr>
            </g:each>
        </g:if>
        </tbody>
    </table>
    <span class="pull-right">
        <a href="javascript:void(0);" class="btn addRowBtn btn-ala"><i class="icon-plus"></i>&nbsp;Add&nbsp;parameter
        </a>
    </span>

</div>


<asset:script>
    $(function(){
        $('.addRowBtn').click(function(){
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
</asset:script>
