<cfcomponent output="false">

<cfset THIS.dsn="jobs">

   <!--- ( used with CFC bind ajax calls )  Lookup used for auto suggest --->
   <cffunction name="getEmployers" access="remote" returntype="array">
	<cfargument name="search" type="any" required="false" default="">
	
	<!--- Define variables --->
	<cfset var data="">
	<cfset var result=ArrayNew(1)>
	
	<!--- Do search --->
	<cfquery datasource="#THIS.dsn#" name="data">
	SELECT employer
	FROM employerlist
	WHERE employer LIKE '#ARGUMENTS.search#%'
	ORDER BY employer
	</cfquery>
	
	<!--- Build result array --->
	<cfloop query="data">
		<cfset ArrayAppend(result, employer)>
	</cfloop>
	
		  <!--- And return it --->
	<cfreturn result>
   </cffunction>
   
   

   <cffunction name="getEmployersAsQry" access="public" returntype="query">
	<cfquery datasource="#THIS.dsn#" name="data">
	SELECT employer
	FROM employerlist
	ORDER BY employer
	</cfquery>
	<cfreturn data>
   </cffunction>
   
   <cffunction name="getCitiesAsQry" access="public" returntype="query">
		<cfquery datasource="#THIS.dsn#" name="data">
		SELECT city
		FROM citylist
		ORDER BY city
		</cfquery>
	<cfreturn data>
   </cffunction>
   
</cfcomponent>
