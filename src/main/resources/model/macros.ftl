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
<#-- *********************************************************************************************** -->
<#function saveMember member arg>
	<#assign javaPackage = getJavaPackage() >
	<#assign value = "unknown" >
	<#switch member.getTypeName()>
		<#case "boolean">
			<#assign value = "jg.writeBoolean( " + arg + " );" >
		<#break>
		<#case "int">
			<#assign value = "jg.writeNumber( " + arg + " );" >
		<#break>
		<#case "string">
			<#assign value = "jg.writeString( " + arg + " );" >
		<#break>
		<#case "long">
			<#assign value = "jg.writeNumber( " + arg + " );" >
		<#break>
		<#case "double">
			<#assign value = "jg.writeNumber( " + arg + " );" >
		<#break>
		<#case "uuid">
			<#assign value = "jg.writeString( " + arg + ".toString() );" >
		<#break>
		<#case "datetime">
			<#assign value = "jg.writeString( " + arg + ".toString() );" >
		<#break>
		<#default>
			<#assign value = javaPackage + ".json." + member.getTypeName() + "Serializer.writeDynamic( jg, " + arg + " );" >
	</#switch>

	<#return value >
</#function>
<#-- *********************************************************************************************** -->
<#-- *********************************************************************************************** -->
<#function readMember member>
	<#assign javaPackage = getJavaPackage() >
	<#assign value = "unknown" >
	<#switch member.getTypeName()>
		<#case "boolean">
			<#assign value = "jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL? null : jp.getBooleanValue()" >
		<#break>
		<#case "int">
			<#assign value = "jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL? null : jp.getIntValue()" >
		<#break>
		<#case "string">
			<#assign value = "jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL? null : jp.getText()" >
		<#break>
		<#case "long">
			<#assign value = "jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL? null : jp.getLongValue()" >
		<#break>
		<#case "double">
			<#assign value = "jp.getCurrentToken() == com.fasterxml.jackson.core.JsonToken.VALUE_NULL? null : jp.getDoubleValue()" >
		<#break>
		<#case "uuid">
			<#assign value = javaPackage + ".u.Lib.parseUUID(jp)" >
		<#break>
		<#case "datetime">
			<#assign value = javaPackage + ".u.Lib.parseDate(jp)" >
		<#break>
		<#default>
			<#assign value = javaPackage + ".json." + member.getTypeName() + "Serializer.readDynamic( jp )" >
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
		java.lang.StringBuffer sb = new java.lang.StringBuffer();
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
<#macro writeMembers items className>
<#assign javaPackage = getJavaPackage() >
<#list items as item >
	<#assign type = item.getTypeName()>
	<#assign jtype = javaTypeNoArray( item ) >
	<#assign name = item.getName() >
	<#assign Aname = item.getName()?cap_first >
	<#assign elementValue = "object.get" + Aname + "()" >
		
		// save ${name}
		if( ${elementValue} != null ) {
			jg.writeFieldName("${name}");
	<#if item.isArray() >
		<#assign saveFun = saveMember(item, "element" ) >
			jg.writeStartArray();
			for( ${jtype} element : ${elementValue} ) {
				if( element == null ) {
					throw new java.lang.IllegalArgumentException(
						"array '${name}' from '${javaPackage}.${className}' has null element"
					);
				}
				${saveFun}
			}
			jg.writeEndArray();
	<#elseif item.isMap() >
		<#assign saveFun = saveMember(item, "element.getValue()" ) >
			jg.writeStartObject();
			for( java.util.Map.Entry<java.lang.String, ${jtype}> element : ${elementValue}.entrySet() ) {
				if(element.getKey() == null) {
					throw new java.lang.IllegalArgumentException(
						"name '${name}' from '${javaPackage}.${className}' has element with null key"
					);					
				}
				if(element.getValue() != null) {
					jg.writeFieldName( element.getKey() );
					${saveFun}
				}
			}
			jg.writeEndObject();
	<#else>
			${saveMember(item, elementValue)}
	</#if>
		}
</#list>
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates class serialization map -->
<#-- *********************************************************************************************** -->
<#macro writeDynamicMembersFunction className children >
<#assign javaPackage = getJavaPackage() >
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
	
<#if children?size !=0 >
	@SuppressWarnings("serial")
	private static final java.util.Map<java.lang.Class<?>, ${javaPackage}.u.Lib.JsonWriter> WRITER_MAPPING = 
		new java.util.HashMap<java.lang.Class<?>, ${javaPackage}.u.Lib.JsonWriter>() {{
			put( ${javaPackage}.${className}.class, new ${javaPackage}.u.Lib.JsonWriter() {
				public void write( com.fasterxml.jackson.core.JsonGenerator jg, java.lang.Object object ) 
					throws java.io.IOException {
					${javaPackage}.json.${className}Serializer.
					write( jg, (${javaPackage}.${className})object );
				}
			});
<#list children as childTypeName >
			put( ${javaPackage}.${childTypeName}.class, new ${javaPackage}.u.Lib.JsonWriter() {
				public void write( com.fasterxml.jackson.core.JsonGenerator jg, java.lang.Object object ) 
					throws java.io.IOException {
					${javaPackage}.json.${childTypeName}Serializer.
					write( jg, (${javaPackage}.${childTypeName})object );
				}
			});	
</#list>	
		}};
</#if>
</#macro>
	
<#-- *********************************************************************************************** -->
<#-- generates memberReaders code                                                                    -->
<#-- *********************************************************************************************** -->
<#macro memberReaders items className>
<#assign javaPackage = getJavaPackage() >
	@SuppressWarnings("serial")
	private static final java.util.Map<java.lang.String, ${javaPackage}.u.Lib.MemberReader<${javaPackage}.${className}>> MEMBER_READER = 
		new java.util.HashMap<java.lang.String, ${javaPackage}.u.Lib.MemberReader<${javaPackage}.${className}>>() {{
<#list items as item >
	<#assign type = item.getTypeName()>
	<#assign jtype = javaTypeNoArray( item ) >
	<#assign name = item.getName() >
	<#assign Aname = item.getName()?cap_first >
	<#assign elementValue = "object.set" + Aname >
			put( "${name}", new ${javaPackage}.u.Lib.MemberReader<${javaPackage}.${className}>() {
				public void read( com.fasterxml.jackson.core.JsonParser jp, ${javaPackage}.${className} object ) 
					throws java.io.IOException {
	<#if item.isArray() >
					if( !jp.isExpectedStartArrayToken() ) {
						throw new com.fasterxml.jackson.core.JsonParseException( jp,
							"expected array for '${className}.${name}'"
						);
					}
					
					java.util.List<${jtype}> list = new java.util.ArrayList<${jtype}>();
					while (jp.nextToken() != com.fasterxml.jackson.core.JsonToken.END_ARRAY) {
						list.add( ${readMember(item)} );
					}
						
					${elementValue}( list );
	<#elseif item.isMap() >	
					if( !jp.isExpectedStartObjectToken() ) {
						throw new com.fasterxml.jackson.core.JsonParseException( jp,
							"expected object for '${className}.${name}'"
						);
					}
					
					java.util.Map<java.lang.String, ${jtype}> map = 
							new java.util.HashMap<java.lang.String, ${jtype}>();
							
					while (jp.nextToken() == com.fasterxml.jackson.core.JsonToken.FIELD_NAME) {
						java.lang.String fieldName = jp.getCurrentName();
						jp.nextToken();
						map.put( fieldName, ${readMember(item)} );
					}
					${elementValue}( map );
	<#else>
					${elementValue}(${readMember(item)});
	</#if>
				}
			});
</#list>
		}};
</#macro>

<#-- *********************************************************************************************** -->
<#-- generates writeMembersFunction code                                                                    -->
<#-- *********************************************************************************************** -->
<#macro writeMembersFunction items className baseClassName>
<#assign javaPackage = getJavaPackage() >
	public static void write(
		com.fasterxml.jackson.core.JsonGenerator jg,
		${javaPackage}.${className} object
	) throws java.io.IOException {
		jg.writeStartObject();
<#if baseClassName != '' >		
		jg.writeFieldName("__type");
		jg.writeString("${className}");
</#if>		
		<@my.writeMembers items=items className=className />
		
		jg.writeEndObject();
	}
</#macro>


<#-- *********************************************************************************************** -->
<#-- generates readMemberFunction code                                                               -->
<#-- *********************************************************************************************** -->
<#macro readMemberFunction items className>
<#assign javaPackage = getJavaPackage() >
	public static ${javaPackage}.${className} read(
		com.fasterxml.jackson.core.JsonParser jp
	) throws java.io.IOException {
		${javaPackage}.${className} result 
			= new ${javaPackage}.${className}();
					
		while( jp.nextToken() == com.fasterxml.jackson.core.JsonToken.FIELD_NAME ) {
			java.lang.String fieldName = jp.getCurrentName();
			${javaPackage}.u.Lib.MemberReader<${javaPackage}.${className}> reader 
				= MEMBER_READER.get(fieldName);
			
			jp.nextToken();
			if( reader == null ) {
				jp.skipChildren(); 
			} else {
				reader.read( jp, result );
			}
		}
		
		return result;
	}
</#macro>

<#-- *********************************************************************************************** -->
<#-- readDynamicMembersFunction                                                                      -->
<#-- *********************************************************************************************** -->
<#macro readDynamicMembersFunction className children >
<#assign javaPackage = getJavaPackage() >
	public static ${javaPackage}.${className} readDynamic(
		com.fasterxml.jackson.core.JsonParser jp
	) throws java.io.IOException {
		if( jp.getCurrentToken() != com.fasterxml.jackson.core.JsonToken.START_OBJECT ) {
			if( jp.nextToken() != com.fasterxml.jackson.core.JsonToken.START_OBJECT ) {
				throw new com.fasterxml.jackson.core.JsonParseException( jp,
					"expected  object of type '${className}'" );
			}
		}
<#if children?size !=0 >		
		com.fasterxml.jackson.databind.util.TokenBuffer tb = null;
		try {
			while( jp.nextToken() == com.fasterxml.jackson.core.JsonToken.FIELD_NAME ) {
				String name = jp.getCurrentName();
				jp.nextToken(); 
				if( name.equals( "__type" ) ) {
					String typeName = jp.getText(); 
					${javaPackage}.u.Lib.JsonReader<${javaPackage}.${className}> reader = 
						READER_MAPPING.get( typeName );
					
					if( reader == null ) {
						throw new com.fasterxml.jackson.core.JsonParseException( jp,
								"expected  object of type '${className}'" );					
					}
					
					if( tb != null ) { 
			            jp = com.fasterxml.jackson.core.util.JsonParserSequence.
			            		createFlattened( tb.asParser(jp), jp );
			        }
					
					return reader.read( jp );
				}
				if (tb == null) {
					tb = new com.fasterxml.jackson.databind.util.TokenBuffer(jp);
				}
				tb.writeFieldName(name);
				tb.copyCurrentStructure(jp);
			}
			
			return read( tb.asParser(jp) );
		} finally {
			if( tb != null ) {
				tb.close();
			}
		}
<#else>
		return read( jp );
</#if>
	}
	
<#if children?size !=0 >
	@SuppressWarnings("serial")
	private static final java.util.Map<java.lang.String, ${javaPackage}.u.Lib.JsonReader<${javaPackage}.${className}>> READER_MAPPING = 
		new java.util.HashMap<java.lang.String, ${javaPackage}.u.Lib.JsonReader<${javaPackage}.${className}>>() {{
			put( "${className}", new ${javaPackage}.u.Lib.JsonReader<${javaPackage}.${className}>() {
				public ${javaPackage}.${className} read( com.fasterxml.jackson.core.JsonParser jp ) 
					throws java.io.IOException {
					return ${javaPackage}.json.${className}Serializer.read( jp );
				}
			});
	<#list children as childTypeName >
				put( "${childTypeName}", new ${javaPackage}.u.Lib.JsonReader<${javaPackage}.${className}>() {
					public ${javaPackage}.${className} read( com.fasterxml.jackson.core.JsonParser jp ) 
						throws java.io.IOException {
						return ${javaPackage}.json.${childTypeName}Serializer.read( jp );
					}
				});	
	</#list>				
		}};
</#if>
</#macro>