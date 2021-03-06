<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign thisJavaPackage = modelJavaPackage + ".json" >
<#assign objectName = object.getName() >
<#assign childrenTypes = project.getCompositeTypeChildren( objectName ) >
<#assign baseClassName = object.getBaseTypeName()!'' >
/**
 * This file is generated by the Amit
 * don't modify it manually
 */
package ${thisJavaPackage};

/**
 * type ${objectName}
 */
public class ${objectName}Serializer {

<@my.writeValueFunction className=objectName classPackage=modelJavaPackage />

<@my.readValueFunction className=objectName classPackage=modelJavaPackage />

<@my.writeMembersFunction items=object.getAllMembers() className=objectName baseClassName=baseClassName classPackage=modelJavaPackage serializerPrefix="" />

<@my.writeDynamicMembersFunction children=childrenTypes className=objectName />

<@my.readMemberFunction items=object.getAllMembers() className=objectName classPackage=modelJavaPackage />

<@my.readDynamicMembersFunction children=childrenTypes className=objectName />

<@my.memberReaders items=object.getAllMembers() className=objectName classPackage=modelJavaPackage serializerPrefix="" />
}

