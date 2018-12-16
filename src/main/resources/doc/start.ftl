Start generate ...

<#list amit.generate( "service","service.ftl", "doc/p/%s.html" ) as processed>
done: ${processed}
</#list>

<#list amit.generate( "service","index.ftl", "doc/index.html" ) as processed>
done: ${processed}
</#list>

End generate.
