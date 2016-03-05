<cfcomponent>
	<cffunction name="GetPaidJobs" access="public" returntype="boolean">
	<cftry>
    <cfhttp url="http://www.jobtarget.com/distrib/jobs/rss.cfm?code=x9ZbMuj2Gv9UTf5MoFUJitmFrykrbO4k" resolveurl="no" method="get"> 
    
    <cfset XML = xmlparse(cfhttp.filecontent)>
    
    <cfset job = structNew()>
    <cfoutput>
    <cfloop index="x" from="1" to="#arrayLen(xml.rss.channel.item)#">
        <cfset item = xml.rss.channel.item[x]>
     
        <cfif structKeyExists(item, "guid")>
            <cfset job.jobid = "#item.guid.xmltext#">
        <cfelse>
            <cfset job.jobid = "">
        </cfif>
        <cfif structKeyExists(item, "title")>
            <cfset job.title = "#item.title.xmltext#">
        <cfelse>
            <cfset job.title = "">
        </cfif>
        <cfif structKeyExists(item, "link")>
            <cfset job.link = "#item.link.xmltext#">
        <cfelse>
            <cfset job.link = "">
        </cfif>
        <cfif structKeyExists(item, "description")>
            <cfset job.description = "#item.description.xmltext#">
        <cfelse>
            <cfset job.description = "">
        </cfif>
        <cfif structKeyExists(item, "pubDate")>
            <cfset job.pubDate = "#item.pubDate.xmltext#">
        <cfelse>
            <cfset job.pubDate = "">
        </cfif>
        <cfif structKeyExists(item, "jobs:company")>
            <cfset job.company = "#item["jobs:company"].xmltext#"><!--- Need to use bracket notation for custom elements --->
        <cfelse>
            <cfset job.company = "">
        </cfif>
        <cfif structKeyExists(item, "jobs:location")>
            <cfset job.location = "#item["jobs:location"].xmltext#"> 
        <cfelse>
            <cfset job.location = "">
        </cfif>
        
        <cfif len(job.jobid) gt 2  and job.link gt 25>
			<cfset publisheddate = dateformat(job.pubDate, "yyyy-mm-dd")>
            <cfset expires = dateadd('d', '32', '#job.pubDate#')>
        
             <cfquery name="dupcheck" datasource="#request.dsn#">
             select jobid from paidjobs 
             where jobid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#job.jobid#">
             </cfquery>
            
             <cfif dupcheck.recordcount eq 0>    
                           
             <!--- let's parse the location --->
              <cfset job.city = getToken(job.location, "1", ",")>
              <cfset job.state = getToken(job.location, "2", ",")>
              <cfset job.country = getToken(job.location, "3", ",")>

                    <p style="color:green">
                    <h4>New Job: Inserted</h4>
                    #job.jobid# #job.title# <br>
                    #job.description# <br>
                    #job.company#<br>
                    #job.link#<br>
                    #createODBCdate(publisheddate)# | #createODBCdate(expires)#</p>
             

                   <cfquery name="dupcheck" datasource="#request.dsn#">
                   insert into paidjobs 
                   (jobid, title, description, publisheddate, url, company, location, expires, city, state, country)
                   values
                   ('#job.jobid#', '#job.title#', '#job.description#', #createODBCdate(publisheddate)#, '#job.link#', '#job.company#', '#job.location#', #createODBCdate(expires)#, '#job.city#', '#job.state#', '#job.country#')
                   </cfquery>
                   
             <cfelse>
                   <p style="color:sliver">
                   <h4>Already exist: not inserted</h4>
                   #job.jobid# #job.title# <br>
                    #job.description# <br>
                    #job.company#<br>
                    #job.link#<br>
                    #createODBCdate(publisheddate)# | #createODBCdate(expires)#
                    <hr size="1">
                    </p>
             </cfif>
        </cfif>
    </cfloop>
    </cfoutput>

 <cfcatch type="any">
         <cfmail from="errors@thejobfool.com" to="jobfool@gmail.com" subject="Error parse Job target paid jobs into DB"  spoolenable="no">
             There were errors trying to parse and insert the job target paid job feed.
            <p> An error occurred at #DateFormat( Now(), "mmm d, yyyy" )# at #TimeFormat( Now(), "hh:mm TT" )# </p>
            <cfoutput>
            <p>#cfcatch.Message#</p>
            <p>#cfcatch.detail#</p>
           </cfoutput>
           <cfdump var="#cfcatch#">
         </cfmail>
         <cfoutput>
            <p>#cfcatch.Message#</p>
            <p>#cfcatch.detail#</p>
           </cfoutput>
		<cfdump var="#cfcatch#">
        <cfreturn false>
 </cfcatch>
 </cftry>
 	<cfreturn true>
	</cffunction>
</cfcomponent>