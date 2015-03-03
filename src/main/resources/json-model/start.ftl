Start generate ...
<#import "macros.ftl" as my>
<#assign attrJavaPackage = my.getJavaPackage() >

<#assign resultPath = amit.toPath( attrJavaPackage, "\\.") >


<#list amit.generate( "enum","enum.ftl", resultPath + "/%s.java" ) as processed>
done: ${processed}
</#list>


<#list amit.generate( "type","type.ftl", resultPath + "/%s.java" ) as processed>
done: ${processed}
</#list>


<#list amit.generate( "exception","exception.ftl", resultPath + "/%s.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "interface","interface.ftl", resultPath + "/intrf/%s.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "interface","interface-call.ftl", resultPath + "/call/Call%s.java" ) as processed>
done: ${processed}
</#list>

End generate.
