<cfcomponent>
	<cfset  dsn = "jobs">

	<cffunction name="addJob" access="public" returntype="boolean" hint="I add a job to myjobs table">
		<cfargument name="cfid" required="yes" type="string">
		<cfargument name="jobid" required="yes" type="string">
		<cfargument name="joburl" required="yes" type="string">
		<cfargument name="jobtitle" required="no" type="string" default="">
		<cfargument name="jobdescription" required="no" type="string" default="">
		<cfargument name="jobexpires" required="no" type="string" default="">
		<cfargument name="jobpublished" required="no" type="string" default="">
		<cfargument name="jobtype" required="no" type="string" default="">
		<cfargument name="jobemployer" required="no" type="string" default="">
		<cfargument name="jobfunction" required="no" type="string" default="">
		<cfargument name="jobsource" required="no" type="string" default="">
		<cfargument name="jobsourcelink" required="no" type="string" default="">
		<cfargument name="joblocation" required="no" type="string" default="">
        <cfargument name="useragent" required="no" type="string" default="">
		
		<cfquery name="dupcheck" datasource="#dsn#">
			select jobid from myjobs where cfid = '#arguments.cfid#' and jobid = '#arguments.jobid#'
		</cfquery>
        
			<cfif dupcheck.recordcount is 0>
			<cftry>
				<cfquery name="addJob" datasource="#dsn#">
				INSERT into myjobs				
				(cfid
				,jobid
				,joburl
				,jobtitle
				,jobdescription
				,jobexpires
				,jobpublished
				,jobsource
				,jobsourcelink
				,jobemployer
				,joblocation
				,jobtype
				,jobfunction
                ,useragent
				)
				VALUES(	
				'#arguments.cfid#'
				,'#arguments.jobid#'
				,'#arguments.joburl#'
				,'#arguments.jobtitle#'
				,'#arguments.jobdescription#'
				,#arguments.jobexpires#
				,#arguments.jobpublished#
				,'#arguments.jobsource#'
				,'#arguments.jobsourcelink#'
				,'#arguments.jobemployer#'
				,'#arguments.joblocation#'
				,'#arguments.jobtype#'
				,'#arguments.jobfunction#'
                ,'#arguments.useragent#'
				)
				</cfquery>	
				<cfcatch type="any"><cfreturn false></cfcatch>
			</cftry>
			</cfif>
		<cfreturn true>
	</cffunction>
	
	
	<cffunction name="deleteJob" access="public" returntype="boolean" hint="I delete a job">
		<cfargument name="cfid" required="yes" type="string">
		<cfargument name="jobid" required="yes" type="string">

		<cftry>
			<cfif dupcheck.recordcount is 0>
				<cfquery name="addJob" datasource="#dsn#">
				delete from myjobs
				where cfid = '#arguments.cfid#' and jobid = '#arguments.jobid#'
				</cfquery>
			</cfif>
			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="addsearch" access="public" returntype="boolean" hint="I save a job search">
		<cfargument name="kw" required="yes" default="">
		<cfargument name="L" required="no" default="">
		<cfargument name="radius" required="no" default="50">
		<cfargument name="jt" required="no" default="">
		<cfargument name="jf" required="no" default="">
		<cfargument name="emp" required="no" default="">
		<cfargument name="salary" required="no" default="">
		<cfargument name="sb" required="no" default="">
		<cfargument name="datesaved" required="no" default="">
		
		<cfquery name="dupcheck" datasource="#dsn#">
		select * from mysearches 
			where cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cfid#">
			and kw = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.kw#">
			and Loc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.L#">
			and Radius = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.radius#">
			and jt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.jt#">
			and jf = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.jf#">
			<cfif len(arguments.salary) gt 1>and salary = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.salary#"></cfif>
			<cfif len(arguments.emp) gt 1>and emp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emp#"></cfif>
			<cfif len(arguments.sb) gt 1>and sb = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sb#"></cfif> 

		</cfquery>

		<cfif dupcheck.recordcount eq 0>
			
			<cfquery name="addSearches" datasource="#dsn#">
			insert into mySearches
			(cfid,kw,loc,radius,jt,jf,emp,salary,sb,datesaved)
			values
			(<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cfid#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.kw#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.L#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.radius#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.jt#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.jf#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emp#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.salary#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sb#">,
			<cfqueryparam cfsqltype="cf_sql_date" value="#arguments.datesaved#">)		
			</cfquery>
			<cftry>
			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
			</cftry>
		<cfelse>
		<cfreturn false>
		</cfif>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction name="deleteOldJobs" access="public" returntype="boolean" hint="I delete expired jobs">
	
		<cfset var myjobs = "">
		<cfset var dd = dateadd("d",-7,now())>
		<cfset var dday = dateformat(dd,"yyyy-mm-dd")>
		
		<cftry>
			<cfquery name="myjobs" datasource="clientdata2">
			DELETE FROM thejobfool.dbo.myjobs
			where jobexpires <= '#dday#'
			</cfquery>
		<cfcatch><cfreturn 0></cfcatch>
		</cftry>
		
		<cfreturn 1>
	</cffunction>
	
</cfcomponent>