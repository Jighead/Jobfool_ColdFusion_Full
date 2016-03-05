<!--- search paramaters
Our API Key = iouhbqerwiytfdwqlohiroi
kw=keyword
zc= zipcode or city,state or state
cname = all or part of a company name
i =  e (employers only) s (staffing firms only)
so = "relevance" or "initdate"
rs = row start (1 - 500)
re = row end (1-500)
si = search id This is a cache id pass it in subsequent searches like for paginantion
--->
<cfcomponent displayname="Job Central API">

<!---::::::::::::::::::::::::::::::::::::: --->
	 <cfset request.dsn = "jobs">
<!---::::::::::::::::::::::::::::::::::::: --->

<cffunction name="getEmployers" access="public" output="no" returntype="query">
<cfargument name="letter" required="no" default="0">
	<cfquery name="qryEmployers" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
	select employer
	from employerlist
	<cfif arguments.letter is not "0">
	where employer like '#arguments.letter#%'
	</cfif>
	order by employer
	</cfquery>
	<cfreturn qryEmployers />
</cffunction>


<cffunction name="getJobs" access="public" output="yes" returntype="string">
	<cfargument name="kw" type="string" default="" hint="any keyword">
	<cfargument name="co" type="string" default="walmart" hint="employer name">
	<cfargument name="i" type="string" default="e" hint="toggles employer or staffing firms (e = employers, s = staffing)">
	<cfargument name="so" type="string" default="initdate" hint="sort order (relevance or initidate)">
	<cfargument name="rs" type="string" default="1" hint="row start (1-500)">
	<cfargument name="re" type="string" default="500" hint="row end (1-500)">
	<cfargument name="si" type="string" default="si_#arguments.co#" hint="Search id, this is a cache id pass it in subsequent searches like for paginantion">
	<cfargument name="letter" type="string" default="0" required="no">

	<cfset var status = "Completed Successfully">
	<cfset var XML ="">
	<cfset var totalrecords ="">
	<cfset var size ="">
		
	<cfif len(arguments.kw)><cfset arguments.so = "relevance"></cfif>
	
	<!--- query our employers table and loop thru them --->
	<cfif arguments.letter is not "0">
		<cfset employers = getEmployers(#arguments.letter#)>
	<cfelse>
		<cfset employers = getEmployers()>
	</cfif>
	
	<cfoutput query="employers">
	<cfset arguments.co = "#employer#">
#employer#<br>

	<!--- make the call to JC to get all listings for this employer --->
	<cfhttp url="http://www.jobcentral.com/api.asp?key=iouhbqerwiytfdwqlohiroi&cname=#urlencodedFormat(arguments.co)#&kw=#arguments.kw#&so=#arguments.so#&i=#arguments.i#&rs=#arguments.rs#&re=1000&si=#arguments.si#">

	<cfif cfhttp.statuscode contains "200"><!--- valid response from JobCentral server --->
		
		<!---  parse the raw XML into CF usable struct --->
		<cfset XML = xmlparse(cfhttp.filecontent)>
	
		<cfset request.TotalRecords = xml.api.recordcount.xmltext>
		<cfif request.totalrecords>
		<!--- how many times for our outer loop to make subsequent calls tp JobCentral --->
		<cfset size = #arraylen(xml.api.jobs.job)#>
		
			<!--- loop thru result set and insert data --->
			<cfloop from="1" to="#size#" index="j">	
					<cfset job = xml.api.jobs.job[j]><!--- create the job struct --->
					
					
				<!--- cleanse locations --->	
				<cfquery name="loc" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
				select * from states
				where statecode = '#trim(job.location.xmlText)#'	
				</cfquery>
				
				<cfif loc.recordcount gt 0>
					<cfset job.location.xmlText = "#loc.state#"> 
				</cfif>
				
					<!--- set values from the job struct --->
					<cfset form.url = job.url.xmlText>
					<cfset form.title = job.title.xmlText>
					<cfset form.employer = job.company.xmlText>
					<cfset form.location = job.location.xmlText>
					<cfset form.dateposted = job.dateacquired.xmlText>	
					<!--- convertedpostdate --->
					<cfset published = ParseDateTime(form.dateposted) />
					<cfset days = DateDiff("d", published, now())> 
					<cfset hrs = DateDiff("h", published, now())>
					<cfset subdays = days * 24> 
					<cfset hrs = hrs - subdays>
					
					<cfif days GT 1>
						<cfset form.convertedpostdate = "#days# days and #hrs# hours">
					<cfelseif days eq 1>
						<cfset form.convertedpostdate = "1 day and #hrs# hours">
					<cfelseif hrs eq 0>
						<cfset form.convertedpostdate= "#days# days">
					<cfelseif hrs lte 0>
						<cfset form.convertedpostdate = "1 hour">
					<cfelse>
						<cfset form.convertedpostdate = "#hrs# hours">
					</cfif>
					
						
					<!--- :::: call the insert function and insert the record into DB ::::: --->
					<cfset insertData(form)>
					<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
			</cfloop>
		</cfif>
		<cftry>
		<cfcatch type="any">
		
		<cfmail from="thejobfool.com" to="jobfool@gmail.com" subject="Direct employer scrape failed" type="html"  spoolenable="no">
		
		The direct employer scrape from jobcentral failed at #now()#
		
		<cfdump var="#catch#">
		<cfif isdefined('#error#')>
			<cfdump var="#error#">
		</cfif>
		</cfmail>
		<cfthrow message="The direct employer scrape from jobcentral failed at #now()#">
		<cfreturn status is "collection failed">
				<cfdump var="#catch#">
		<cfif isdefined('#error#')>
			<cfdump var="#error#">
		</cfif>
		<cfabort>
		</cfcatch>
		</cftry>		
	<cfelse>

		<cfmail from="thejobfool.com" to="jobfool@gmail.com" subject="Direct employer scrape failed" type="html"  spoolenable="no">
		
		The direct employer scrape from JobCentral failed at #now()#
		
		<p>&nbsp;</p>
		
		<cfdump var="#cfhttp#">
		
		</cfmail>
		

		<cfset status = "Collection Failed!">
	</cfif>

	</cfoutput>

	
</cffunction>
	
<cffunction name="insertData" output="no" access="private" returntype="void" hint="I insert employer data into the database">
	<cfargument name="form" type="any" required="yes">
	
	

	<cfquery name="dupcheck" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
		select id 
		from directemployerlistings
		where employer = '#form.employer#' and dateposted = '#form.dateposted#' and title = '#form.title#' and url = '#form.url#'
	</cfquery>
	<cfif dupcheck.recordcount is 0>

		<cfquery datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
		insert into DirectEmployerListings
		(title, url, employer, location, dateposted, convertedpostdate)
			Values
		('#ucase(form.title)#', '#form.url#', '#form.employer#', '#form.location#', '#form.dateposted#', '#form.convertedpostdate#')	
		</cfquery>

	</cfif>
</cffunction>
	
<cffunction name="getDEJobsbyEmployer" output="no" access="public" returntype="query" hint="I get jobs by employer">
	<cfargument name="title" required="no" default="">
	<cfargument name="employer" required="no" default="">
	<cfargument name="location" required="no" default="">
	<cfargument name="dateposted" required="no" default="">
	<cfargument name="datecollected" required="no" default="">
	<cfargument name="dsn" required="yes" default="jobs">
	
	<cfquery name="qry" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#" >
	select title, location, employer, url, dateposted, datecollected 
	from directemployerlistings
	where employer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.employer#">
	order by dateposted desc, title
	</cfquery>
	
	<cfreturn qry>
</cffunction>

<cffunction name="deleteJobs" output="no" access="public" returntype="boolean" hint="I delete old employer data">
	<!--- <cfargument name="olderthan" type="numeric" required="no" default=""> --->
	<cfargument name="letter" type="string" required="no" default="0">
	
	<cfset var status = 1>
	<!---
	<cfset var staledate = DateDiff("d", #arguments.olderthan#, now() )>
	<cfset staledate = dateformat(staledate,"mm/dd/yyyy")>
	--->
	<cftry>
		<cfquery datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
		DELETE FROM DirectEmployerListings
		<cfif arguments.letter is not "0">
			where employer like '#arguments.letter#%'
		</cfif>
		</cfquery>
		<cfcatch><cfset status = 0></cfcatch>
	</cftry>		
	<cfreturn status>
</cffunction>



	
	
</cfcomponent>
