<cfcomponent>

	<cffunction name="getEmployerByLetter" access="public" returntype="query" hint="I get employers by first letter">
		<cfargument name="letter" type="string" required="yes">
        <cfargument name="cache" type="boolean" required="yes" default="true">
        
		<cfif arguments.cache>
        	<cfset var cachetime = "#createtimespan(0,1,0,0)#">
        <cfelse>
        	<cfset var cachetime = "#createtimespan(0,0,0,0)#">
        </cfif>
        
        <cfquery name="qryEmp" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#"  cachedwithin="#cachetime#">
		select employer
		from employerlist
		where employer like <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.letter#%">
		order by employer
        
		</cfquery>
        
		<cfreturn qryEmp>
	</cffunction>

</cfcomponent>