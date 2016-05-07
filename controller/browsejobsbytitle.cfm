<cfsilent>
<cfparam name="url.kw" default="">
<cfparam name="url.l" default="">
<cfparam name="url.tl" default="A">
<cfif isdefined('url.tl')>
	<cfquery name="getTitles" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
	select jobtitle, id
	from jobtitles
	where jobtitle like <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim('#url.tl#%')#" />
	order by jobtitle
	</cfquery>	
	<cfset thistitle = "Job Search - Jobs By Title - #gettitles.jobtitle#">
</cfif>	
<cfparam name="qrydata.recordcount" default="0" >
</cfsilent>