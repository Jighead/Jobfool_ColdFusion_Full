<cfcomponent>
		<cfset dsn = request.dsn>
	<cffunction name="getJobsbyUserID" access="public" returntype="query" hint="I get a list of jobs by userid">
    	<cfargument name="userid" type="string" required="yes">
        <cfquery name="getJobs" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
        SELECT cfid ,jobid,joburl ,jobtitle ,jobdescription,jobexpires ,jobpublished ,jobsalary ,jobtype ,jobemployer ,jobfunction ,jobsource ,joblocation 
        ,jobsourcelink ,rating ,applied ,comments
        FROM myjobs
        where cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userid#" null="no">
        order by rating desc, jobtitle asc
        </cfquery>
            <cfreturn getJobs>
    </cffunction>
    
    <cffunction name="getSearchbyUserID" access="public" returntype="query" hint="I get a list of jobs by userid">
    	<cfargument name="userid" type="string" required="yes">
        <cfquery name="Searches" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
          select * from mysearches
          where cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userid#" null="no">
          order by rating desc, kw asc, Loc asc
        </cfquery>
        <cfreturn searches>
    </cffunction>
    
    <cffunction name="getJobAlertsByUserID" access="public" returntype="query" hint="I get a list of jobs by userid">
    	<cfargument name="userid" type="string" required="yes">
        <cfquery name="jobalerts" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
        select * from jobalerts
        where cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userid#">
		</cfquery>
       <cfreturn jobalerts>
    </cffunction>        
   
    <cffunction name="deleteJob" access="public" returntype="boolean" hint="I delete a job">
		<cfargument name="jobid" type="string" required="yes">
        <cfargument name="userid" type="string" required="yes">
        
       <cftry>
        <cfquery name="deleteJobs" datasource="#request.dsn#">
            delete from myjobs
            where jobid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.jobid#">
            and cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userid#">
        </cfquery>
         <cfcatch><cfreturn false></cfcatch>
        </cftry>
        
		<cfreturn true>
	</cffunction>
    
    <cffunction name="deleteSearch" access="public" returntype="boolean" hint="I delete a search">
    	<cfargument name="uid" type="string" required="yes">
        <cfargument name="userid" type="string" required="yes">
       
        <cftry> 
        <cfquery name="deletesearch" datasource="#dsn#">
            delete from mysearches
            where uid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#">
            and cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userid#">
        </cfquery>
        <cfcatch><cfreturn false></cfcatch>
        </cftry>
    
    	<cfreturn "true">
    </cffunction>
    
    <cffunction name="updateAlert" access="public" returntype="boolean" hint="I update a job alert">
        <cfargument name="uid" type="string" required="yes">
        <cfargument name="userid" type="string" required="yes">

        <cfquery name="updatealert" datasource="#dsn#">
            update jobalerts
            set verified = <cfqueryparam cfsqltype="cf_sql_varchar" value="false">
            where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#">
            and cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userid#">
        </cfquery>
    
    	<cfreturn "true">
    </cffunction>
    
    
    
    <cffunction name="updateJob" access="public" returntype="boolean" hint="I update a job alert">
    	<cfargument name="applied" type="string" required="yes">
    	<cfargument name="comments" type="string" required="yes">
        <cfargument name="rating" type="string" required="yes">
        <cfargument name="jobid" type="string" required="yes">
        <cfargument name="userid" type="string" required="yes">
        
        <cfquery name="updateJobs" datasource="#dsn#">
        update myjobs
        set 
        applied = <cfif isDefined('form.applied')>'true'<cfelse>'false'</cfif>,
        rating = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.rating#" null="no">,
        comments = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.comments#" null="no">
        where cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userid#" null="no">
        and jobid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.jobid#" null="no">
        </cfquery>
        
        <cfreturn "true">
    </cffunction>
    
</cfcomponent>