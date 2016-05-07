<cfcomponent>
    
    <cffunction name="getTitles" access="public" returntype="query">  
        
    	<cfquery name="getTitles" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
        select jobtitle, id
        from jobtitles
        where jobtitle like <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim('#url.tl#%')#" />
        order by jobtitle
        </cfquery>	

		<cfreturn getTitles>
	</cffunction>
    
    <cffunction name="getCategories" access="public" returntype="query">        
        <cfquery name="categories"  datasource="#request.dsn#">
            select category from categories order by category asc
        </cfquery>

		<cfreturn categories>
	</cffunction>
    
    
    <cffunction name="getStates" access="public" returntype="query">        

        <cfquery name="states"  datasource="#request.dsn#">
            SELECT     state
            FROM       states
            WHERE     (statecode IS NOT NULL)
            ORDER BY state
        </cfquery>
        
		<cfreturn states>
	</cffunction>
        
        
	<cffunction name="getCitiesByCountry" access="public" returntype="query">
		<cfargument name="country" type="string" required="yes" default="US">
        <cfargument name="state" type="string" required="yes" default="CA">
        
        <cfif arguments.country eq 'US'>
            <cfquery name="getCities" datasource="jobs" username="#request.dbuser#" password="#request.dbpass#"	cachedwithin="#createTimeSpan(0,0,1,0)#">
            select distinct city , state, stateabrev
            from citystatecountry where country = '#arguments.country#'	and state = '#arguments.state#' order by city
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