<#-- *********************************************************************************************** -->
<#-- function to get java package -->
<#-- *********************************************************************************************** -->
<#function getJavaPackage >
	<#return project.getProjectModule().getAttributeValue( "java_package", "com.noname" ) >
</#function>

<#-- *********************************************************************************************** -->
<#-- *********************************************************************************************** -->
<#function javaTypeNoArray member >
	<#assign javaPackage = getJavaPackage() >
	<#assign value = "unknown" >
	<#switch member.getTypeName()>
		<#case "void">
			<#assign value = "void" >
		<#break>
		<#case "boolean">
			<#assign value = "java.lang.Boolean" >
		<#break>
		<#case "int">
			<#assign value = "java.lang.Integer" >
		<#break>
		<#case "string">
			<#assign value = "java.lang.String" >
		<#break>
		<#case "long">
			<#assign value = "java.lang.Long" >
		<#break>
		<#case "double">
			<#assign value = "java.lang.Double" >
		<#break>
		<#case "uuid">
			<#assign value = "java.util.UUID" >
		<#break>
		<#case "datetime">
			<#assign value = "java.time.LocalDateTime" >
		<#break>
		<#default>
			<#assign value = javaPackage + "." + member.getTypeName() >
	</#switch>

	<#return value >
</#function>

<#-- *********************************************************************************************** -->
<#-- function to get java type from the model type -->
<#-- *********************************************************************************************** -->
<#function javaType member >
	<#assign value = javaTypeNoArray( member ) >
	<#if member.isArray() >
		<#return "java.util.List<" + value + ">" >
	<#else>
		<#return value >
	</#if>
</#function>

<#-- *********************************************************************************************** -->
<#-- generates throws exceptions                                                           -->
<#-- *********************************************************************************************** -->
<#macro throwsExceptions items >
<#assign javaPackage = getJavaPackage() >
<#if items?size != 0 >
<#list items as item >
				${javaPackage}.${item}<#if item_has_next>, </#if>
</#list></#if>
</#macro>