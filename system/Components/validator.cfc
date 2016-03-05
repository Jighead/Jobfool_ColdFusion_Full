<cfcomponent>
	<cffunction name="validate" access="public" returntype="boolean">
		<cfargument name="type" type="string" required="yes">
        
        <cfswitch expression="#arguments.type#">
        <cfcase value="email">
        
        <cfscript>
		return (REFindNoCase("^['_a-zA-Z0-9-\+~]+(\.['_a-zA-Z0-9-\+~]+)*@([a-zA-Z_0-9-]+\.)+(([a-zA-Z]{2})|(aero|asia|biz|cat|co|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel))$",
		arguments.email) AND len(listGetAt(arguments.str, 1, "@")) LTE 64 AND
		len(listGetAt(arguments.str, 2, "@")) LTE 255) IS 1;
		</cfscript>
        </cfcase>
        
        </cfswitch>
	</cffunction>
</cfcomponent>