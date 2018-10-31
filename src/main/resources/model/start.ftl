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

<#list amit.generate( "project","lib.ftl", resultPath  + "/u/Lib.java" ) as processed>
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

<#list amit.generate( "exception","json.exception.ftl", resultPath + "/json/%sSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "interface","interface.ftl", resultPath + "/intrf/%s.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "interface","json.call.ftl", resultPath + "/json/call/Call%s.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "validation","validator.ftl", resultPath + "/validation/%sValidation.java" ) as processed>
done: ${processed}
</#list>


<#list amit.generate( "project","json.boolean.ftl", resultPath  + "/json/booleanSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.integer.ftl", resultPath  + "/json/intSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.long.ftl", resultPath  + "/json/longSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.double.ftl", resultPath  + "/json/doubleSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.uuid.ftl", resultPath  + "/json/uuidSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.datetime.ftl", resultPath  + "/json/datetimeSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.string.ftl", resultPath  + "/json/stringSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","exception.server.ftl", resultPath  + "/exception/ServerException.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","exception.validation.ftl", resultPath  + "/exception/ValidationException.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","exception.internal.ftl", resultPath  + "/exception/InternalException.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","exception.denied.ftl", resultPath  + "/exception/AccessDeniedException.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","exception.expired.ftl", resultPath  + "/exception/AccessExpiredException.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.exception.denied.ftl", resultPath  + "/json/exception/AccessDeniedExceptionSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.exception.expired.ftl", resultPath  + "/json/exception/AccessExpiredExceptionSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.exception.internal.ftl", resultPath  + "/json/exception/InternalExceptionSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.exception.validation.ftl", resultPath  + "/json/exception/ValidationExceptionSerializer.java" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "project","json.exception.list.ftl", resultPath  + "/json/exception/RuntimeExceptionSerializers.java" ) as processed>
done: ${processed}
</#list>
