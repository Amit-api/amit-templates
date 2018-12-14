<#import "macros.ftl" as my>
<#assign attrJavaPackage = my.getJavaPackage() >
<#assign objectName = object.getName() >
/**
 * This file is generated by the Amit
 * don't modify it manually
 */
package ${attrJavaPackage}.intrf.async;

/**
 * interface ${objectName}
 */
public interface ${objectName} <@my.extendsInterfaces items=object.getBaseInterfaceNames() />{
<#list object.getFunctions() as function >
	<#assign fname = function.getName() >
	<#assign rtype = my.javaType( function.getReturn() ) >
	
<#if rtype == "void" >
	<#assign rtype = "java.lang.Void" >
</#if>	
	
	/**
	 * function ${fname}
	 */
	java.util.concurrent.CompletableFuture<${rtype}> ${fname}(
	<#list function.getArguments() as arg >
		<#assign aname = arg.getName() >
		<#assign atype = my.javaType( arg ) >
		${atype} ${aname}<#if arg_has_next>,</#if>
	</#list>
	);
</#list>
}