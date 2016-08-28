<!--- if we have a normal query_string (aka a form submitted URL) re-write to SES url and redirect to it 
<cfif len(cgi.query_string) and cgi.query_string contains "=">
<cfoutput>#cgi.query_string#</cfoutput><br />
	<cfset qstring=reReplaceNoCase(cgi.query_string, "[=?&]", "/", "all")>
<cfoutput>#qstring#</cfoutput>	
	<cflocation url="index.cfm/#qstring#" addtoken="no">
</cfif> 
--->
<cfinclude template="/system/udf/sentenceCase.cfm">
<cfparam name="request.co" default="US">
<cfset url.co = request.co> <!--- conditionally set in config/settings.cfm based on subdomain --->
<cfparam name="url.l" default="">
<cfparam name="url.kw" default="">
<cfparam name="url.qt" default="10">
<cfparam name="url.radius" default="50">
<cfparam name="url.emp" default="">
<cfparam name="url.jobid" default="">
<cfparam name="variables.ltitle" default="">
<cfparam name="url.jt" default="">
<cfparam name="job_type" default="">
<cfparam name="EXPIRATION_DATE" default="">
<cfparam name="url.ji" default="">
<cfparam name="url.jf" default="">
<cfparam name="url.ji" default="">
<cfparam name="url.salary" default="">
<cfparam name="url.st" default="1">
<cfparam name="url.p" default="1">
<cfparam name="session.sb" default="r">
<cfparam name="url.sb" default="r">
<cfparam name="url.ac" default="">
<cfparam name="url.tl" default="">
<cfparam name="url.co" default="">
<cfparam name="url.let" default="">
<cfparam name="url.id" default="">
<cfparam name="variables.location" default="">
<cfparam name="variables.COtitle" default="">
<cfparam name="variables.Ltitle" default="">
<cfparam name="variables.noreturn" default="0">
<cfparam name="form.radius" default="50">
<cfparam name="qrydata.recordcount" default="0">
<cfparam name="qrydata.title" default="">
<cfparam name="qryEmp.recordcount" default="0">
<cfparam name="jobdata.recordcount" default="0">
<cfset url.end = url.st + url.qt>
<cfparam name="thistitle" default="Job Search | The Job Fool">
<cfparam name="desc.description" default="Find your perfect job from thousands of career websites with one simple search!">
    
<cfparam name="canonical" default="http://thejobfool/jobs/?">

<cfif len(url.kw) LT 2 and len(url.l) lt 2>

<cfswitch expression="#request.co#">

<cfcase value="ca">
	<cfset url.kw = ''>
	<cfset url.l = 'Toronto'>
</cfcase>

<cfcase value="es">
	<cfset url.kw = ''>
	<cfset url.l = 'Madrid'>
</cfcase>

<cfcase value="de">
	<cfset url.kw = ''>
	<cfset url.l = 'Berlin'>
</cfcase>

<cfcase value="fr">
	<cfset url.kw = ''>
	<cfset url.l = 'Paris'>
</cfcase>

<cfcase value="gb">
	<cfset url.kw = ''>
	<cfset url.l = 'London'>
</cfcase>

<cfdefaultcase>
	<cfset url.kw = 'hiring'>
    <cfset url.l = 'United States'>
</cfdefaultcase>

</cfswitch>

</cfif>

<!--- ::::::::: if search form was submitted we need to check for a keyword and location ::::: --->
<cfoutput>
<cfif isdefined('URL.L') and len(URl.L)>
        <cfset URL.L = Replace(URL.L, "*", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "(", "", "ALL")>
        <cfset URL.L = Replace(URL.L, ")", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "@", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "/", " ", "ALL")>
        <cfset URL.L = Replace(URL.L, "[", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "]", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "^", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "`", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "~", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "!", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "=", "", "ALL")>

        <cfset URL.L = Replace(URL.L, "_", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "|", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "$", "", "ALL")>
        <cfset URL.L = Replace(URL.L, """", "", "ALL")>
        <cfset URL.L = Replace(URL.L, "''", "", "ALL")>	
</cfif>
<cfif isdefined('URL.kw') and len(URl.kw)>
   
    <cfset URL.kw = Replace(URL.kw, "*", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "(", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, ")", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "@", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "/", " ", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "[", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "]", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "^", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "`", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "~", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "!", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "=", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "_", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "|", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "$", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, """", "", "ALL")>
    <cfset URL.kw = Replace(URL.kw, "''", "", "ALL")>	
 

	<!--- save keywords to keyword table --->

    <cfset variables.keyword = URL.kw>
    <cfset variables.keyword = replacenocase(variables.keyword,",","")>
    <cfset variables.keyword = replacenocase(variables.keyword," job opening","")>
    <cfset variables.keyword = replacenocase(variables.keyword," jobs opening","")>
    <cfset variables.keyword = replacenocase(variables.keyword,"  ","")>

    <cfif listlen(keyword, " ") lte 3>               
        <cfif variables.keyword does not contain " in " 
            and variables.keyword does not contain " in" 
            and variables.keyword does not contain " for "
            and variables.keyword does not contain " for"
            and variables.keyword does not contain " of"
            and variables.keyword does not contain " to "
            and variables.keyword does not contain " with "
            and variables.keyword does not contain " ("
            and variables.keyword does not contain ","	
            and variables.keyword does not contain " all "
            and variables.keyword does not contain " )"	
            and variables.keyword does not contain "("
            and variables.keyword does not contain ","	
            and variables.keyword does not contain " all "
            and variables.keyword does not contain ")"
            and variables.keyword does not contain " ' "
            and variables.keyword does not contain '"'
            and variables.keyword does not contain "$"
            and variables.keyword does not contain "--"
            and variables.keyword does not contain "-"
            and variables.keyword does not contain "!"
            and variables.keyword does not contain "%"
            and variables.keyword does not contain "@"
            and variables.keyword does not contain ">"
            and variables.keyword does not contain "?"
            and variables.keyword does not contain "+"
            and variables.keyword does not contain "*" >
            
                <cfset REQUEST.UserAgent = LCase( CGI.http_user_agent ) />
                <!---				                    
                <cfquery name="check" datasource="jobs"> 
                select distinct keyword from keywords where keyword = '#keyword#'
                </cfquery>

                <cfif check.recordcount is 0>
                    <cfquery name="check" datasource="jobs">
                    insert into keywords  (keyword)  values   ('#trim(keyword)#')
                    </cfquery>
                </cfif> 
                --->		                          
                <cftry>
                    <!--- add to recentqueires table --->
                    <cfquery name="check2" datasource="jobs">
                    select keyword from RecentQueries where keyword = '#keyword#' and location = '#URL.l#' and country = 'US'
                    </cfquery>

                    <cfif check2.recordcount is 0>
                        <cfquery name="insert" datasource="jobs">
                        insert into RecentQueries  
                        (keyword, location, country)  
                        values   
                        (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(lcase(variables.keyword))#" />
                         ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.l)#" />
                         ,<cfqueryparam maxlength="2" cfsqltype="cf_sql_varchar" value="#trim(lcase(request.co))#" />)
                        </cfquery>
                    </cfif>

                <cfcatch></cfcatch>
                </cftry>
			
                <cftry>
                    <cfquery name="insert" datasource="jobs">
                    insert into RecentQueries  
                    (keyword, location, country, ipaddress, useragent)  
                          values   
                        (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(lcase(variables.keyword))#" />
                         ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.l)#" />
                         ,<cfqueryparam maxlength="2" cfsqltype="cf_sql_varchar" value="#trim(lcase(request.co))#" />
                         ,<cfqueryparam maxlength="20" cfsqltype="cf_sql_varchar" value="#trim(cgi.REMOTE_ADDR)#" />
                         ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(cgi.HTTP_USER_AGENT)#" />)
                    </cfquery>
                   <cfcatch></cfcatch>
                </cftry>	
        </cfif> <!--- end save keywords to keyword table --->

    </cfif>
</cfif>

    

<cfif cgi.path_info contains 'kw/' or cgi.path_info contains '/kw/' or cgi.path_info contains 'l/' or cgi.path_info contains '/l/'>
    <cfset redir = '/jobs/?kw=#lcase(url.kw)#&l=#lcase(url.l)#'>
    <cfheader statuscode="301" statustext="Moved permanently">
    <cflocation url="#redir#" addtoken="no">
</cfif>
    
  
</cfoutput>
 <cftry>
    <cfif cgi.REMOTE_ADDR is '173.245.56.131'>
     <!--- this excludes crawlers --->
        <cfquery name="check2" datasource="jobs">
        select keyword from RecentQueries 
        where keyword = '#keyword#' and location = '#url.l#' and country = 'US'
        </cfquery>
        
        <cfif check2.recordcount is 0>
            <cfquery name="insert" datasource="jobs">
            insert into RecentQueries  
            (keyword, location, country, ipaddress, useragent)  
                  values   
        (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(variables.keyword)#" />
         ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.l)#" />
         ,<cfqueryparam maxlength="2" cfsqltype="cf_sql_varchar" value="#trim(ucase(request.co))#" />
         ,<cfqueryparam maxlength="20" cfsqltype="cf_sql_varchar" value="#trim(cgi.REMOTE_ADDR)#" />
         ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(cgi.HTTP_USER_AGENT)#" />)
            </cfquery>
        </cfif>
    </cfif>  
        <cfcatch></cfcatch>
    </cftry>
 
	<cfif cgi.REMOTE_ADDR is '108.162.212.104'>
        <cfquery name="insert" datasource="jobs">
        insert into RecentQueries 
        (keyword, location, country, ipaddress, useragent)    
        values   
        (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(variables.keyword)#" />
         ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.l)#" />
         ,<cfqueryparam maxlength="2" cfsqltype="cf_sql_varchar" value="#trim(ucase(request.co))#" />
         ,<cfqueryparam maxlength="20" cfsqltype="cf_sql_varchar" value="#trim(cgi.REMOTE_ADDR)#" />
         ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(cgi.HTTP_USER_AGENT)#" />)
        </cfquery>
    </cfif> 

<!---************************** CONTROLLERS ****************************** --->
<cfif cgi.script_name contains "/jobs" or cgi.script_name contains "/a/" or  cgi.script_name contains "/sandbox"  or  cgi.script_name contains "/layouts"   or  cgi.script_name contains "/themes">
    <!--- <cfinclude template="/controllers/sponsoredjobs.cfm"> --->
</cfif>

<!---**************************************************************************** --->


<!--- create thistitle from query_string --->
<cfif isdefined('cgi.query_string')>	
	<cfif isDefined('url.kw') and len(kw)><cfset variables.kwtitle = "#sentencecase(url.kw)#"></cfif>
	<cfif isDefined('url.L') and len(L)><cfset variables.Ltitle = "#ucase(url.L)#"></cfif>
    <cfif isDefined('url.emp')><cfset variables.Etitle = "#ucase(url.emp)#"></cfif>
    <cfif isDefined('url.salary') and url.salary gt 0><cfset variables.stitle = "salary #url.salary#"><cfelse><cfset variables.stitle = "#url.salary#"></cfif>
    <cfif isDefined('url.jt')><cfset variables.jttitle = "#url.jt#"></cfif>
    <cfif isDefined('url.ji')><cfset variables.jititle = "#url.ji#"></cfif>
    <cfif isDefined('url.radius')><cfset uvariables.rtitle = "within #url.radius# mi"></cfif>
    <cfset UID = "uid#randrange(1000, 9000000)#">
	<cfparam name="kwtitle" default="">
    
    <cfif variables.thistitle eq "the job fool"><cfset variables.thistitle = ""></cfif>
	<cfif len(variables.kwtitle) and len(variables.ltitle)><cfset variables.thistitle =  variables.kwtitle &" Jobs "& variables.ltitle></cfif>
    <cfif len(variables.kwtitle) and len(variables.ltitle) lt 2><cfset variables.thistitle =  variables.kwtitle &" Jobs"></cfif>
    <cfif len(variables.kwtitle) lt 2 and len(variables.ltitle) gt 1><cfset variables.thistitle =  "Jobs "& variables.ltitle></cfif>
    <cfif len(variables.etitle) gt 2><cfset variables.thistitle = variables.thistitle &" "& variables.etitle></cfif>
        
    
	<cfset thistitle = "#thistitle#"> 
    <cfset uid = "#randrange(1000,99999999)#">
</cfif>
 
<cfif isDefined('url.kw') and url.L is "L" or url.kw is "radius">
	<cfset url.kw = "">
</cfif>

<cfif isDefined('url.L') and url.L is "/" or url.L is "radius">
	<cfset url.L = "">
</cfif>

<cfset variables.canonical = "/jobs/?">
    
<cfif cgi.script_name contains "browse-jobs">
	<cfset variables.canonical = "/browse-jobs/index.cfm"> 
</cfif>

<cfif cgi.script_name contains "employers">
	<cfset variables.canonical = "/employers/"> 
</cfif>

<cfif url.kw is not "" and len(url.kw)>
	<cfset variables.canonical = variables.canonical & "kw=#url.kw#">
</cfif>

<cfif url.L is not "" and len(url.L)>
	<cfset variables.canonical = variables.canonical & "&l=#url.L#">
</cfif>

<cfif url.CO is not "">
	<cfset variables.canonical = variables.canonical & "&co=#url.co#">
</cfif>

<cfset variables.canonical = replaceNocase(variables.canonical,"//", "/", "all")>
    
<cfif variables.canonical contains '?&'>
    <cfset variables.canonical = replace(variables.canonical, "?&", "?", "all")>
</cfif>

<!---
<cfif url.p is GT 1>
	<cfset canonical = canonical & >
</cfif>

<cfif url.TL is not "">
	<cfset canonical = canonical & "/TL/#url.TL#/">
</cfif>
<cfif url.let is not "">
	<cfset canonical = canonical & "/let/#url.let#/">
</cfif>
--->

<cfset variables.canonical = replacenocase(variables.canonical,"//", "/")>
<cfif isDefined('url.L') and len(L)><cfset variables.Ltitle = "#ucase(url.L)#"></cfif>
