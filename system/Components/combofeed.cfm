<cfparam name="url.kw" default="job">
<cfparam name="url.l" default="">
<cfparam name="variables.st" default="1">
<cfparam name="variables.qt" default="10">
<cfparam name="variables.fromage" default="10">

<cfset variables.l = url.l>
<cfset variables.q = url.kw>
<cfset variables.bq = url.kw>

<cfobject name="application.indeed" component="#request.componentpath#.GoogleIndeedJobs"> 
<cfset feed = application.indeed.getJobs(argumentcollection=#url#)>
<cfdump var="#feed#" label="Combined XML"><cfabort>

<!--- <cfset link="http://api.indeed.com/ads/apisearch?publisher=7261948035881192&v=2&q=#variables.q#&l=#variables.l#&st=&start=#variables.st#&limit=#variables.qt#&fromage=#variables.fromage#&filter=1&latlong=1&chnl=&userip=#cgi.REMOTE_ADDR#&useragent=#cgi.HTTP_USER_AGENT#">



<cfhttp method="get" url="#link#">
<cfset XML1 = xmlparse(cfhttp.filecontent)>

<cfhttp method="get" url="http://www.google.com/base/feeds/snippets/-/jobs?#variables.bq#max-results=#variables.qt#&start-index=#variables.st#">
 
  <!--- coldfusion yells at us if we use : so we need to remove them --->
  <cfset rawXML=#replaceNoCase(cfhttp.filecontent, "g:", "", "all")#>
  <cfset rawXML=#replaceNoCase(rawXML, "openSearch:", "", "all")#>
  <!---  parse the raw XML into CF usable struct --->
  <cfset XML2 = xmlparse(rawXML)>
  
  <cfset xml = xml1 &''& xml2>
  
  <cfdump var="#xml#"> --->
