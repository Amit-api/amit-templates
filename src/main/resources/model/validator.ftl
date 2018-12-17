<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign thisJavaPackage = modelJavaPackage + ".validation" >
<#assign objectName = object.getName() >
<#assign objectType = object.getTypeName() >
/**
 * This file is generated by the Amit
 * don't modify it manually
 */
package ${thisJavaPackage};

import ${modelJavaPackage}.exception.ValidationException;

public final class ${objectName}Validation {
<#list object.getFieldConditions() as fcond >
	<#list fcond.getConditions() as cond >
		<#if cond.getType().name() == "REGEX" >
	private static final java.util.regex.Pattern pattern_${fcond.getName()} = 
		java.util.regex.Pattern.compile(${cond.getValue()});
		</#if>
	</#list>
</#list>

	public static void validate( java.lang.String prefix, ${modelJavaPackage}.${objectType} object ) throws ValidationException {
<#assign typeMember = project.getType(objectType) >
<#list object.getFieldConditions() as fcond >
	<#assign getterName = "object.get" + fcond.getName()?cap_first +"()" >
	<#assign member = typeMember.getMember(fcond.getName()) >
	<#assign javaType = my.javaTypeNoArray(member) >
	
	<#if fcond.isArray() >
		<#assign data = "item">
		// check field ${member.getTypeName()}[] ${fcond.getName()}
		for( ${javaType} item : ${getterName} ) {
	<#elseif fcond.isMap() >
		<#assign data = "item">
		// check field ${member.getTypeName()}{} ${fcond.getName()}
		for( ${javaType} item : ${getterName}.values() ) {
	<#else>
		<#assign data = getterName>
		// check field ${member.getTypeName()} ${fcond.getName()}
	</#if>
	<#list fcond.getConditions() as cond >
		<@my.validationCondition cond=cond  field=data prefix="prefix" />
	</#list>
	<#if fcond.isArray() >
		}
	<#elseif fcond.isMap() >
		}
	<#else>
	</#if>
</#list>
	}
}