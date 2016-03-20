<cfif url.do eq 1 and isdefined('url.jobid')><!--- indeed jobs only --->  
<cftry>
<cfsilent>
	<cfset jk = url.jobid>
    
    <cfset jk = decrypt(url.jobid, "jf", "CFMX_COMPAT", "Base64") />
    
    <cfhttp url="http://www.indeed.com/rc/clk?jk=#jk#" method="get" resolveurl="no" redirect="no" useragent="#cgi.HTTP_USER_AGENT#" /> 
    
	<cfif cfhttp.responseheader.location contains "http://us.conv.indeed.com/rc/clk?jk">
         <cfhttp url="#cfhttp.responseheader.location#" method="get" resolveurl="no" redirect="no" useragent="#cgi.HTTP_USER_AGENT#" />
    </cfif> 
    
	<cfset trueurl = cfhttp.responseheader.location >
 	<cfoutput>#trueurl#</cfoutput>
   	<cflocation url="#trueurl#"  addtoken="no">
    
    <cfset referrer = cgi.HTTP_REFERER>
    <cfset ipaddress = cgi.REMOTE_ADDR>
    <cfset exitedto =  trueurl>

    <cfabort>
        <cfquery name="track" datasource="#request.dsn#">
        insert into exitrack
        </cfquery>  
    <cfset sleep(1)>

    <cflocation url="#trueurl#"  addtoken="no">
</cfsilent>   
        <cfcatch>
        <h1>The Job Fool was unable to fetch this job from the web.</h1>
        <p>Please click back on your browser and select a different job listing.</p>
        <p>Thank You</p>
        </cfcatch>
    </cftry>
    <cfabort>
			<!---  debugging code
            <cfhttp url="http://www.indeed.com/rc/clk?#indeedjk#" method="get" resolveurl="no" redirect="no" useragent="#cgi.HTTP_USER_AGENT#">
            <cfhttp url="http://www.indeed.com/rc/clk?jk=#indeedjk#" method="get" redirect="yes" resolveurl="no" useragent="#cgi.HTTP_USER_AGENT#" > 
                <cfdump var="#cfhttp#"><cfabort>
                <cfset url.do = cfhttp.responseheader.location>
            --->
</cfif> 

<cflocation url="#url.do#" addtoken="no">
<cfabort>