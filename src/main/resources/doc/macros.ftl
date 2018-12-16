<#-- *********************************************************************************************** -->
<#-- function to convert type to value  -->
<#-- *********************************************************************************************** -->
<#function typeToValue type >
	<#assign value = '...' >
	<#switch type>
		<#case "void">
			<#assign value = "null" >
		<#break>
		<#case "boolean">
			<#assign value = "false" >
		<#break>
		<#case "int">
			<#assign value = "0" >
		<#break>
		<#case "string">
			<#assign value = '"..."' >
		<#break>
		<#case "long">
			<#assign value = "0" >
		<#break>
		<#case "double">
			<#assign value = "0.0" >
		<#break>
		<#case "uuid">
			<#assign value = '"465f6432-2f86-4bbe-b704-142fa8ca6860"' >
		<#break>
		<#case "datetime">
			<#assign value = '"1977-06-21T10:15:30"' >
		<#break>
	</#switch>
	<#return value >
</#function>

<#-- *********************************************************************************************** -->
<#-- function call to json  -->
<#-- *********************************************************************************************** -->
<#macro functionToJson function >
<#if function.getArguments()?size != 0 >
{
<#list function.getArguments() as argument >
<@argumentToJson argument 1 10 /><#if argument_has_next>, </#if>
</#list>
}</#if></#macro>

<#-- *********************************************************************************************** -->
<#-- type name to json  -->
<#-- *********************************************************************************************** -->
<#macro typeNameToJson typeName isArray isMap>
<@argumentValueToJson typeName isArray isMap 2 11 /></#macro>

<#-- *********************************************************************************************** -->
<#-- function expand argument to json -->
<#-- *********************************************************************************************** -->
<#macro argumentToJson argument depth maxDepth >
${""?right_pad(2*depth)}"${argument.getName()}" : <@argumentValueToJson argument.getTypeName() argument.isMap() argument.isArray() depth maxDepth/></#macro>

<#-- *********************************************************************************************** -->
<#-- function expand argument value to json -->
<#-- *********************************************************************************************** -->
<#macro argumentValueToJson typeName isArray isMap depth maxDepth >
<#assign tvalue = typeToValue(typeName) >
<#if tvalue = "..." >
<#assign type = project.getType(typeName) >
<#if isArray >[<@typeToJson type depth maxDepth />]<#elseif isMap>{"key": <@typeToJson type depth maxDepth />}<#else><@typeToJson type depth maxDepth /></#if><#else><#if isArray >[${tvalue},${tvalue}]<#elseif isMap>{"key": ${tvalue}}<#else>${tvalue}</#if></#if></#macro>

<#-- *********************************************************************************************** -->
<#-- function type to json -->
<#-- *********************************************************************************************** -->
<#macro typeToJson type depth maxDepth >
<#switch type.getType()>
<#case "exception">
<@compositeToJson type true depth maxDepth />
<#break>
<#case "type">
<@compositeToJson type false depth maxDepth />
<#break>
<#case "enum">
<@enumToJson type />
<#break>
</#switch>
</#macro>

<#-- *********************************************************************************************** -->
<#-- function type to json -->
<#-- *********************************************************************************************** -->
<#macro enumToJson enum >
<#list enum.getValues() as val> <#if val.getIntegerValue()?? >${val.getIntegerValue()}<#else>"${val.getStringValue()}"</#if><#if val_has_next> | </#if></#list></#macro>

<#-- *********************************************************************************************** -->
<#-- function to expand composite type as Json  -->
<#-- *********************************************************************************************** -->
<#macro compositeToJson type showType depth maxDepth >
{
<#if showType >
${""?right_pad(2*depth+2)}"__type" : "${type.getName()}"<#if type.getMembers()?size != 0 >,</#if>
</#if>
<#list type.getMembers() as arg >
<@argumentToJson arg depth+1 maxDepth /><#if arg_has_next>,</#if>
</#list> 
${""?right_pad(2*depth)}}</#macro>

