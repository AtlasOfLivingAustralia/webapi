<%@ page import="au.org.ala.webapi.Param" %>
<td class="paramName">
    <g:select name="paramId" from="${Param.findAllByWebService(this.example.webService)}" optionKey="id"
              value="${param?.param?.id}"/>
</td>
<td class="paramDescription">
    <g:textArea name="paramValue" rows="1" class="input-xxlarge" value="${param?.value}"/>
</td>
<td>
    <a class="deleteParam btn btn-danger" href="javascript:void(0);"><i class="icon-minus icon-white"></i><span class="hidden-phone">&nbsp;Delete</span></a>
</td>