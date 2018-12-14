Start generate ...

<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign thisJavaPackage = modelJavaPackage + ".server.netty" >
<#assign resultPath = amit.toPath( thisJavaPackage, "\\.") >

<#list amit.generate( "service","service.ftl", resultPath + "/%sHttpHandler.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","server.ftl", resultPath + "/Server.java" ) as processed>
done: ${processed}
</#list>

End generate.
