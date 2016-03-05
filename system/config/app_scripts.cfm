<cfsilent>
<!--- set session and client vars here  <cfif not cgi.HTTP_USER_AGENT contains "google-bot"> --->
<cfif isDefined('cookie.ipaddress')>
    <!--- <cfset session.userid = client.cfid &':'& client.cftoken > --->
    <cfset session.userid = Session.SessionID />
    <cfcookie name="userid" value="#session.userid#" expires="never">
    <!--- <cfset client.userid = client.cfid &':'& client.cftoken > --->
    <cfset session.userIP = cgi.REMOTE_ADDR>
    <!--- <cfset client.ip = cgi.REMOTE_ADDR> --->
    <!--- set search cookies --->
    <cfif isdefined('url.kw')><cfset session.lastKW = "#url.kw#"></cfif>
    <cfif isdefined('url.L')><cfset session.lastLoc = "#url.L#"></cfif>
    <cfif isdefined('url.jt')><cfset session.lastJT = "#url.jt#"></cfif>
</cfif>

<cfparam name="request.citystate" default= "">
<!--- ========= GEOLOCATION =========

<cfif not structKeyExists(application,"geoloc") or isDefined('url.reinit')>
    <cfset application.geo = createObject("component", "#request.componentpath#.geoloc")/>
</cfif>

<cfif isDefined('session.userip')>
    <cfset session.loc = application.geo.getIPPagesLoc(session.userip)>

    <cfif structKeyExists(session,"loc") and len(session.loc.city) and len(session.loc.state)>
        <cfset session.loc.state = listFirst(session.loc.state,"-")>
        <cfset request.citystate = session.loc.city &', '& session.loc.state>
    <cfelseif structKeyExists(session,"loc") and len(session.loc.city) and not len(session.loc.state)>
        <cfset request.citystate = session.loc.city>
    <cfelse>
        <cfset request.citystate = "">
    </cfif>
</cfif> --->
<!--- dont use it in the form --->
<cfset request.citystate = "">

<!--- ======= END GEOLOCATION ====== --->

<cfif cgi.HTTP_HOST is "localhost">
    <cfset request.baseref = "http://localhost" />
<cfelse>
    <cfset request.baseref = "http://#cgi.HTTP_HOST#" />
</cfif>

<!--- SPIDERS WE WANT TO BLOCK --->
<cfif
    CGI.Http_User_Agent CONTAINS "38.99.115.195"
    or CGI.Http_User_Agent CONTAINS "nutch"
    or cgi.REMOTE_ADDR contains "213.115.42."
    or cgi.remote_addr contains "180.76.5.17" or CGI.Http_User_Agent CONTAINS "Baiduspider"<!--- biaduspider --->
    or cgi.remote_addr contains "50.17.40.223" or CGI.Http_User_Agent CONTAINS "tumblr.com"
    >

    <cflocation url = "http://213.115.42.230/" addtoken="no">
<cfabort>
</cfif>


<!--- LOG SPIDER VISITS
<cfif CGI.Http_User_Agent contains "google" or CGI.Http_User_Agent contains "slurp" <!--- or CGI.Http_User_Agent contains "msnbot" ---> or CGI.Http_User_Agent contains "69.249.">
    <cfif isDefined('cgi.query_string')>
        <cfset page = CGI.Script_Name &"|"& cgi.path_info>
    <cfelse>
        <cfset page= CGI.Script_Name>
    </cfif>

         <cfset date = #dateformat(now(), "yyyy/mm/dd")#>
         <cfset time = #Timeformat(now(), "h:mm:ss tt")#>
         <cfset today = date &' '& time>

        <cftry>
        <cfquery name="ins" datasource="#request.dsn#" password="#request.dbpass#" username="#request.dbuser#">
        insert into spiderman
        (ip, visitdate, spider, page)   values
        ('#cgi.REMOTE_ADDR#', '#today#', '#CGI.Http_User_Agent#', '#page#')
        </cfquery>
        <cfcatch></cfcatch>
        </cftry>

</cfif>
--->
<cfif cgi.http_host is not "localhost">
<!--- ======= ERROR HANDLERS =======
<cfif cgi.remote_addr neq "97.102.162.37">
    <cfif not isDefined('url.debug')>
    <cferror type="exception" template="/error.cfm">
    <cferror type="request" template="/error_request.cfm">
    </cfif>
</cfif> --->
</cfif>

<!--- ============================== --->
</cfsilent>
<cfif isDefined('url.dump')><cfdump var="#url#"><cfdump var="#client#"><cfabort></cfif>


