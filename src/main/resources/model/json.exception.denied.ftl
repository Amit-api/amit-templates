<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign thisJavaPackage = modelJavaPackage + ".json.exception" >
/**
 * This file is generated by the Amit
 * don't modify it manually
 */
package ${thisJavaPackage};

import ${modelJavaPackage}.exception.AccessDeniedException;
import ${modelJavaPackage}.u.Lib.JsonReader;
import ${modelJavaPackage}.u.Lib.JsonWriter;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.core.JsonGenerator;

public class AccessDeniedExceptionSerializer {
	public static final String className = "exception.denied";
	
	/**
	 * the reader
	 */
	public static final JsonReader<AccessDeniedException> READER = new JsonReader<AccessDeniedException>() {
		public AccessDeniedException read( JsonParser jp ) throws IOException {
			AccessDeniedException result = new AccessDeniedException();
			
			while( jp.nextToken() == JsonToken.FIELD_NAME ) {
				String fieldName = jp.getCurrentName();
				jp.nextToken();
				if( "reason".equals( fieldName ) ) {
					result.setReason( jp.getText() );
				} else {
					jp.skipChildren(); 					
				}
			}
			
			return result;
		}
	};
	
	/**
	 * the writer
	 */
	public static final JsonWriter WRITER = new JsonWriter() {
		public void write( JsonGenerator jg, Object object ) throws IOException {
			AccessDeniedException cobj = (AccessDeniedException) object;
			jg.writeStartObject();
			jg.writeFieldName( "__type" );
			jg.writeString( className );
			
			if( cobj.getReason() != null ) {
				jg.writeFieldName( "reason" );
				jg.writeString( cobj.getReason() );
			}
			
			jg.writeEndObject();
		}
	};
}