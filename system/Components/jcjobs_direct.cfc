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

<cffunction name="getJobs" access="public" output="no" returntype="query">
	<cfargument name="kw" type="string" default="" hint="any keyword">
	<cfargument name="co" type="string" default="walmart" hint="employer name">
	<cfargument name="i" type="string" default="e" hint="toggles employer or staffing firms (e = employers, s = staffing)">
	<cfargument name="so" type="string" default="initdate" hint="sort order (relevance or initidate)">
	<cfargument name="rs" type="string" default="1" hint="row start (1-500)">
	<cfargument name="re" type="string" default="20" hint="row end (1-500)">
	<cfargument name="si" type="string" default="si_#arguments.co#" hint="Search id, this is a cache id pass it in subsequent searches like for paginantion">
	<cfargument name="L" type="string" default="" hint="location">

<cfif len(arguments.kw)><cfset arguments.so = "relevance"></cfif>


<cfhttp url="http://www.jobcentral.com/api.asp?key=iouhbqerwiytfdwqlohiroi&cname=#urlencodedFormat(arguments.co)#&kw=#arguments.kw#&so=#arguments.so#&i=#arguments.i#&rs=#arguments.rs#&re=#arguments.re#&zc=#arguments.L#">

	<!---  parse the raw XML into CF usable struct --->
	<cfset XML = xmlparse(cfhttp.filecontent)>

	<cfset request.TotalRecords = xml.api.recordcount.xmltext>
	<cfset loopcount = ceiling(request.TotalRecords / 10)>
	<cfset size = #arraylen(xml.api.jobs.job)#>


	<cfset myquery = createNewQuery()>
		<!--- Now add XML data to our query --->
    	<cfset queryaddrow(myquery, size)>
	

	<cfloop from="1" to="#size#" index="i">	
			<cfset job = xml.api.jobs.job[i]><!--- create the job struct --->
			<!--- set values from the job struct --->
			<cfset link = job.url.xmlText>
			<cfset title = job.title.xmlText>
			<cfset employer = job.company.xmlText>
			<cfset location = job.location.xmlText>
			<cfset dateposted = job.dateacquired.xmlText>
			
	
			<cfset querysetcell(myquery, "link",#link#, i)>
			<cfset querysetcell(myquery, "title",#title#, i)>
			<cfset querysetcell(myquery, "employer",#employer#, i)>
			<cfset querysetcell(myquery, "location",#location#, i)>
			<cfset querysetcell(myquery, "dateposted",#dateposted#, i)>
			
			<!---
			<div style="border:1px solid red; padding:3px; margin:2px">
			<a href="#job.url.xmlText#">#title#</a><br>
			#company# - #location#<br>
			Posted on #lsDateFormat(dateposted)# #lsTimeFormat(dateposted)#
			</div>
			--->
	</cfloop>

		<cfreturn myQuery>
</cffunction>



	<cffunction name="createNewQuery" access="public" output="false" returntype="query" 
	hint="I create/initilize a 1 row query to to force datatyping ">	
		<cfset var myquery = "">
		<cfset var typelist = "">
		<cfset var str = "">
		<cfset var date = "">
 
		<!--- ad your column names --->
		<cfset columnlist = "link,title,employer,location,dateposted">
		<!--- seupt datatypes for our columns --->
		<cfset typelist = "str,str,str,str,date">
		<cfset str = "">
		<cfset date = Now()>
        
     	<cfset myquery = querynew("#columnlist#")>
		<!--- Put values in to the first row to establish column datatypes and avoid query of query runtime errors --->
		<cfset QueryAddRow(myquery,1)> 
		<cfloop from = 1 to = "#ListLen(ColumnList)#" index="i">
		<cfset QuerySetCell(myquery,ListGetAt(ColumnList,i),evaluate(ListGetAt(TypeList,i)),1)>
		</cfloop>
		<!--- Force Define the datatype in the query --->
		<cfquery name="rquery" dbType="query">
		SELECT *
		FROM myquery
		WHERE 1 <> 1
		</cfquery>
		<cfreturn myquery>
	</cffunction>
	
	
	
	<!--- =============== SubQueries (filters) start here =============== --->
	<cffunction name="getLocations" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="locations">
            select distinct(location) as location
			from myquery
            where location is not NULL
			group by location
      </cfquery>
	</cfif>
	<cfreturn locations>
	</cffunction>

</cfcomponent>
