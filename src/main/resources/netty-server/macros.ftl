<#-- *********************************************************************************************** -->
<#-- function to get java package -->
<#-- *********************************************************************************************** -->
<#function getJavaPackage >
	<#return project.getProjectModule().getAttributeValue( "java_package", "com.noname" ) >
</#function>

