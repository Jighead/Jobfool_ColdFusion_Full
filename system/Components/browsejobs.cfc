<cfcomponent>
	<cffunction name="getCitiesByCountry" access="public" returntype="query">
		<cfargument name="country" type="string" required="yes" default="US">
        <cfargument name="state" type="string" required="yes" default="CA">
        
        <cfif arguments.country eq 'US'>
            <cfquery name="getCities" datasource="jobs" username="#request.dbuser#" password="#request.dbpass#"	cachedwithin="#createTimeSpan(0,0,1,0)#">
            select distinct city , state, stateabrev
            from citystatecountry where country = '#arguments.country#'	and stateabrev = '#arguments.state#' order by city
            </cfquery>
            
        <cfelse>
            <cfquery name="getCities" datasource="jobs" username="#request.dbuser#" password="#request.dbpass#"	cachedwithin="#createTimeSpan(0,0,1,0)#">
            SELECT DISTINCT city, state, stateabrev
            FROM    CityStateCountry
            WHERE  (state = '#arguments.country#') ORDER BY city
            </cfquery>
         </cfif>   
         
		<cfreturn getCities>
	</cffunction>
</cfcomponent>