<td class="paramName" style="width:100px">
    <g:hiddenField name="paramId" value="${param?.id}" />
    <g:textField name="paramName" value="${param?.name}" class="input-small"/>
    <br/>
</td>
<td class="paramType" style="width:100px">
    <g:select name="paramType" class="input-small" style="width:100px" from="${au.org.ala.webapi.Param.paramTypes}"
              value="${param?.type}"/>
</td>
<td class="paramCheckboxes" style="width:150px">
    <div class="checkbox">
        <input type="hidden" name="_paramMandatory" value="${param?.mandatory?'true':'false'}"/>
        <input type="checkbox" class="paramCheckbox" name="paramMandatory"  value="${param?.mandatory}"
            <g:if test="${param?.mandatory}">checked="checked"</g:if>
        />
        Mandatory
    </div>
    <div class="checkbox">
        <input type="hidden" name="_paramDeprecated" value="${param?.deprecated?'true':'false'}"/>
        <input type="checkbox" class="paramCheckbox" name="paramDeprecated" value="${param?.deprecated}"
            <g:if test="${param?.deprecated}">checked="checked"</g:if>
        />
        Deprecated
    </div>
    <div class="checkbox">
        <input type="hidden" name="_paramIncludeInTitle" value="${param?.includeInTitle?'true':'false'}"/>
        <input type="checkbox" class="paramCheckbox" name="paramIncludeInTitle" value="${param?.includeInTitle}"
            <g:if test="${param?.includeInTitle}">checked="checked"</g:if>
        />
        Include in title
    </div>
</td>
<td class="paramDescription">
    <g:textArea name="paramDescription" rows="6" class="input-xxlarge" style="width:400px"
                value="${param?.description}"/>
</td>
<td><a class="deleteParam btn btn-danger" href="javascript:void(0);"><i class="icon-minus icon-white"></i><span class="hidden-phone">&nbsp;Delete</span></td>