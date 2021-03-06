<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign thisJavaPackage = modelJavaPackage + ".json" >
/**
 * This file is generated by the Amit
 * don't modify it manually
 */
package ${thisJavaPackage};

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.core.JsonParseException;

public class longSerializer {
	/**
	 * write map value
	 */
	public static void writeValue( JsonGenerator jg, String name, Map<String, Long> map, String src ) throws IOException {
		if( map != null ) {
			jg.writeFieldName( name );
			jg.writeStartObject();
			for( Map.Entry<String, Long> element : map.entrySet() ) {
				if( element.getKey() == null ) {
					throw new IllegalArgumentException( String.format( "map element '%s.%s' has null key", src, name ) );
				}
				if( element.getValue() == null ) {
					throw new IllegalArgumentException( String.format( "map element '%s.%s.%s' has null value", src, name, element.getKey() ) );
				}
				jg.writeFieldName( element.getKey() );
				jg.writeNumber( element.getValue() );
			}
			jg.writeEndObject();
		}
	}
	
	/**
	 * write array value
	 */
	public static void writeValue( JsonGenerator jg, String name, List<Long> array, String src ) throws IOException {
		if( array != null ) {
			jg.writeFieldName( name );
			jg.writeStartArray();
			for( Long element : array ) {
				if( element == null ) {
					throw new IllegalArgumentException( String.format( "array '%s.%s' has null element", src, name ) );
				}
				jg.writeNumber( element );
			}
			jg.writeEndArray();
		}
	}
	
	/**
	 * write value
	 */
	public static void writeValue( JsonGenerator jg, String name, Long value, String src ) throws IOException {
		if( value != null ) {
			jg.writeFieldName( name );
			jg.writeNumber( value );
		}
	}
	
	/**
	 * read Long value
	 */
	public static Long readValue( JsonParser jp, String name, String src ) throws IOException {
		return jp.getCurrentToken() == JsonToken.VALUE_NULL? null : jp.getLongValue();
	}
	
	/**
	 * read Long value array
	 */
	public static List<Long> readValueArray( JsonParser jp, String name, String src ) throws IOException {
		if( jp.getCurrentToken() == JsonToken.VALUE_NULL ) {
			return null;
		}
		
		if( !jp.isExpectedStartArrayToken() ) {
			throw new JsonParseException( jp,
				String.format( "expected array for '%s.%s'", src, name )
			);
		}
		
		List<Long> list = new ArrayList<Long>();
		while (jp.nextToken() != JsonToken.END_ARRAY) {
			if( jp.getCurrentToken() == JsonToken.VALUE_NULL ) {
				throw new JsonParseException( jp,
					String.format( "array '%s.%s' has null value", src, name )
				);
			}
			list.add( jp.getLongValue() );
		}
		
		return list;
	}

	/**
	 * read Long value map
	 */
	public static Map<String, Long> readValueMap( JsonParser jp, String name, String src) throws IOException {
		if( jp.getCurrentToken() == JsonToken.VALUE_NULL ) {
			return null;
		}

		if( !jp.isExpectedStartObjectToken() ) {
			throw new JsonParseException( jp,
				String.format( "expected object for '%s.%s'", src, name )
			);
		}
		
		Map<String, Long> map = 
				new HashMap<String, Long>();
				
		while (jp.nextToken() == JsonToken.FIELD_NAME) {
			String fieldName = jp.getCurrentName();
			jp.nextToken();
			if( jp.getCurrentToken() != JsonToken.VALUE_NULL ) {
				map.put( fieldName, jp.getLongValue() );
			}
		}
		
		return map;
	}
}
