Start generate ...

<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign thisJavaPackage = modelJavaPackage + ".client" >
<#assign resultPath = amit.toPath( thisJavaPackage, "\\.") >

<#list amit.generate( "service","service.ftl", resultPath + "/%sClient.java" ) as processed>
done: ${processed}
</#list>

End generate.
