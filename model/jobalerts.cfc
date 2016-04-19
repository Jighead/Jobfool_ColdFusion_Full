<cfcomponent>

    <cffunction name="addAlertConfirm" access="public" output="yes" returntype="boolean" hint="I add User">
        <cfargument name="cfid"  type="string" required="no">
        <cfargument name="email" type="string" required="yes">
        <cfargument name="kw" type="string" required="no">
        <cfargument name="loc" type="string" required="no">
        <cfargument name="country" type="string" required="yes" default="us">
        <cfargument name="radius" type="numeric" required="no" default="50">
        
        <cfset var uuid = "JA-#randrange(1000000,9999999)#-#lsTimeFormat(now(),"hhmmss")#">  

        <cfquery name="dupcheck" datasource="#request.dsn#">
			select * from jobalerts
            where 
            email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
            AND kw = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.kw#">
            AND loc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.loc#">
            AND country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country#">
        </cfquery>
        <cfif dupcheck.recordcount is 0>   
        <cftry>
        <cfquery name="add1" datasource="#request.dsn#">
            insert into jobalerts
            (cfid, uuid, email, kw, loc, radius, country, createdate)
            values 
            (
            '#arguments.CFID#', '#uuid#'
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.email)#" maxlength="20" null="#NOT len(trim(arguments.email))#" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.kw)#" maxlength="50" null="#NOT len(trim(arguments.kw))#" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.loc)#" maxlength="50" null="#NOT len(trim(arguments.loc))#" />
            ,<cfqueryparam cfsqltype="cf_sql_integer" value="50" maxlength="3" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.country)#" maxlength="50" null="#NOT len(trim(arguments.country))#" />
            ,#createODBCDateTime(now())#
            )
        </cfquery>
        
        <!--- 
        <cfmail from="JobAlerts@thejobfool.com" to="#arguments.email#" subject="Job Alert! Please Confirm" type="html" spoolenable="no">
        
        Hello! You asked us to send you daily email alerts for these jobs:<br />
        
		<p><strong>#arguments.kw#<cfif len(arguments.loc)> in #arguments.loc#</cfif><cfif isDefined("arguments.salary") and len(arguments.salary)> - Salary: $#salary#</cfif><cfif len(arguments.jt)> - Job Type: #arguments.jt#</cfif></strong></p>
        
        <strong>You have 3 days to confirm this job alert!</strong><br />
        Please click the link below to confirm you wish to receive the alerts.<br />
        <a href="http://thejobfool.com/myjobs/job-alerts.cfm/confirm/#uuid#">Yes, send me this alert!</a><br /><br />
  
        Alternatively if clicking the link does not work, please copy and paste the following URL into you web browser.<br />
        http://thejobfool.com/myjobs/job-alerts.cfm/confirm/#uuid#

        <p>The Job Fool<br />
        http://thejobfool.com</p>

        </cfmail>
     --->
 
        <cfcatch><cfdump var="#cfcatch#"><cfabort></cfcatch>
        </cftry>
        </cfif>
    <cfreturn true>
    </cffunction>


<cffunction name="addAlert" access="public" output="yes" returntype="boolean" hint="I add User">
        <cfargument name="cfid"  type="string" required="no">
        <cfargument name="email" type="string" required="yes">
        <cfargument name="firstname" type="string" required="no" default="">
        <cfargument name="lastname" type="string" required="no" default="">
        <cfargument name="username" type="string" required="no" default="">
        <cfargument name="password" type="string" required="no" default="">
        <cfargument name="kw" type="string" required="no">
        <cfargument name="loc" type="string" required="no">
        <cfargument name="radius" type="numeric" required="no" default="50">
        <cfargument name="salary" type="string" required="no" default="0">
        <cfargument name="jt" type="string" required="no" default="">
        <cfargument name="country" type="string" required="no" default="us">
      
       
        <cfset var uuid = "JA-#randrange(1000000,9999999)#-#lsTimeFormat(now(),"hhmmss")#">
        
       
        
        <cfquery name="dupcheck" datasource="#request.dsn#">
			select * from jobalerts
            where 
            email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
            AND kw = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.kw#">
            AND loc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.loc#">
            AND radius = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.radius#">
            AND country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country#">
        </cfquery>
        
        
        
		<cfif dupcheck.recordcount is 0>
        <cftry>
        <cfquery name="add1" datasource="#request.dsn#">
            insert into jobalerts
            (cfid, uuid, email, kw, loc, radius, createdate, firstname, username, password, country)
            values 
            ('#arguments.CFID#', '#uuid#'
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.email)#" maxlength="20" null="#NOT len(trim(arguments.email))#" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.kw)#" maxlength="50" null="#NOT len(trim(arguments.kw))#" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.loc)#" maxlength="50" null="#NOT len(trim(arguments.loc))#" />
            ,<cfqueryparam cfsqltype="cf_sql_integer" value="3" maxlength="50" null="#NOT len(trim(radius))#" />
            ,#createODBCDateTime(now())#
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.firstname)#" maxlength="20" null="#NOT len(trim(arguments.firstname))#" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.firstname)#" maxlength="20" null="#NOT len(trim(arguments.username))#" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.password)#" maxlength="20" null="#NOT len(trim(arguments.password))#" />
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.country)#" maxlength="20" null="#NOT len(trim(arguments.country))#" />
        </cfquery>
        
        <cfmail from="JobAlerts@thejobfool.com" to="#arguments.email#" subject="Job Alert! Please Confirm" type="html" spoolenable="no">

        Hello! You asked us to send you daily email alerts for these jobs:<br />
        
		<p><strong>#arguments.kw#<cfif len(arguments.loc)> in #arguments.loc#</cfif><cfif arguments.salary neq 0 > - Salary: $#salary#</cfif><cfif len(arguments.jt)> - Job Type: #arguments.jt#</cfif></strong></p>
        
        <strong>You have 3 days to confirm this job alert!</strong><br />
        Please click the link below to confirm you wish to receive the alerts.<br />
        <a href="http://thejobfool.com/myjobs/job-alerts.cfm/confirm/#uuid#">Yes, send me this alert!</a><br /><br />
  
        Alternatively if clicking the link does not work, please copy and paste the following URL into you web browser.<br />
        http://thejobfool.com/myjobs/job-alerts.cfm/confirm/#uuid#

        <p>
        Thank You<br />
        The Job Fool<br />
        http://thejobfool.com</p>

        </cfmail>
 
        <cfcatch><cfdump var="#cfcatch#"><cfabort></cfcatch>
        </cftry>
        </cfif>

    <cfreturn true>
    </cffunction>
    
    
    <cffunction name="checkEmail" access="public" output="no" returntype="boolean" hint="I check for duplicate user email address">
        <cfargument name="cfid"  type="string" required="yes">
        <cfargument name="email" type="string" required="yes">
               
        <cfquery name="dupcheck" datasource="#request.dsn#">
        select cfid from jobalerts 
        where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
        and cfid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cfid#">
        and verified = 'true'
        </cfquery>
        
        <cfif dupcheck.recordcount gt 0>
			<cfreturn false>
        <cfelse>
        	<cfreturn true>
        </cfif>
     </cffunction>
     
     <cffunction name="confirmAlert" access="public" output="no" returntype="boolean" hint="I confirm a job alert">
        <cfargument name="uuid"  type="string" required="yes">
        
          
        <cfquery name="confirm" datasource="#request.dsn#">
        select uuid from jobalerts 
        where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uuid#">
        </cfquery>

        <cfif confirm.recordcount gt 0>
            <cfquery name="updatealert" datasource="#request.dsn#">
            update jobalerts
            set verified = <cfqueryparam cfsqltype="cf_sql_varchar" value="true">
            where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uuid#">
            </cfquery>
			<cfreturn true>
        <cfelse>
        	<cfreturn false>
        </cfif>
     </cffunction>
     
     
     <cffunction name="sendAlerts" access="public" output="no" returntype="boolean" hint="I confirm a job alert">
                 
		<cfset var ja = structNew()>
        <cfset var today = dateformat(now(), "yyyy-mm-dd")>
        
        <cfquery name="alerts" datasource="#request.dsn#">
        select * from jobalerts 
        where email is not null
        and verified = 'true'
        and subscribed = 'true'
        </cfquery>
        
		
		<cfif not StructKeyExists(application, "gbobj")>
            <!--- <cfobject name="application.gbObj" component="#request.componentpath#.gbJobs"> --->
            <cfobject name="application.indeed" component="#request.componentpath#.IndeedJobs">
        </cfif>
        
		<cfif alerts.recordcount>  
               <cfloop query="alerts">
				<cfset ja.kw = alerts.kw>
                <cfset ja.l = alerts.loc>
                <cfset ja.radius = alerts.radius>
                <cfset ja.salary = alerts.salary>
                
                <cfset qryData = application.indeed.getJobs(argumentcollection=#ja#)>
                
            	<cfif qrydata.recordcount>
                
                <cfsavecontent variable="emailbody"><cfoutput>
                        <cfquery name="filter" dbtype="query">
                        select title, published, employer, location, source, jobid, expiration_date
                        from qrydata 
                        where published_date >= '#today#'
                        order by published
                        </cfquery>

                         <div style="margin:10px 40px;">
                         <span style="color:##C11426">#filter.recordcount# new Job<cfif filter.recordcount gt 1>s</cfif> for...</span>
                         <strong>"#ucase(ja.kw)#" <cfif len(ja.radius) and len(ja.l)>within #ja.radius# miles of #ucase(ja.l)#</cfif>
                         <cfif len(ja.salary)>Salary: #ja.salary#</cfif><br>
                         </strong>
                         </div>
                        <table cellspacing="0" cellpadding="2">
                        <tr bgcolor="silver"><th>Title</th><th>Location</th><th>Within</th><th>Listed</th></tr>
                        <cfloop query="filter">
                            <cfset id = replaceNoCase(jobid,"http://www.google.com/base/feeds/snippets/","","one")>
                            <cfif len(location)><cfset city = getToken(location,1,",")><cfset state = getToken(location,2,",")></cfif>
							<tr><td nowrap><a href="http://thejobfool.com/jobs/detail.cfm/id/#id#/ex/#lsdateformat(expiration_date, "mm-dd-yyyy")#" style="color:##35567D">#title#</a></td><td>#city#, #state#</td>
                            <td align="center">#alerts.radius# mi.</td><td>Today at #timeformat(published,"hh:mm tt")#</td></tr>
                        </cfloop>
                        </table>
                        <br><br>
                        To cancel/un-subscribe this job alert please <a href="http://thejobfool.com/myjobs/cancelalert.cfm">click here</a><br>
                        <cfif alerts.recordcount gt 1><hr /></cfif>
                </cfoutput></cfsavecontent>
                </cfif>
                </cfloop>

        
        <cfif emailbody contains "http://thejobfool.com/jobs/detail.cfm">
            
            <cfmail from="JobAlerts@thejobfool.com" to="#alerts.email#" subject="Job Alert! New Jobs from The Job Fool - #dateformat(now(), "medium")#" type="html" replyto="TheJobFool.com"  spoolenable="no">
            <p><big>Your <img src="http://thejobfool.com/images/logo_jobalerts.gif" hspace="10" align="ABSMIDDLE" border="0">Daily Job Alert!</big></p>
            #emailbody#
            </cfmail>
            
        </cfif>  
        
        </cfif>
        
		<cfabort>
     </cffunction>
	 
	  <cffunction name="sendAlertsIndeed" access="public" output="yes" returntype="string" hint="I confirm a job alert">
      <cfargument name="country" required="no" default="US">         
		<cfset var ja = structNew()>
        <cfset var yesterday = dateadd("h",-24,now())>
        <cfset var today = dateformat(yesterday, "yyyy-mm-dd")>
        <cfset var time = timeformat(yesterday, "HH:MM")>
        
        <cfset today = today &" "& time>
        
        <!---  clean up bad emails --->
        <cfquery name="deletealerts" datasource="#request.dsn#">
        delete from jobalerts 
        where email is null
        </cfquery>
                
        <cfquery name="alerts" datasource="#request.dsn#">
        select * from jobalerts 
        where email is not null
        and verified = 'true'
        and subscribed = 'true'
        order by createdate desc
        </cfquery>
 
             <cfif len(alerts.country) lt 2>
            	<cfset ja.country = 'US'>
            </cfif>
         
        <cfoutput> #alerts.recordcount#<br /></cfoutput>
           
    	<cfoutput query="alerts">
            <cfif len(email) gt 1>
                <cfset ja.kw = alerts.kw>
                <cfset ja.l = alerts.loc>
				<cfset ja.co = alerts.country>               
                <cfset ja.radius = alerts.radius>
                <cfset ja.fromage = "1">
 
           <!--- get the jobs --->
            <cfinvoke component="#request.componentpath#.getIjobs" method="getJobs" argumentcollection="#ja#" returnvariable="jobdata" />
            <!--- This section for display only --->

  <h3>#alerts.email#</h3>
         <cfif jobdata.recordcount GT 1>
                <table>
                <cfloop query = "jobdata">
                    <tr>
                      <td width="40%" class="job-data">
                    <a class="job-data" href="http://thejobfool.com/jobs/detail.cfm/jobid/#jobid#/ex/1/ref/alert" style="decoration:none;"><span style="font-size: 12px;color:##35567D"><strong>#trim(title)#</strong></span></a>
                      </td> 
                      <td class="job-data">#trim(location)#</td>
                      <td class="job-data">#trim(publish_date)#&nbsp;&nbsp;#trim(publisheddisplay)#</td>
                    </tr>
                 </cfloop>
                </table>
                <hr />
                <!--- end section for display only --->		
                
<cfmail from="NewJobs@TheJobFool.com" to="#alerts.email#" subject="Job Alert! New Jobs from The Job Fool - #dateformat(now(), "medium")#" type="html"  spoolenable="no">
                
                <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
                <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
                <style type="text/css">
                
                .job-data {font-family:Verdana, Geneva, sans-serif;text-decoration:none;}
                table {border-collapse:collapse; font-size:12px;}
                td {border:1px solid ##ddd;}
				
                </style>
                <body style="font-size:.8em">       
                <div id="body" style="font-family:Verdana, Arial, Geneva, Helvetica, sans-serif; font-size:12px;padding: 18px 18px 18px 18px;color:black;">
                <div id="title" style="font-size:38px; font-family:'Times New Roman', Times, serif;margin-bottom: 14px;"><a href="http://thejobfool.com" style="text-decoration: none;"><!--- <span style="color: black;"><strong>The</strong> ---><span style="color:##36567D;padding-right:0px;"><strong>Job</strong></span><span style="color: ##C12028;"><strong>Fool</strong></span></a><span style="font-size:17px;padding-left:20px;"><strong>Your Daily Job Alert</strong></span></div>
                
                <div style="margin:10px 10px;"><span style="color:##C11426">#jobdata.recordcount# new Job<cfif jobdata.recordcount gt 1>s</cfif> </span><strong><cfif ja.kw is not"">for "#ucase(ja.kw)#"</cfif> <cfif len(ja.radius) and len(ja.l)>within #ja.radius# miles of #ucase(ja.l)#</cfif></strong><br></div>
                
                  <table border="0" cellspacing="0" cellpadding="2">
                    <tr style="text-align: left;">
                      <td style="min-width: 200px;"><strong>Title</strong></td>
                      <td style="min-width: 60px;"><strong>Location</strong></td>
                      <td style="min-width: 60px;"><strong>Date Posted</strong></td>
                    </tr> 
                    <!--- loop thru the jobs --->
                <cfloop query = "jobdata">
                    <tr>
                      <td width="40%" class="job-data">
                    <a class="job-data" href="http://thejobfool.com/jobs/detail.cfm/jobid/#jobid#/ex/1/ref/alert" style="decoration:none;"><span style="font-size: 12px;color:##35567D"><strong>#trim(title)#</strong></span></a>
                      </td> 
                      <td class="job-data">#trim(location)#</td>
                      <td class="job-data">#trim(publish_date)#&nbsp;&nbsp;#trim(publisheddisplay)#</td>
                    </tr>
                 </cfloop>
                </table>
                <br /><br />
                <p>View matching jobs in the last <a href="http://thejobfool.com/jobs/index.cfm/kw/#ja.kw#/l/#ja.l#/radius/#ja.radius#/from/1/ref/alert">24 hours</a> - <a href="http://thejobfool.com/jobs/index.cfm/kw/#ja.kw#&l/#ja.l#/radius/#ja.radius#/from/7/ref/alert">last 7 days</a> - <a href="http://thejobfool.com/jobs/index.cfm/kw/#ja.kw#&l/#ja.l#&radius/#ja.radius#/ref/alert">all time</a></p>
                
                <br /><br /><br />
                <p style="font-size:11px;">To cancel/un-subscribe this job alert please <a href="http://thejobfool.com/myjobs/cancelalert.cfm">click here</a><br></p>
                </div>                
                </body>
                </html>
                </cfmail>
                </cfif>
           </cfif>
		</cfoutput>
       <cfreturn "Emails were sent successfully!">
   </cffunction>   


</cfcomponent>
