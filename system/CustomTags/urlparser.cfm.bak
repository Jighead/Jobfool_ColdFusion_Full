<cfset request.true_query_string = cgi.query_string>
<cfif cgi.script_name contains "view.cfm"><cfexit></cfif>
<cfif structKeyExists(url,"SES") and SES eq "no"><cfexit></cfif>
<cfparam name="request.query_string" default="">
<cfsilent>
<cfif ListLast(CGI.PATH_INFO,".") NEQ "cfm">
  <cfif Find(".cfm",CGI.PATH_INFO)>
      <cfset lenRHSofDotCFM = Len(CGI.PATH_INFO) - (Find(".cfm",CGI.PATH_INFO)+4)>
  <cfelse>
      <cfset lenRHSofDotCFM = Len(CGI.PATH_INFO)>
  </cfif>
  <cfif lenRHSofDotCFM GT 0>
      <cfset RHSofDotCFM = Right( CGI.PATH_INFO, lenRHSofDotCFM )>
      <cfset numURLItems = listLen(RHSofDotCFM,'/')>
      <cfset numURLItems = numURLItems - (numURLItems mod 2)>
      <cfloop from="1" to="#numURLItems#" index="i" step="2">
          <cfset URL[ GetToken(RHSofDotCFM,i,'/') ] = GetToken(lcase(RHSofDotCFM),i+1,'/')>
      </cfloop>
  </cfif>
</cfif>




<cfif len(cgi.query_string) and cgi.query_string contains "=">

	<cfset qstring=reReplaceNoCase(cgi.query_string, "[=?&]", "/", "all")>
	<cfheader statuscode="301" statustext="Moved permanently"><!--- good seo to use 301 redirect --->
	<cflocation url="#lcase(cgi.script_name)#/#lcase(qstring)#" addtoken="no"><!--- good seo to use consistent case --->
</cfif> 


<!--- rebuild the cgi.query_string from a SEO url 
<cfif ListLast(CGI.PATH_INFO,".") NEQ "cfm">
  <cfif Find(".cfm",CGI.PATH_INFO)>
      <cfset lenRHSofDotCFM = Len(CGI.PATH_INFO) - (Find(".cfm",CGI.PATH_INFO)+4)>
  </cfif>
  <cfif lenRHSofDotCFM gt 0>
  <cfset qstring = RHSofDotCFM>
  <cfset qstring = replaceNocase(qstring,"/","?","one")>
  <cfset numURLItems = listLen(qstring,'/')>
  <cfset numURLItems = numURLItems - (numURLItems mod 2)>
	  <cfloop from="1" to="#numURLItems#" index="i">
	  <cfif (#i# MOD 2)>
          <cfset qstring = replaceNoCase(qstring, "/", "=", "one") >
	  <cfelse>
          <cfset qstring = replaceNoCase(qstring, "/", "&", "one") >
	  </cfif>
      </cfloop>
  </cfif>
</cfif>
--->
</cfsilent>