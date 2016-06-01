<cfoutput>
    <cfif cgi.http_host CONTAINS "www.">
        <cfset redirect = "http://thejobfool.com">
        <cfheader statuscode="301" statustext="Moved permanently">
        <cfheader name="Location" value="#redirect#">
        <cfabort>
    <cfelseif cgi.http_host CONTAINS "jobfool.net">
        <cfset redirect = "http://thejobfool.com">
        <cfheader statuscode="301" statustext="Moved permanently">
        <cfheader name="Location" value="#redirect#">
        <cfabort>
    <cfelseif cgi.http_host CONTAINS "thejobfool.net">
        <cfset redirect = "http://thejobfool.com">
        <cfheader statuscode="301" statustext="Moved permanently">
        <cfheader name="Location" value="#redirect#">
        <cfabort>
    </cfif>
    </cfoutput>
<cfsilent>
<!--- This file is part of the CFCore framework.

    CFCore framework is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, Version 2 of the License.

    CFCore framework is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with CFCore framework.  If not, see <http://www.gnu.org/licenses/>. --->

    <!--- Application name, should be unique --->
    <cfset this.name = "TheJobFool16:">
    <cfset this.something = "foobar">
    <!--- How long application vars persist --->
    <cfset this.applicationTimeout = createTimeSpan(1,0,0,0)>
    <!--- Where should cflogin stuff persist --->
    <cfset this.loginStorage = "cookie">
    <!--- Should we even use sessions? --->
    <cfset this.sessionManagement = true>
    <!--- How long do session vars persist? --->
    <cfset this.sessionTimeout = createTimeSpan(0,0,10,0)>
    <!--- Should we use clientvariable? --->
    <cfset this.clientmanagement = false>
    <!--- Define the client storage datasource
    <cfset This.clientStorage="clientdata2">
    --->
    <!--- Should we set cookies on the browser? --->
    <cfset this.setClientCookies = false>
    <!--- should cookies be domain specific, ie, *.foo.com or www.foo.com --->
    <cfset this.setDomainCookies = false>
    <!--- should we try to block 'bad' input from users --->
    <cfset this.scriptProtect = false>
    <!--- should we secure our JSON calls? --->
    <cfset this.secureJSON = false>
    <!--- Should we use a prefix in front of JSON strings? --->
    <cfset this.secureJSONPrefix = "">

    <cfset this.domain=  "http://#cgi.http_host#/" />
    <!--- define the location of your webroot --->
    <cfset this.baseDir=  #ExpandPath("\")# />

    <!--- define a list of custom tag paths. --->
    <cfset this.customtagpaths = this.baseDir  &  "custom-tags\">

    <!--- define custom coldfusion mappings. Keys are mapping names, values are full paths  --->

    <cfset this.mappings = structNew()>
    <!--- <cfset this.mappings["/CFIDE"] = "c:\inetpub\wwwroot\cfide\">
    <cfset this.mappings["/coldspring"] = this.baseDir & "plugins\coldspring\">
    <cfset this.mappings["/lightwire"] = this.baseDir & "plugins\lightwire\">
    <cfset this.mappings["/fusebox5"] = this.baseDir & "plugins\fusebox5\">
    <cfset this.mappings["/modelglue"] = this.baseDir & "plugins\modelglue\">
    <cfset this.mappings["/reactor"] = this.baseDir & "plugins\reactor\">
    <cfset this.mappings["/transfer"] = this.baseDir & "plugins\transfer\"> --->
        
        
<cfset request.mailAttributes = {
    server="mail.thejobfool.com",
    username="jobfool",
    password="5hamburg5"
} />

</cfsilent>
<!--- <cfdump var="#this#"><cfabort> --->
