Start generate ...

<#list amit.generate( "service","service.ftl", "doc/%s.html" ) as processed>
done: ${processed}
</#list>

End generate.
