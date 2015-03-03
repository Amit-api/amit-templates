Start generate ...

<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign thisJavaPackage = modelJavaPackage + ".servlet" >
<#assign resultPath = amit.toPath( thisJavaPackage, "\\.") >

<#list amit.generate( "service","service.ftl", resultPath + "/%sServlet.java" ) as processed>
done: ${processed}
</#list>

End generate.
