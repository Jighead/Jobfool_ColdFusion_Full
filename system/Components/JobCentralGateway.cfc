<cfcomponent>
<cffunction name="getDirectJobs" output="no" access="public" returntype="query" hint="I get jobs by employer">
	<cfargument name="title" required="no" default="">
	<cfargument name="employer" required="no" default="">
	<cfargument name="location" required="no" default="">
	<cfargument name="dateposted" required="no" default="">
	<cfargument name="datecollected" required="no" default="">
	<cfargument name="dsn" required="yes" default="jobs">
	
	<cfquery name="qry" datasource="#arguments.dsn#" username="#request.dbuser#" password="#request.dbpass#"   cachedwithin="#createtimespan(0,0,0,0)#"> 
	select title, location, employer, url, dateposted, datecollected, convertedpostdate 
	from directemployerlistings
	where employer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#urldecode(arguments.employer)#">
	order by dateposted desc, title
	</cfquery>
		
	<cfreturn qry>
</cffunction>

<cffunction name="getDirectEmployers" output="no" access="public" returntype="query" hint="I get jobs by employer">
	<cfargument name="dsn" required="yes" default="jobs">
	<cfquery name="qry" datasource="#arguments.dsn#" username="#request.dbuser#" password="#request.dbpass#" cachedwithin="#createtimespan(0,0,20,0)#">
	select distinct employer
	from directemployerlistings
	order by employer
	</cfquery>	
	
	<cfreturn qry>
</cffunction>



<cffunction name="getJobCount" output="no" access="public" returntype="query" hint="I get a total job count">
	<cfargument name="dsn" required="yes" default="jobs">
	
	<cfquery name="qry" datasource="#arguments.dsn#" username="#request.dbuser#" password="#request.dbpass#" cachedwithin="#createtimespan(0,0,20,0)#">
	select count(id) as totaL
	from directemployerlistings
	</cfquery>	
	
	<cfreturn qry>
</cffunction>



</cfcomponent>