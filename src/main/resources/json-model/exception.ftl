<#import "macros.ftl" as my>
<#assign attrJavaPackage = project.getProjectModule().getAttributeValue( "java_package", "com.noname" ) >
<#assign objectName = object.getName() >
/**
 * This file is generated by the Amit
 * don't modify it manually
 */
package ${attrJavaPackage};

/**
 * type ${objectName}
 */
public class ${objectName} ${my.baseType( object )} {
	private static final long serialVersionUID = 1L;
	
	public ${objectName}() {
	}
	
	public ${objectName}( java.lang.String message ) {
		super( message );
	}

<@my.classMembers items=object.getMembers() />
<@my.classGettersSetters items=object.getMembers() className=objectName />

<@my.hashCodeFunction items=object.getMembers() hasBaseType=true />

<@my.equalsFunction items=object.getMembers() className=objectName hasBaseType=true />

<@my.toStringFunction items=object.getMembers() className=objectName hasBaseType=true />

<@my.serializeFuctions className=objectName />

<@my.serializeMembersFunction items=object.getMembers() hasBaseType=true />
		
<@my.parseTokenFunction items=object.getMembers() hasBaseType=true />
	
<@my.classFactory name=objectName children=project.getExceptionTypeChildren( objectName ) />
}
