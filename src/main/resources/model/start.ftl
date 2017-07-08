Start generate ...
<#import "macros.ftl" as my>
<#assign attrJavaPackage = my.getJavaPackage() >

<#assign resultPath = amit.toPath( attrJavaPackage, "\\.") >

<#list amit.generate( "type","type.ftl", resultPath + "/%s.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "type","json.type.ftl", resultPath  + "/json/%sSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","lib.ftl", resultPath  + "/u/Lib.java" )as processed>
done: ${processed}
</#list>

<#list amit.generate( "enum","enum.ftl", resultPath + "/%s.java" ) as processed>
done: ${processed}
</#list>
<#list amit.generate( "enum","json.enum.ftl", resultPath + "/json/%sSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "exception","exception.ftl", resultPath + "/%s.java" ) as processed>
done: ${processed}
</#list>