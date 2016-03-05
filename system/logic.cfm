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
<cfparam name="url.kw" default="hiring">
<cfparam name="url.qt" default="16">
<cfparam name="url.l" default="">
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
<!---<cfparam name="client.lastloc" default="">--->
<!---<cfparam name="client.lastkw" default="">--->
<cfparam name="qrydata.recordcount" default="0">
<cfparam name="qrydata.title" default="">
<cfparam name="qryEmp.recordcount" default="0">
<cfparam name="jobdata.recordcount" default="0">
<cfset url.end = url.st + url.qt>
<cfparam name="variables.thistitle" default="Job Search | The Job Fool">
<cfparam name="desc.description" default="Speed up your job search and find better employment! The Job Fool searches millions of jobs from thousands of sites. New Jobs are posted hourly. Find hot new jobs, advance your career, develop new and better employer relations, and learn about career planning. Job search made easy.">
<cfparam name="canonical" default="http://thejobfool/jobs/index.cfm/">

<cfif url.kw contains "enter job title">
	<cfset url.kw ="">
</cfif>

<!--- <cfif url.kw is "" and structkeyExists(client, "lastkw")><cfset url.kw = client.lastkw></cfif>
<cfif url.L is "" and structkeyExists(client, "lastLoc")><cfset url.L = client.lastLoc></cfif> --->


<!--- ::::::::: if search form was submitted we need to check for a keyword and location ::::: --->
<cfif isdefined('form.fieldnames') and isDefined('form.searchform')>
	<cfif cgi.script_name does not contain "/careercenter"><!--- dont do it if it's the blog search --->
	<cfoutput>
	<cfif isdefined('form.kw') and len(form.kw)>
		<cfset form.kw = Replace(form.kw, "*", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "(", "", "ALL")>
		<cfset form.kw = Replace(form.kw, ")", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "@", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "/", " ", "ALL")>
		<cfset form.kw = Replace(form.kw, "[", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "]", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "^", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "`", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "~", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "!", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "=", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "-", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "|", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "$", "", "ALL")>
		<cfset form.kw = Replace(form.kw, """", "", "ALL")>
		<cfset form.kw = Replace(form.kw, "''", "", "ALL")>	
        <cfset form.kw = Replace(form.kw, ",", "", "ALL")>	
		<cfif form.kw is "Enter Keyword"><cfset form.kw = ""></cfif>
        
        <!--- save keywords to keyword table --->
        <cfif isdefined('form.kw') and len(form.kw)>
        	<cfset variables.keyword = form.kw>
            
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
				and variables.keyword does not contain "*"
				>
                

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
				                          
                    <cftry>
                    <!--- add to recentqueires table --->
                    <cfquery name="check2" datasource="jobs">
                    select keyword from RecentQueries where keyword = '#keyword#' and location = '#form.l#' and country = 'US'
                    </cfquery>
                    
                    <cfif check2.recordcount is 0>
                        <cfquery name="insert" datasource="jobs">
                        insert into RecentQueries  
                        (keyword, location, country)  
                        values   
                        ('#trim(keyword)#', '#trim(form.l)#', 'US')
                        </cfquery>
                    </cfif>
                    
                    <cfcatch></cfcatch>
                    </cftry>
			--->			
            			<cftry>
					    <cfquery name="insert" datasource="jobs">
                        insert into RecentQueries  
                        (keyword, location, country, ipaddress, useragent)  
                        values   
                        ('#trim(variables.keyword)#', '#trim(form.l)#', 'US', '#cgi.REMOTE_ADDR#', '#cgi.HTTP_USER_AGENT#')
                        </cfquery>
				       <cfcatch></cfcatch>
                    	</cftry>	

                    <!--- ******************************** --->


                </cfif>
            </cfif>
        </cfif>	
        <!--- end save keywords to keyword table --->
	</cfif>	

	<cfparam name="qst" default="">

	<cfif len(form.kw)>
	<cfset form.kw = trim(form.kw)>
		<cfset qst = "kw/#form.kw#/">
        <cfset client.lastKW = "#form.kw#">
	</cfif>
	<cfif len(form.l)>
	<cfset form.L = trim(form.l)>
		<cfset qst = qst & "L/#form.l#/">
        <cfset client.lastLoc = "#form.L#">
	</cfif>
	<cfif isDefined('form.employer')><!--- if they came from employer section --->
		<cfif len(form.co)>
			<cfset qst = qst & "co/#form.co#/">
		</cfif>
        <cfheader statuscode="301" statustext="Moved permanently"><!--- good seo to use 301 redirect --->
		<cflocation url="/employers/index.cfm/#lcase(qst)#" addtoken="no">
	<cfelse>	
		<cfset qst = qst & "radius/#form.radius#/">
        <cfheader statuscode="301" statustext="Moved permanently"><!--- good seo to use 301 redirect --->
		<cflocation url="/jobs/index.cfm/#lcase(qst)#" addtoken="no">
	</cfif>
	</cfoutput>
	</cfif>
</cfif>

<cfif url.kw EQ "L" or url.kw is "" or url.kw is " " >
	<cfset url.kw = "">
</cfif>


<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::; --->

<!--- google might not like this
<cfif cgi.HTTP_REFERER contains "google" and url.p GT 1 or cgi.HTTP_REFERER contains "yahoo" and url.p GT 1>
	<cflocation url="#request.baseref#/jobs/index.cfm/kw/#url.kw#/l/#url.l#/radius/#url.radius#/p/1" addtoken="no">
</cfif>
 --->

<!--- ::::::::: auto suggest ::::::::::::::: 
<cfif not structKeyExists(application,"autoObj") or isDefined("url.reinit")>
	<cfset application.autoObj = createobject("component","#request.componentpath#.autosuggest")>
</cfif>


<cfset employers = application.autoObj.getEmployersAsQry()>

<cfset cities = application.autoObj.getCitiesAsQry()>
 ::::::::: end auto suggest ::::::::::::::: --->

<cfif isdefined('url.kw') and url.kw is "Enter+Job+Title">
	<cfset url.kw = "">
</cfif>

<cfif isdefined('url.l') and url.L is "enter city or zip code">
	<cfset url.l = "">
</cfif>


<!--- dont use this it's kinda funky <cfif len(url.kw) is 0><cfset url.kw = client.lastkw></cfif> --->

        <!--- save keywords to keyword table --->
        <cfif isdefined('url.kw') and len(url.kw) gt 2>
        	<cfset variables.keyword = replacenocase(url.kw,",","")>
            <cfset variables.keyword = replacenocase(variables.keyword,",","")>
            <cfset variables.keyword = replacenocase(variables.keyword," jobs","")>
            <cfset variables.keyword = replacenocase(variables.keyword," job openings","")>
            <cfset variables.keyword = replacenocase(variables.keyword,"  ","")>
			<cfif listlen(url.kw, " ") lte 3 
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
				and variables.keyword does not contain "*"
				and variables.keyword does not contain ":"
				>
<!---                 <cfquery name="check" datasource="jobs">
                select count( distinct keyword ) as count from keywords where keyword = '#keyword#'
                </cfquery>
                <cfif check.count is 0>
                    <cfquery name="check" datasource="jobs">
                    insert into keywords  (keyword)  values   ('#trim(keyword)#')
                    </cfquery>
                </cfif> --->
       		</cfif>
      
      
      
      
              <!---   <cftry>
                 <!--- add to recentqueires table --->
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
                        ('#trim(keyword)#', '#trim(url.l)#', 'US', '#cgi.REMOTE_ADDR#', '#cgi.HTTP_USER_AGENT#')
                        </cfquery>
                    </cfif>
                </cfif>  
                    <cfcatch></cfcatch>
                </cftry>
     ******************************** ---> 
 
           			<cfif cgi.REMOTE_ADDR is '108.162.212.104'>
                        <cfquery name="insert" datasource="jobs">
                        insert into RecentQueries  
                        (keyword, location, country, ipaddress, useragent)  
                        values   
                        ('#trim(variables.keyword)#', '#trim(url.l)#', 'US', '#cgi.REMOTE_ADDR#', '#cgi.HTTP_USER_AGENT#')
                        </cfquery>
 					</cfif> 

        </cfif>	
        <!--- end save keywords to keyword table ---> 

<!---************************** CONTROLLERS ****************************** --->
<cfif cgi.script_name contains "/jobs" or cgi.script_name contains "/a/" or  cgi.script_name contains "/sandbox"  or  cgi.script_name contains "/layouts"   or  cgi.script_name contains "/themes">
	<!--- <cfinclude template="/Controllers/googlebase.cfm"> --->
      
    <cfif qrydata.recordcount lt url.qt or len(url.jobid) gt 2 > 	<!--- if this is NOT a single job query to Partner Site --->
        <cfinclude template="/system/Controllers/getjobs.cfm">
    </cfif>
	
    <!--- <cfinclude template="/controllers/sponsoredjobs.cfm"> --->
</cfif>

<!---**************************************************************************** --->

<cfif isDefined('url.kw') and url.kw contains "Enter Keyword"><cfset url.kw = ""></cfif>
<cfif isDefined('url.kw') and url.kw is "in"><cfset url.kw = ""></cfif>

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
<cfset variables.canonical = "/jobs/index.cfm">
<cfif cgi.script_name contains "browse-jobs">
	<cfset variables.canonical = "/browse-jobs/index.cfm"> 
</cfif>
<cfif cgi.script_name contains "employers">
	<cfset variables.canonical = "/employers/index.cfm"> 
</cfif>

<cfif url.kw is not "" and len(url.kw)>
	<cfset variables.canonical = variables.canonical & "/kw/#url.kw#/">
</cfif>
<cfif url.L is not "" and len(url.L)>
	<cfset variables.canonical = variables.canonical & "/L/#url.L#/">
</cfif>

<cfif url.CO is not "">
	<cfset variables.canonical = variables.canonical & "/CO/#url.CO#/">
</cfif>

<cfset variables.canonical = replaceNocase(variables.canonical,"//", "/", "all")>


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
