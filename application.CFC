<cfcomponent output="false">

 <cfinclude template="appsettings.cfm">


    <cffunction name="OnApplicationStart"  access="public" returntype="boolean" output="false" hint="Fires when the application is first created.">
        <cfscript>
            application.drivepath = (GetDirectoryFromPath(GetCurrentTemplatePath()));
           // application.admincomponentpath = "system.admin.components";
           // application.componentpath = "system.components";
        </cfscript>
    <cfreturn true />
    </cffunction>




    <cffunction name="onRequestStart" returnType="boolean" output="true">
        <cfargument name="thePage" type="string" required="true">
        <!--- set a cookie to see if this is a bot or not (bots dont except cookies)--->
        <cfcookie name="ipaddress" value="#cgi.REMOTE_ADDR#" expires="never">
        <cfif cgi.PATH_INFO contains "jobool.com"><cfabort></cfif>

        <!--- Force reload the application  --->
        <cfif isDefined("url.reinit")>
            <cfset structClear(application)>
        </cfif>
        <cfinclude template="/system/config/settings.cfm">
        <!--- <cfinclude template="/system/customtags/urlparser.cfm"> --->
        <cfinclude template="/system/config/DomainAliasManager.cfm">
        <cfinclude template="/system/udf/lib.cfm">
        <!---
       <cfif not cgi.REMOTE_ADDR is not "97.102.160.56">
                  <cfinclude template="tempdown.cfm"><cfabort>
       </cfif>
        --->
            
        <cfif isDefined('url.appdump')>
            <cfset appdump()>
        </cfif>

        <cfreturn true>
    </cffunction>


<!--- Handle 404 errors --->
<cffunction name="onMissingTemplate" returnType="boolean">
    <cfargument type="string" name="targetPage" required=true/>

<cftry>

    <!--- set response to 404 for Search Engine and statistical purposes --->

    <cfheader statusCode = "404"  statusText = "Page Not Found" >

    <!--- retrieve the error template from the application scope --->
    <cflock timeout="5" scope="application">
        <cfset ErrorTemplate = This.ErrorTemplate>
    </cflock>

    <!--- include a template to show to the user --->
    <cfinclude template = "#ErrorTemplate#">

    <!--- return true to prevent the default ColdFusion error handler from running --->
    <cfreturn true />

    <cfcatch>
    <!--- If an error occurs within the error handler routine, allow ColdFusion's default error handler to run --->
        <cfreturn false />
    </cfcatch>
</cftry>

</cffunction>
<!---
<cffunction name="onError" returnType="void" output="true">
    <cfargument name="exception" required="true">
    <cfargument name="eventname" type="string" required="true">
    <cfset var errortext = "">

    <cflog file="myerrorlog" text="#arguments.exception.message#">

    <cfsavecontent variable="errortext">
    <cfoutput>
    An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
    Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#<br />

    <cfdump var="#arguments.exception#" label="Error">
    <cfdump var="#form#" label="Form">
    <cfdump var="#url#" label="URL">
    <cfdump var="#cgi#" label="CGI">

    </cfoutput>
    </cfsavecontent>

    <cfmail to="jobfool@gmail.com" from="errors@thejobfool.com" subject="Error: #arguments.exception.message#" type="html">
        #errortext#
    </cfmail>

    - <cflocation url="error.cfm"> -

</cffunction>
--->



    <cffunction name="appdump" output="true">
        <cfdump var="#this#"><cfabort>
    </cffunction>

</cfcomponent>
