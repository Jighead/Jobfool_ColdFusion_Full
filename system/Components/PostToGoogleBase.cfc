<cfcomponent displayname="GoogleBase" hint="GoogleBase" output="false" author="Taco Fleur (code.google.com@clickfind.com.au)" 	version="1">

	<!--- 

		***** Copyright 2007 Commerce Engine Pty Ltd (clickfind) *****
		
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
	
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
	
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.

	--->

	<!--- Set instance variables --->
	<cfscript>
		variables.constant.EMAIL = "jobfool@gmail.com";
		variables.constant.PASSWORD = "5hamburg5";
		variables.constant.DEVELOPER_KEY = "ABQIAAAAjUaEFoDM_QIxkQUblpsAvRSJewOUAzbkhYKqD0Q0-iE_jVmu5xQVSVIEbYuJq1sBDDDtYx2SLZGZaQ";
		variables.constant.AUTHENTICATION_URL = "https://www.google.com/accounts/ClientLogin";
		variables.instance.authenticationToken = "";
	</cfscript>


	<cffunction access="public" name="init" output="false" returntype="GoogleBase">
		<cfscript>return this;</cfscript>
	</cffunction>


	<cffunction access="public" name="doAuthenticate" output="false" returntype="void">
		<cfhttp url="#variables.constant.AUTHENTICATION_URL#" method="post" delimiter="," resolveurl="no">
			<cfhttpparam type="header" name="Content-type" value="application/x-www-form-urlencoded">
			<cfhttpparam type="formfield" name="Email" value="#variables.constant.EMAIL#">
			<cfhttpparam type="formfield" name="Passwd" value="#variables.constant.PASSWORD#">
			<cfhttpparam type="formfield" name="service" value="gbase">
			<cfhttpparam type="formfield" name="accountType" value="GOOGLE">
			<cfhttpparam type="formfield" name="source" value="[thejobfool]-[jobfooljobfeed.xml]-[1]">
		</cfhttp>
		<cfscript>
			result = reFindNoCase( "Auth=(.+)$", cfhttp.fileContent, 1, true );
			variables.authenticationToken = mid( cfhttp.fileContent, result.pos[ 2 ], result.len[ 2 ] );
			setAuthenticationToken( variables.authenticationToken );
		</cfscript>
	</cffunction>


	<cffunction access="private" name="setAuthenticationToken" output="false" returntype="void">
		<cfargument name="authenticationToken" required="yes" type="string">
		<cfscript>
			variables.instance.authenticationToken = arguments.authenticationToken;
		</cfscript>
	</cffunction>


	<cffunction access="public" name="getAuthenticationToken" output="false" returntype="string">
		<cfif len( variables.instance.authenticationToken ) eq 0 >
			<cfthrow message="You must authenticate first with doAuthenticate().">
		</cfif>
		<cfscript>
			return variables.instance.authenticationToken;
		</cfscript>
	</cffunction>


	<cffunction access="public" name="doInsert" output="false" returntype="string">
		<cfargument name="myXML" required="yes" type="string">

		<cfhttp url="http://base.google.com/base/feeds/items" method="post" delimiter="," resolveurl="no" charset="utf-8">
			<cfhttpparam type="header" name="Content-Type" value="application/atom+xml">
			<cfhttpparam type="header" name="Authorization" value="GoogleLogin auth=#getAuthenticationToken()#">
			<cfhttpparam type="header" name="X-Google-Key" value="key=#variables.constant.DEVELOPER_KEY#">
			<cfhttpparam type="body" value="#arguments.myXML#">
		</cfhttp>
		<cfscript>
			variables.response = xmlParse( cfhttp.fileContent );
			variables.id = variables.response.xmlRoot.id.xmlText;
			return variables.id;
		</cfscript>
	</cffunction>


	<cffunction access="public" name="doDelete" output="false" returntype="boolean">
		<cfargument name="id" required="yes" type="string">

		<cfhttp url="http://base.google.com/base/feeds/items/#arguments.id#" method="delete" delimiter="," resolveurl="no" charset="utf-8">
			<cfhttpparam type="header" name="Content-Type" value="application/atom+xml">
            <cfhttpparam type="header" name="Authorization" value="GoogleLogin auth=#getAuthenticationToken()#">
			<cfhttpparam type="header" name="X-Google-Key" value="key=#variables.constant.DEVELOPER_KEY#">
		</cfhttp>
		<cfscript>
			result = false;
			if ( cfhttp.statusCode eq 200 ) {
				result = true;
			}
			return result;
		</cfscript>
	</cffunction>


	<cffunction access="public" name="createItem" output="false" returntype="string">
		<cfargument name="type" required="yes" type="string" >
        <cfargument name="title" required="yes" type="string">
		<cfargument name="content" required="no" type="string">

		<cfoutput><cfsavecontent variable="myXML"><?xml version="1.0" encoding="iso-8859-1"?>
		<entry xmlns='http://www.w3.org/2005/Atom' xmlns:g='http://base.google.com/ns/1.0'>
			<author>
				<name>www.clickfind.com.au</name>
				<email>base.google.com@clickfind.com.au</email>
			</author>
			<category scheme='http://base.google.com/categories/itemtypes' term='#arguments.type#'/>
			<g:item_type type='text'>#arguments.type#</g:item_type>
			<g:item_language type="text">en</g:item_language>
			<title type='text'>#arguments.title#</title>
			<cfif structKeyExists( arguments, "content" ) >
			<content type='xhtml'>#arguments.content#</content>
			</cfif>
		</entry></cfsavecontent></cfoutput>
		<cfscript>
			return variables.myXML;
		</cfscript>

	</cffunction>
    
    <cffunction access="public" name="createSingleJobItem" output="false" returntype="string">
		<cfargument name="type" required="yes" type="string" default="googlebase.item">
        <cfargument name="title" required="yes" type="string">
		<cfargument name="content" required="no" type="string">
        <cfset var publishdate = dateformat(now(),"yyyy-mm-dd")>

		<cfoutput><cfsavecontent variable="myXML"><?xml version="1.0"?>
                <rss version="2.0">
                <channel>
                <xmlns:g="http://base.google.com/ns/1.0">
                <title>TheJobFool Jobs</title>
                <link>http://thejobfool.com/postjobs/</link>
                <description>Job Listing for the Jobfool.com</description>
                <item>
                <g:id>jf-test-01</g:id>
                <title>HR Writer - Telecommuting</title>
                <link>http://thejobfool.com/jobs/details.cfm</link>
                <description>We have an immediate need for an experienced HR professional.
                The ideal candidate has a proven record of writing HR articles for career blogs.</description>
                <g:job_function>Writer</g:job_function>
                <g:employer>TheJobFool</g:employer>
                <g:location>1600 Anywhere Parkway, Anywhere City, FL, 94043, USA</g:location>
                <g:publish_date>2010-08-22</g:publish_date>
                <g:expiration_date>2010-09-01</g:expiration_date>
                <g:salary></g:salary>
                </item>
                </channel>
                </rss></cfsavecontent></cfoutput>              
		<cfscript>
			return variables.myXML;
		</cfscript>

	</cffunction>
    
    
</cfcomponent>