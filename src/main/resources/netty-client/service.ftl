<#import "macros.ftl" as my>
<#assign modelJavaPackage = my.getJavaPackage() >
<#assign intrfJavaPackage = modelJavaPackage + ".intrf" >
<#assign callJavaPackage = modelJavaPackage + ".json.call" >
<#assign thisJavaPackage = modelJavaPackage + ".client" >
<#assign objectName = object.getName() >
<#assign className = objectName + "Client" >
<#assign callName = "Call" + objectName >
/**
 * This file is generated by the Amit
 * don't modify it manually
 */
package ${thisJavaPackage};

import com.amitapi.netty.client.NettyHttpClient;
import com.amitapi.netty.client.NettyHttpClientConfig;
import com.amitapi.netty.client.NettyHttpClientHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.FullHttpResponse;
import io.netty.handler.codec.http.HttpResponseStatus;
import io.netty.util.CharsetUtil;

import java.util.concurrent.CompletableFuture;
import java.io.IOException;

import ${modelJavaPackage}.exception.InternalException;

/**
 * Service ${objectName} Client
 */
public class ${className} extends NettyHttpClient {
	public ${className}(NettyHttpClientConfig config) {
		super(config);
	}
	
<#list object.getBaseInterfaceNames() as interfaceName >
	
	<#assign interfaceObj = project.getInterface( interfaceName ) >
	<#list interfaceObj.getFunctions() as function >
		<#assign fname = function.getName() >
		<#assign rtype = function.getReturn().getTypeName() >
		<#assign jrtype = my.javaType( function.getReturn() ) >
		<#assign ARfname = fname?cap_first + "Request"  >
		<#assign APfname = fname?cap_first + "Response"  >
	/**
	 * ${fname}
	 */
	public ${jrtype} ${fname}(
		<#list function.getArguments() as arg >
			<#assign aname = arg.getName() >
			<#assign atype = my.javaType( arg ) >
			${atype} ${aname}<#if arg_has_next>,</#if>
		</#list>
	) throws <@my.throwsExceptions items=function.getThrowsExceptionNames() />
	{
	<#if jrtype != "void" >
		return null;
	</#if>	
	}	
	<#if jrtype == "void" >
		<#assign jrtype = "java.lang.Void" >
	</#if>
	
	/**
	 * ${fname} async
	 */
	public CompletableFuture<${jrtype}> ${fname}Async(
		<#list function.getArguments() as arg >
			<#assign aname = arg.getName() >
			<#assign atype = my.javaType( arg ) >
			${atype} ${aname}<#if arg_has_next>,</#if>
		</#list>
	) 
	{
		CompletableFuture<${jrtype}> result = new CompletableFuture<${jrtype}>();
		${callJavaPackage}.${callName}.${ARfname} request = new ${callJavaPackage}.${callName}.${ARfname}();
		<#list function.getArguments() as arg >
			<#assign aname = arg.getName() >
		request.set${aname?cap_first}(${aname});
		</#list>
		try {
			postJson("/api/${objectName?lower_case}/${fname?lower_case}", request.toJsonString(), 
				new NettyHttpClientHandler() {
					@Override
					protected void channelRead0(ChannelHandlerContext ctx,
						FullHttpResponse msg) throws Exception {
						try {
							${callJavaPackage}.${callName}.${APfname} response = 
								${callJavaPackage}.${callName}.${APfname}.parseJson(msg.content().toString(CharsetUtil.UTF_8));
							response.throwException();
							if(msg.status() != HttpResponseStatus.OK) {
								throw new InternalException().withReason("unknown error");
							}
						<#if jrtype == "java.lang.Void" >
							result.complete(null);
						<#else>
							result.complete(response.getReturnValue());
						</#if>
						} catch (Exception e) {
							exceptionCaught(ctx, e);
						}
					}
				
					@Override
					public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
						result.completeExceptionally(cause);
						ctx.close();
					}
			});
		} catch (InterruptedException | IOException e) {
			result.completeExceptionally(e);
		} 
		
		return result;
	}
		</#list>
</#list>
}
