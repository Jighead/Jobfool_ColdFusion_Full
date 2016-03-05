<cfcomponent>
    <cffunction name="addUser" access="public" output="no" returntype="boolean" hint="I add User">
        <cfargument name="cfid"  type="string" required="yes">
        <cfargument name="email" type="string" required="yes">
        <cfargument name="firstname" type="string" required="no">
        <cfargument name="lastname" type="string" required="no">
        <cfargument name="password" type="string" required="no">
           
        <cfquery name="ins" datasource="#variables.dsn#">
            <cfquery name="dupcheck" datasource="#request.dsn#">
            insert into USERS
            (cfid, email, createdate)
            values 
            ('#arguments.CFID#', '#arguments.email#', #createODBCDateTime(now())#)
            </cfquery>
        </cfquery>
        
    <cfreturn true>
    </cffunction>
    
    <cffunction name="checkEmail" access="public" output="no" returntype="boolean" hint="I check for duplicate user email address">
        <cfargument name="cfid"  type="string" required="yes">
        <cfargument name="email" type="string" required="yes">
        
        
        <cfquery name="dupcheck" datasource="#request.dsn#">
        select email from users 
        where email address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">
        </cfquery>
        
        <cfif dupcheck.recordcount gt 0>
			<cfreturn false>
        <cfelse>
        	<cfreturn true>
        </cfif>
     </cffunction>    
    
</cfcomponent>
