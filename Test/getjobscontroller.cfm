<cfparam name="noreturn" default="false">
<cfparam name="url.kw" default="">
<cfset intStartTime = GetTickCount() />
<cfparam name="url.l" default="">
<cfparam name="url.co" default="US">
<cfparam name="url.sb" default="">
<cfparam name="url.radius" default="50">
<cfparam name="request.grecords" default="0">
<cfparam name="url.qt" default="10"><!--- qty per page --->
<cfparam name="url.p" default="1"><!--- default page were on --->
<cfparam name="url.st" default="1"><!--- default start row were on --->
<cfparam name="url.from" default="90"><!--- default start row were on --->
<cfset url.fromage = url.from>
<cfparam name="request.intotalrecords" default="">
<cfset foo = randrange(1, 10)>

<cfif len(url.l) lt 2 and len(url.kw) lt 2 and cgi.HTTP_HOST is "thejobfool.com">
    <cfif foo eq 1><cfset url.l ="California"></cfif>
    <cfif foo eq 2><cfset url.l ="Florida"></cfif>
    <cfif foo eq 3><cfset url.l ="New Jersey"></cfif>
    <cfif foo eq 4><cfset url.l ="Minnesota"></cfif>
    <cfif foo eq 5><cfset url.l ="Maryland"></cfif>
    <cfif foo eq 6><cfset url.l ="Georgia"></cfif>
    <cfif foo eq 7><cfset url.l ="Virginia"></cfif>
    <cfif foo eq 8><cfset url.l ="North Carolina"></cfif>
    <cfif foo eq 9><cfset url.l ="Ohio"></cfif>
    <cfif foo eq 10><cfset url.l ="Michigan"></cfif>
</cfif>


<cfif url.kw contains "Enter Keyword" or url.kw contains "enter job"><cfset url.kw = ""></cfif>
<cfif url.l eq "Enter City, State or Zip"><cfset url.l=""></cfif>
<cfif structKeyExists(session, "sb")>
    <cfset url.sb = session.sb>
    <cfif url.sb is "d">
        <cfset url.sb = "d">
        <cfset session.sb = "d">
    <cfelse>
        <cfset url.sb = "r">
        <cfset session.sb = "r">
    </cfif>
</cfif>


<cfinvoke component="#request.componentpath#._IJSON" method="get" argumentcollection="#url#" returnvariable="jobdata">
<!--- <cfdump var="#jobdata#" label="jobdata"> --->
<CFABORT>

