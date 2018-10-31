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
	</#if>
	<#if member.isMap() >
		<#return "java.util.Map<java.lang.String, " + value + ">" >
	</#if>
	<#return value >
</#function>

<#-- *********************************************************************************************** -->
<#-- function to get type base type -->
<#-- *********************************************************************************************** -->
<#function baseType object >
	<#assign javaPackage = getJavaPackage() >
	<#if object.getBaseTypeName()?? >
		<#return " extends " + javaPackage + "." + object.getBaseTypeName() >
	<#else>
		<#if object.getType() == "exception" >
			<#return " extends java.lang.Exception">
		<#else>
			<#return "">
		</#if>
	</#if>
</#function>

<#-- *********************************************************************************************** -->
<#-- generates class members                                                                         -->
<#-- *********************************************************************************************** -->
<#macro classMembers items >
<#list items as item >
	<#assign jtype = javaType( item ) >
	<#assign name = item.getName() >	
	protected ${jtype} __${name};
</#list>
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates class getters and setters                                                             -->
<#-- *********************************************************************************************** -->
<#macro classGettersSetters items className >
<#list items as item >
	<#assign jtype = javaType( item ) >
	<#assign noarrayjtype = javaTypeNoArray( item ) >
	<#assign name = item.getName() >	
	<#assign Aname = item.getName()?cap_first >
	
	/**
	 * property ${name}
	 */
	public ${jtype} get${Aname}() {
		return __${name};
	}
	public void set${Aname}( ${jtype} value ) {
		this.__${name} = value;
	}
	public ${className} with${Aname}( ${jtype} value ) {
		this.__${name} = value;
		return this;	
	}		
	<#if item.isArray() >
	public ${className} with${Aname}Item( ${noarrayjtype} value ) {
		if( this.__${name} == null ) {
			this.__${name} = new java.util.ArrayList<${noarrayjtype}>();
		}
		this.__${name}.add( value );
		return this;	
	}
	</#if>
	<#if item.isMap() >
	public ${className} with${Aname}Item( java.lang.String key, ${noarrayjtype} value ) {		
		if( this.__${name} == null ) {
			this.__${name} = new java.util.HashMap<java.lang.String, ${noarrayjtype}>();
		}
		this.__${name}.put( key, value );
		return this;	
	}
	</#if>
</#list>
</#macro>
<#-- *********************************************************************************************** -->
<#-- generates hashCode function                                                                     -->
<#-- *********************************************************************************************** -->
<#macro hashCodeFunction items >
	/**
	 * {@inheritDoc}
	 */
	@Override
	public int hashCode() {
<#if items?size == 0 >
		return 0;
<#else>
		return java.util.Objects.hash(
<#list items as item >
	<#assign name = item.getName() >	
			this.__${name}<#if item_has_next>,</#if>
</#list>	
		);
</#if>		
	}
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates equals function                                                                       -->
<#-- *********************************************************************************************** -->
<#macro equalsFunction items className>
	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean equals( java.lang.Object obj ) {
		if( obj == null ) return false;
		if( !( obj instanceof ${className} ) ) return false;
<#if items?size == 0 >
		return true;
<#else>		
		${className} other = (${className}) obj;
		return 
<#list items as item >
	<#assign name = item.getName() >	
			java.util.Objects.equals( this.__${name}, other.__${name} ) <#if item_has_next>&&</#if>
</#list>	
		;
</#if>		
	}
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates toString function                                                                     -->
<#-- *********************************************************************************************** -->
<#macro toStringFunction items className >
	/**
	 * {@inheritDoc}
	 */
	@Override
	public String toString() {
		java.lang.StringBuilder sb = new java.lang.StringBuilder();
		sb.append( "${className} [" );
<#list items as item >
	<#assign name = item.getName() >	
		sb.append( "${name}" ).append( "=" ).append( this.__${name} )<#if item_has_next>.append( "," )</#if>;
</#list>
		sb.append( "]" );
		return sb.toString();
	}
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates writeMembers code                                                                 -->
<#-- *********************************************************************************************** -->
<#macro writeMembers items className serializerPrefix>
<#assign javaPackage = getJavaPackage() >
<#list items as item >
	<#assign type = item.getTypeName()>
	<#assign name = item.getName() >
	<#assign Aname = item.getName()?cap_first >
	<#assign elementValue = "object.get" + Aname + "()" >
		${serializerPrefix}${type}Serializer.writeValue( jg, "${name}", ${elementValue}, "${className}" );
</#list>
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates class serialization map -->
<#-- *********************************************************************************************** -->
<#macro writeDynamicMembersFunction className children >
<#assign javaPackage = getJavaPackage() >
	/**
	 * write the dynamic ${className} object to json
	 */
	public static void writeDynamic(
		com.fasterxml.jackson.core.JsonGenerator jg,
		${javaPackage}.${className} object
	) throws java.io.IOException {
<#if children?size !=0 >
		WRITER_MAPPING.get( object.getClass() ).write( jg, object );
<#else>
		write( jg, object );
</#if>
	}
	
	/**
	 * ${className} WRITER
	 */
	public static final ${javaPackage}.u.Lib.JsonWriter WRITER = new ${javaPackage}.u.Lib.JsonWriter() {
		public void write( com.fasterxml.jackson.core.JsonGenerator jg, java.lang.Object object ) throws java.io.IOException {
			${javaPackage}.json.${className}Serializer.
				write( jg, (${javaPackage}.${className})object );
		}
	};
<#if children?size !=0 >

	/**
	 * ${className} WRITER_MAPPING
	 */
	@SuppressWarnings("serial")
	private static final java.util.Map<java.lang.Class<?>, ${javaPackage}.u.Lib.JsonWriter> WRITER_MAPPING = 
		new java.util.HashMap<java.lang.Class<?>, ${javaPackage}.u.Lib.JsonWriter>() {{
			put( ${javaPackage}.${className}.class, WRITER );
<#list children as childTypeName >
			put( ${javaPackage}.${childTypeName}.class,${javaPackage}.json.${childTypeName}Serializer.WRITER );	
</#list>	
		}};
</#if>
</#macro>
	
<#-- *********************************************************************************************** -->
<#-- generates memberReaders code                                                                    -->
<#-- *********************************************************************************************** -->
<#macro memberReaders items className classPackage serializerPrefix>
<#assign javaPackage = getJavaPackage() >
<#if classPackage != "" >
	<#assign ctype = classPackage + "." +className >
<#else>
	<#assign ctype = className  >
</#if>
	/**
	 * member readers mapping
	 */
	@SuppressWarnings("serial")
	private static final java.util.Map<java.lang.String, ${javaPackage}.u.Lib.MemberReader<${ctype}>> MEMBER_READER = 
		new java.util.HashMap<java.lang.String, ${javaPackage}.u.Lib.MemberReader<${ctype}>>() {{
<#list items as item >
	<#assign type = item.getTypeName()>
	<#assign jtype = javaTypeNoArray( item ) >
	<#assign name = item.getName() >
	<#assign Aname = item.getName()?cap_first >
	<#assign elementValue = "object.set" + Aname >
			put( "${name}", new ${javaPackage}.u.Lib.MemberReader<${ctype}>() {
				public void read( com.fasterxml.jackson.core.JsonParser jp, ${ctype} object ) 
					throws java.io.IOException {
	<#if item.isArray() >
					${elementValue}( ${serializerPrefix}${type}Serializer.readValueArray( jp, "${name}", "${className}" ) );
	<#elseif item.isMap() >	
					${elementValue}( ${serializerPrefix}${type}Serializer.readValueMap( jp, "${name}", "${className}" ) );	
	<#else>
					${elementValue}( ${serializerPrefix}${type}Serializer.readValue( jp, "${name}", "${className}" ) );
	</#if>
				}
			});
</#list>
		}};
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates writeMembersFunction code                                                                    -->
<#-- *********************************************************************************************** -->
<#macro writeMembersFunction items className baseClassName classPackage serializerPrefix >
<#assign javaPackage = getJavaPackage() >
	/**
	 * write the ${className} object to json
	 */
	protected static void write(
		com.fasterxml.jackson.core.JsonGenerator jg,
		${classPackage}.${className} object
	) throws java.io.IOException {
		jg.writeStartObject();
<#if baseClassName != '' >		
		jg.writeFieldName("__type");
		jg.writeString("${className}");
</#if>		
		
		<@my.writeMembers items=items className=className serializerPrefix=serializerPrefix />
		
		jg.writeEndObject();
	}
</#macro>
<#-- *********************************************************************************************** -->
<#-- generates readValueFunction code                                                                -->
<#-- *********************************************************************************************** -->
<#macro readValueFunction className classPackage >
<#assign javaPackage = getJavaPackage() >
	/**
	 * read the ${className} value
	 */
	public static ${classPackage}.${className} readValue( 
		com.fasterxml.jackson.core.JsonParser jp,
		java.lang.String name,
		java.lang.String src
	) throws java.io.IOException {
		return jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL? null : readDynamic( jp );
	}

	/**
	 * read the ${className} array value
	 */
	public static java.util.List<${classPackage}.${className}> readValueArray( 
		com.fasterxml.jackson.core.JsonParser jp,
		java.lang.String name,
		java.lang.String src
	) throws java.io.IOException {
		if( jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL ) {
			return null;
		}
		
		if( !jp.isExpectedStartArrayToken() ) {
			throw new com.fasterxml.jackson.core.JsonParseException( jp,
				java.lang.String.format( "expected array for '%s.%s'", src, name )
			);
		}
		
		java.util.List<${classPackage}.${className}> list = new java.util.ArrayList<${classPackage}.${className}>();
		while (jp.nextToken() != com.fasterxml.jackson.core.JsonToken.END_ARRAY) {
			if( jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL ) {
				throw new com.fasterxml.jackson.core.JsonParseException( jp,
					java.lang.String.format( "array '%s.%s' has null value", src, name )
				);
			}
			list.add( jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL? null : readDynamic( jp ) );
		}
		
		return list;
	}

	/**
	 * read the ${className} map value
	 */
	public static java.util.Map<java.lang.String, ${classPackage}.${className}> readValueMap( 
		com.fasterxml.jackson.core.JsonParser jp,
		java.lang.String name,
		java.lang.String src
	) throws java.io.IOException {	
		if( jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL ) {
			return null;
		}

		if( !jp.isExpectedStartObjectToken() ) {
			throw new com.fasterxml.jackson.core.JsonParseException( jp,
				java.lang.String.format( "expected object for '%s.%s'", src, name )
			);
		}
		
		java.util.Map<java.lang.String, ${classPackage}.${className}> map = new java.util.HashMap<java.lang.String, ${classPackage}.${className}>();
				
		while (jp.nextToken() == com.fasterxml.jackson.core.JsonToken.FIELD_NAME) {
			java.lang.String fieldName = jp.getCurrentName();
			jp.nextToken();
			if( jp.getCurrentToken() != com.fasterxml.jackson.core.JsonToken.VALUE_NULL ) {
				map.put( fieldName, readDynamic( jp ) );
			}
		}
		
		return map;
	}
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates writeValueFunction code                                                                    -->
<#-- *********************************************************************************************** -->
<#macro writeValueFunction className classPackage >
<#assign javaPackage = getJavaPackage() >
	/**
	 * write the ${className} value
	 */
	public static void writeValue( 
		com.fasterxml.jackson.core.JsonGenerator jg,
		java.lang.String name,
		${classPackage}.${className} value,
		java.lang.String src
	) throws java.io.IOException {
		if( value != null ) {
			jg.writeFieldName( name );
			writeDynamic( jg, value );
		}
	}

	/**
	 * write the ${className} array value
	 */
	public static void writeValue( 
		com.fasterxml.jackson.core.JsonGenerator jg,
		java.lang.String name,
		java.util.List<${classPackage}.${className}> array,
		java.lang.String src
	) throws java.io.IOException {
		if( array != null ) {
			jg.writeFieldName( name );
			jg.writeStartArray();
			for( ${classPackage}.${className} element : array ) {
				if( element == null ) {
					throw new IllegalArgumentException( String.format( "array '%s.%s' has null element", src, name ) );
				}
				writeDynamic( jg, element );
			}
			jg.writeEndArray();
		}
	}

	/**
	 * write the ${className} map value
	 */
	public static void writeValue( 
		com.fasterxml.jackson.core.JsonGenerator jg,
		java.lang.String name,
		java.util.Map<java.lang.String, ${classPackage}.${className}> map,
		java.lang.String src
	) throws java.io.IOException {
		if( map != null ) {
			jg.writeFieldName( name );
			jg.writeStartObject();
			for( java.util.Map.Entry<java.lang.String, ${classPackage}.${className}> element : map.entrySet() ) {
				if( element.getKey() == null ) {
					throw new IllegalArgumentException( String.format( "map element '%s.%s' has null key", src, name ) );
				}
				if( element.getValue() == null ) {
					throw new IllegalArgumentException( String.format( "map element '%s.%s.%s' has null value", src, name, element.getKey() ) );
				}
				jg.writeFieldName( element.getKey() );
				writeDynamic( jg, element.getValue() );
			}
			jg.writeEndObject();
		}
	}
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates readMemberFunction code                                                               -->
<#-- *********************************************************************************************** -->
<#macro readMemberFunction items className classPackage>
<#assign javaPackage = getJavaPackage() >
<#if classPackage != "" >
	<#assign type = classPackage + "." +className >
<#else>
	<#assign type = className  >
</#if>
	/**
	 * read ${className} from json
	 */
	protected static ${type} read(
		com.fasterxml.jackson.core.JsonParser jp
	) throws java.io.IOException {
		${type} result = new ${type}();
		${javaPackage}.u.Lib.readType( jp, result, MEMBER_READER );		
		return result;
	}
</#macro>

<#-- *********************************************************************************************** -->
<#-- readDynamicMembersFunction                                                                      -->
<#-- *********************************************************************************************** -->
<#macro readDynamicMembersFunction className children >
<#assign javaPackage = getJavaPackage() >
	/**
	 * dynamic read ${className} from json
	 */
	public static ${javaPackage}.${className} readDynamic(
		com.fasterxml.jackson.core.JsonParser jp
	) throws java.io.IOException {
<#if children?size !=0 >		
		return ${javaPackage}.u.Lib.readDynamicType( jp, READER_MAPPING, READER, "${className}" );
<#else>
		if( jp.getCurrentToken() == null) {
			jp.nextToken();
		}
		if( jp.getCurrentToken() != com.fasterxml.jackson.core.JsonToken.START_OBJECT ) {
			throw new com.fasterxml.jackson.core.JsonParseException( jp,
				"expected  object of type '${className}'" );
		}
		return read( jp );
</#if>
	}
	
	/**
	 * ${className} READER
	 */
	public static final ${javaPackage}.u.Lib.JsonReader<${javaPackage}.${className}> READER = new ${javaPackage}.u.Lib.JsonReader<${javaPackage}.${className}>() {
		public ${javaPackage}.${className} read( com.fasterxml.jackson.core.JsonParser jp ) throws java.io.IOException {
			return ${javaPackage}.json.${className}Serializer.read( jp );
		}
	};
<#if children?size !=0 >

	@SuppressWarnings("serial")
	private static final java.util.Map<java.lang.String, ${javaPackage}.u.Lib.JsonReader<? extends ${javaPackage}.${className}>> READER_MAPPING = 
		new java.util.HashMap<java.lang.String, ${javaPackage}.u.Lib.JsonReader<? extends ${javaPackage}.${className}>>() {{
			put( "${className}", READER );
	<#list children as childTypeName >
			put( "${childTypeName}", ${javaPackage}.json.${childTypeName}Serializer.READER );
	</#list>				
		}};
</#if>
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates throws exceptions                                                           -->
<#-- *********************************************************************************************** -->
<#macro throwsExceptions items end=";">
<#assign javaPackage = getJavaPackage() >
<#if items?size != 0 >throws
<#list items as item >
		${javaPackage}.${item}<#if item_has_next>, <#else>${end}</#if>
</#list>
<#else>
 ${end}
</#if>
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates implements interfaces exceptions                                                      -->
<#-- *********************************************************************************************** -->
<#macro extendsInterfaces items >
<#assign javaPackage = getJavaPackage() + ".intrf" >
<#if items?size != 0 >extends
<#list items as item >
		${javaPackage}.${item}<#if item_has_next>, </#if>
</#list>
</#if>						
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates validation condition                                                                  -->
<#-- *********************************************************************************************** -->
<#macro validationCondition cond prefix field>
<#if cond.getType().name() == "NOT_NULL" >
		ValidationException.notNull( ${prefix}, ".${cond.getName()}", ${field} );
</#if>
<#if cond.getType().name() == "NOT_EMPTY" >
		ValidationException.notEmpty( ${prefix}, ".${cond.getName()}", ${field} );
</#if>
<#if cond.getType().name() == "BIGGER_OR_EQ" >
		ValidationException.notSmaller( ${prefix}, ".${cond.getName()}",  ${field}, ${cond.getValue()} );
</#if>
<#if cond.getType().name() == "SMALLER_OR_EQ" >
		ValidationException.notBigger( ${prefix}, ".${cond.getName()}",  ${field}, ${cond.getValue()} );
</#if>				
</#macro>