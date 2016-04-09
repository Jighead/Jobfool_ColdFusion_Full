<cfoutput>
<cfsilent>
<cfparam name="uid" default="#randrange(100001,9999999)#">
<cfsavecontent variable="desc">
#rereplace( thistitle , '[""'']' , '' , 'all' )# - #rereplace( desc.description , '[""'']', '' , 'all' )# #rereplace( thistitle , '[""'']' , '' , 'all' )#
</cfsavecontent>
<cfset desc2 = replacenocase(desc, "  ", "", "all")>
<cfset desc3 = replacenocase(desc2, "#chr(13)##chr(10)#", "", "all")>
<cfif thistitle contains "jobs jobs">
	<cfset thistitle = replacenocase(thistitle, "jobs jobs", "jobs", "one")>
</cfif>
<cfif thistitle contains "in in">
	<cfset thistitle = replacenocase(thistitle, "in in", "in", "one")>
</cfif>
<cfset variables.canonical = replacenocase(variables.canonical," ", "+")>
</cfsilent>
	<title><cfif isdefined('URL.DO')>Viewing #url.do#<CFELSE>#trim(thisTitle)# | Job Search </cfif></title>
<!---
<meta id="keywords" name="keywords" content="#thistitle#, #url.l#, job search, job listings, career, employment job boards, direct employer, work from home, #thistitle#"/>
--->
<cfif cgi.HTTP_USER_AGENT contains "facebookexternalhit">
	<meta id="description" = "#thistitle#, #url.l#, job search, job listings, career search, employment job board, direct employer, work from home, #thistitle#">
<cfelse>
	<meta id="description" name="description" content="#trim(desc3)#" />
</cfif>
	<link rel="canonical" href="#canonical#" />
<cfif isdefined(url.p) and url.p gt 1>
	<meta name="robots" content="noindex, follow" />
<cfelse>
	<meta name="robots" content="index, follow" />
</cfif>
</cfoutput>