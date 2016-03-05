

<cfcomponent>

	<cfset variables.q = "">
    <cfset variables.L ="">
    <cfset variables.emp ="">
    <cfset variables.co ="US">
    <cfset variables.qt = "10">
    <cfset variables.st = "">
    <cfset variables.sr = "">
    <cfset variables.salary = "">
	<cfset variables.prev = "">
	<cfset variables.next = "">
    <cfset variables.radius = "25">
    <cfset variables.fromage= "last">
    <cfset variables.sort= "date">
    <cfset variables.totalrecords = "">
	<cfset variables.pages = "">
	<cfset variables.columlist = "">
    <!---
    <cfset idlist= "4939942668444045,6914058027253227,9233642206201763">
	--->
     <cfset idlist= "2059896800093889,2212206290584495,3309688785061266,3312850746006621,3309688785061266,372305085978393,5656845852938153,5168306077281773,6528880794256046,6154595114685817,6071782746005453,6714344422997823,7201994216806632,7570038743238473,8585468389033276,1374356781191054,1427894191964400,736978321997537,4957686695268887,6914058027253227,9233642206201763,9628233567417007,9689206135006168,9284102052512106">
<cfset objRandom=ArrayNew(1)>
<cfset objRandom=ListToArray(idlist)>
<cfset arraylen = ArrayLen(objRandom)>
<!--- <cfset ArraySort(objRandom,"textnocase","ASC")> --->
<!--- random number b/n 1 and length of list/array --->
<cfset randpubid=objRandom[RandRange(1, arraylen, "SHA1PRNG")]>
<!---  <cfoutput><a href="http://api.indeed.com/ads/apisearch?publisher=#randpubid#&v=2&q=sales&l=chicago&st=&start=1&limit=20">#pubid#</a></cfoutput> --->
    
    
    <cfset variables.publisher = randpubid>

	<cffunction name="getJobs" access="public" output="false" returntype="query" hint="I make a cfhttp query call to indeed API for jobs, parse the XML, format it and return it as a query.">
    
        <cfargument name="kw" required="no" default="sales" hint="keyword search string">
        <cfargument name="L" required="yes" default="">
        <cfargument name="co" required="yes" default="US">
        <cfargument name="emp" required="no" default="">
        <cfargument name="qt" required="no" default="10" hint="max results per page">
        <cfargument name="st" required="no" default="" hint="Job Site type">
        <cfargument name="salary" required="no" default="" hint="">
        <cfargument name="start" required="no" default="1" hint="start at record">
        <cfargument name="p" required="no" default="1" hint="pageumber to calc start record from.">
        <cfargument name="radius" required="no" default="25" hint="radius from location">
        <cfargument name="fromage" required="no" default ="30" hint="How many days back to search">
        <cfargument name="sb" required="no" default ="relevance" hint="relevance or date">
        <cfargument name="rbc" required="no" default ="30" hint="employer name - used in como with jcid">
        <cfargument name="jcid" required="no" default ="30" hint="employerid used to identify employer">
        <cfargument name="filter" required="no" default="1" hint="filter duplicates 1 or 0">
        <cfargument name="orderby" required="yes" default="Publish_date DESC" hint="query sort order">
        
		<cfscript>
        var XML = "";
        var rawXML = "";
        var q = arguments.kw;
        variables.L = arguments.L;
        variables.qt = arguments.qt;
        variables.radius = arguments.radius;
        variables.co = arguments.co;
		variables.sb = arguments.sb;
        </cfscript>
        
		
	<cfif arguments.kw eq "enter+keyword" or arguments.KW is ""><cfset arguments.KW = "in"></cfif>
	
	
	<cfif isdefined('arguments.kw') and len(arguments.kw)>
		<cfset arguments.kw = Replace(arguments.kw, "*", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "(", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, ")", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "@", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "/", " ", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "[", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "]", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "^", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "`", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "~", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "!", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "=", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "-", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "|", "", "ALL")>
		<cfset arguments.kw = Replace(arguments.kw, "$", "", "ALL")>
	
		<cfset variables.q = "#lcase(trim(arguments.kw))#">
	<cfelse>
		<cfset variables.q = "sales">
	</cfif>
    
     <cfif isDefined('arguments.kw') and arguments.kw contains "emp:">
        <cfset variables.emp = replacenocase(arguments.kw,"emp:","")>
		<cfset variables.q = "company:#variables.emp#">
        <cfset variables.st = "employer">
	</cfif>
    
    <cfif isDefined('arguments.salary') and arguments.salary gt 10000>
    	<cfset variables.salary = arguments.salary>
    </cfif>
    
    <cfif isDefined('arguments.emp') and arguments.emp gt 2>
		<cfset variables.q = "company:#arguments.emp#">
        <cfset variables.st = "employer">
        <cfset variables.sr = "directhire">
	</cfif>
    <cfif isDefined('arguments.fromage')>
		<cfset variables.fromage = arguments.fromage>
	</cfif>
    
	<cfif isDefined('arguments.p') and arguments.p gt 1>
		<cfset variables.start = (arguments.p * arguments.qt) - arguments.qt +1>
	<cfelse>
		<cfset variables.start = 1>
	</cfif>
    
<cfif variables.q contains "company:">
<cfset link="http://api.indeed.com/ads/apisearch?publisher=#variables.publisher#&v=2&q=#variables.q#&l=#variables.l#&sr=directhire&st=employer&limit=#variables.qt#&start=#variables.start#&fromage=#variables.fromage#&co=#variables.co#&salary=#variables.salary#&sort=#variables.sb#&filter=1&userip=#cgi.REMOTE_ADDR#&useragent=#cgi.HTTP_USER_AGENT#">
<cfelse>

<cfset link="http://api.indeed.com/ads/apisearch?publisher=#variables.publisher#&v=2&q=#variables.q#&l=#variables.l#&st=#variables.st#&start=#variables.start#&limit=#variables.qt#&fromage=#variables.fromage#&salary=#variables.salary#&sort=#variables.sb#&filter=1&latlong=1&co=#variables.co#&chnl=&radius=#variables.radius#&filter=1&userip=#cgi.REMOTE_ADDR#&useragent=#cgi.HTTP_USER_AGENT#">
</cfif>

	<!--- testing stuff --->
	<cfif isDefined('url.test') and url.test is "1">

			<!--- Paramaters available for Indeed...
            st = Site type. To show only jobs from job boards use 'jobsite'. For jobs from direct employer websites use 'employer'
            start = Start results at this result number, beginning with 0. Default is 0. 
            fromage = Number of days back to search. 
            filter = Filter duplicate results. 0 turns off duplicate job filtering. Default is 1. 
            --->
            <a href="#link#"><cfoutput>#link#</cfoutput></a>
            <cfhttp method="get" url="#link#">
            <br><br>
            <cfdump var="#cfhttp.filecontent#">
            <cfabort>
	</cfif>
	
<cfhttp method="get" url="#link#"> 

<!--- if bad request create and return blank query --->
<cfif cfhttp.statuscode does not contain "200">
	<cfset qrydata = createNewQuery()>
	<cfreturn qrydata>
	<cfexit>
</cfif>

	<!---  parse the raw XML into CF usable struct --->
	<cfset XML = xmlparse(cfhttp.filecontent)>
  
<cfif not isdefined("xml.response.results.result")>
	<cfset qrydata = createNewQuery()>
	<cfreturn qrydata>
	<cfexit>
</cfif>

<!--- if nothing returned from indeed  --->
<cfif xml.response.totalresults.xmltext is "0">
	<cfset qrydata = createNewQuery()>
	<cfreturn qrydata>
	<cfexit>
</cfif>


	<cfif isdefined("xml.response.results") and #arraylen(xml.response.results.result)# gt 0>
  
		<!--- CONVERT THE PARSED XML ARRAY INTO A COLDFUSION QUERY --->
        <cfset qryData = XML2Query(xml=#xml#,orderby=#arguments.orderby#)>
		
		<cfif isDefined('url.test') and url.test is "2">
			<br><cfdump var =#qrydata#><cfabort>
		</cfif>
     
		<cfset request.totalresults = #xml.response.totalresults.xmltext#>
        <!--- <cfset request.Grecords = qrydata.recordcount> --->
        

        <cfif request.totalresults GTE 1000>
            <!--- <cfset variables.totalrecords = 1000> --->
            <cfset variables.totalrecords = request.totalresults>
        <cfelse>
            <cfset variables.totalrecords = request.totalresults>
        </cfif>
        
        <cfset request.totalrecords = variables.totalrecords>
   	
	<cfelse>
	<!--- no data returned from indeed, show message --->
		<cfset qryData = querynew("title")>
	</cfif>
    
	<cfreturn qryData>
	</cffunction>
    
	<cffunction name="createNewQuery" access="public" output="false" returntype="query" 
	hint="I create/initilize a 1 row query to to force datatyping ">	
		<cfset var myquery = "">
		<cfset var typelist = "">
		<cfset var str = "">
		<cfset var date = "">
 
		<!--- ad your column names --->
		<cfset columnlist = "title,source,city,state,country,location,employer,publish_date,description,uri,link,jobid,publisheddisplay,latitude,longitude,sponsored">
		<!--- seupt datatypes for our columns --->
		<cfset typelist = "str,str,str,str,str,str,str,str,str,str,str,str,str,str,str,str">
		<cfset str = "">
		<cfset date = Now()>
        
     	<cfset myquery = querynew("#columnlist#")>
		<!--- Put values in to the first row to establish column datatypes and avoid query of query runtime errors --->
		<cfset QueryAddRow(myquery,1)> 
		<cfloop from = 1 to = "#ListLen(ColumnList)#" index="i">
		<cfset QuerySetCell(myquery,ListGetAt(ColumnList,i),evaluate(ListGetAt(TypeList,i)),1)>
		</cfloop>
		<!--- Force Define the datatype in the query --->
		<cfquery name="rquery" dbType="query">
		SELECT *
		FROM myquery
		WHERE 1 <> 1
		</cfquery>
		<cfreturn myquery>
	</cffunction>
	
	
 	
	<cffunction name="xml2Query" access="public" output="true" hint="I convert the goolglebase XML to a memory query">
		<cfargument name="XML" required="yes" hint="valid XML">
		<cfargument name="queryname" required="no" hint="">
		<cfargument name="orderby" required="yes" default="Publish_date DESC" hint="query sort order">
		
		<cfset var exclude = "">
        <cfset var size = "">
        <cfset var myquery = "">
        
        <!--- create a new query which sets one row to force datayping for columns --->
		<cfif not isDefined('arguments.queryname')>
			<cfset myquery= createNewQuery()>
		</cfif>
 
    	<!--- create a query object from the XML data --->
    	<cfset size = arraylen(xml.response.results.result)>
 		
		<!--- Now add XML data to our query --->
		<cftry>
    	<cfset queryaddrow(myquery, size)>

		<cfloop from="1" to="#size#" index="i">  
        
        
			 <cfif structkeyexists(xml.response.results.result[i], "jobtitle")>
            
                        <cfif structkeyexists(xml.response.results.result[i], "jobkey")>
                        	<cfset jobid = xml.response.results.result[i].jobkey.xmltext>
                            <cfset querysetcell(myquery, "jobid", jobid, i)>				
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "url")>
                      
    
						<cfset querysetcell(myquery, "uri", xml.response.results.result[i].url.xmltext, i)>
 						<cfset link = "/jobs/view.cfm?do=1&amp;jobid=" & xml.response.results.result[i].jobkey.xmltext>
                        <cfset querysetcell(myquery, "link", link, i)>
                        
                         
                        </cfif>
                        

                        <cfif structkeyexists(xml.response.results.result[i], "jobtitle")>
                            <cfset querysetcell(myquery, "title",  xml.response.results.result[i].jobtitle.xmltext, i)>
                            <cfif not len(xml.response.results.result[i].jobtitle.xmltext)>
                            <cfset querysetcell(myquery, "title",  " ", i)>
                            </cfif>
                        </cfif>

                        <cfif structkeyexists(xml.response.results.result[i], "snippet")>
                            <cfset querysetcell(myquery, "description",xml.response.results.result[i].snippet.xmltext, i)>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "formattedLocationFull")>
                            <cfset querysetcell(myquery, "location",#trim(xml.response.results.result[i].formattedLocationFull.xmltext)#, i)>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "city")>
                            <cfset querysetcell(myquery, "city",#trim(xml.response.results.result[i].city.xmltext)#, i)>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "state")>
                            <cfset querysetcell(myquery, "state",#trim(xml.response.results.result[i].state.xmltext)#, i)>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "country")>
                            <cfset querysetcell(myquery, "country",#trim(xml.response.results.result[i].country.xmltext)#, i)>
                        </cfif>
                        
                        
                        <cfif structkeyexists(xml.response.results.result[i], "source")>
                            <cfset querysetcell(myquery, "source",  xml.response.results.result[i].source.xmltext, i)>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "company")>
                            <cfset querysetcell(myquery, "employer",  xml.response.results.result[i].company.xmltext, i)>
                        </cfif>
                        
                        
                        <cfif structkeyexists(xml.response.results.result[i], "date")>
                            <cfset querysetcell(myquery, "publish_date",  xml.response.results.result[i].date.xmltext, i)>
                        </cfif>
                        
                        
                        <cfif structkeyexists(xml.response.results.result[i], "formattedRelativeTime")>
                         <cfset published = xml.response.results.result[i].formattedRelativetime.xmltext>
                         <cfset querysetcell(myquery, "publisheddisplay",  "#published#", i)>
                        </cfif>
                        
                         <cfif structkeyexists(xml.response.results.result[i], "latitude")>
                            <cfset querysetcell(myquery, "latitude",  xml.response.results.result[i].latitude.xmltext, i)>
                         <cfelse>
                         	<cfset querysetcell(myquery, "latitude",  "0")>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "longitude")>
                            <cfset querysetcell(myquery, "longitude",  xml.response.results.result[i].longitude.xmltext, i)>
                        <cfelse>
                            <cfset querysetcell(myquery, "longitude",  "0")>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "sponsored")>
                            <cfset querysetcell(myquery, "sponsored",  xml.response.results.result[i].sponsored.xmltext, i)>
                        </cfif>
                        
            </cfif>
            
		</cfloop>

			<cfcatch>
            <cfif isdefined('cfcatch')>
				<cfmail to="jobfool@gmail.com" from="CriticalError@thejobfool.com" subject="Error in components.getjobs.xml2query">
				<cfdump var="#cfcatch#">
				</cfmail>
            </cfif>
			</cfcatch> 
		</cftry>
        
		<cfif myquery.RecordCount gt 1> 
            <cftry>		
                <cfquery dbtype="query" name="Rquery">
                select #variables.columnlist#
                from myquery
                where link is not null
                <cfif arguments.orderby NEQ "none">
                order by #arguments.orderby#
                </cfif>
                </cfquery>	
            <cfcatch type="any">	
    
                <cfdump var="#error#">
                <cfdump var="#cfcatch#"><cfabort>
    
            </cfcatch>
           </cftry>	  
        </cfif>
        
		<cfreturn  Rquery>
	</cffunction>
	
	<!--- =============== SubQueries (filters) start here =============== --->
	<cffunction name="getLocations" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="locations">
            select distinct(location) as location
			from myquery
            where location is not NULL
			group by location
      </cfquery>
	</cfif>
	<cfreturn locations>
	</cffunction>
	
<!--- 	<cffunction name="getZips" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="zips">
            select distinct(zip)
			from myquery
            where zip is not Null
			group by zip
			order by zip asc
      </cfquery>
	</cfif>
	<cfreturn zips>
	</cffunction> --->
	
	
<!--- 	<cffunction name="getJobType" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="jobType">
            select distinct(job_type)
			from myquery
            where job_type is not NULL
			group by job_type
      </cfquery>
	</cfif>
	<cfreturn jobType>
	</cffunction> --->
	
<!--- 	<cffunction name="getJobFunction" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="jobFunction">
            select distinct(job_function) 
			from myquery
            where job_function is not NULL
			group by job_function
			order by job_function
      </cfquery>
	</cfif>
	<cfreturn jobFunction>
	</cffunction> --->
	
    
<!---     <cffunction name="getJobIndustry" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="jobIndustry">
            select distinct(job_Industry)
			from myquery
            where job_Industry is not NULL
			group by job_Industry
			order by job_industry
      </cfquery>
	</cfif>
	<cfreturn jobIndustry>
	</cffunction> --->
	
 	<cffunction name="getSource" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="source">
            select distinct(source) 
			from myquery
            where source is not NULL
			group by source
			order by source asc
      </cfquery>
	</cfif>
	<cfreturn source>
	</cffunction>
	

<cffunction name="getEmployers" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="employer">
            select distinct(employer)  
			from myquery
            where employer is not NULL
			group by employer
			order by employer asc
      </cfquery>
	</cfif>
	<cfreturn employer>
</cffunction>
	
	
<!--- 	<cffunction name="getSalarys" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="employer">
            select salary, title, location
			from myquery
            where salary is not NULL
      </cfquery>
	</cfif>
	<cfreturn employer>
	</cffunction> --->
	
	
	<cffunction name="getDescription" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="desc" maxrows="1">
            select title, description 
			from myquery
            where description is not NULL
            order by publish_date desc
      </cfquery>
	</cfif>
    
    <cfdump var="#desc#">
	<cfreturn desc>
	</cffunction>
	
	  
    
	
	<cffunction name="parseURL" access="public" returntype="void" hint="Used on any page that uses seo urls">
	<cfscript> 
	// search engine friendly url script: parses /character back to ? & characters
	// Create links this way http://www.domain.com/page.cfm/var1/value1/var2/value2/
	   debug = 0;
	   valid_extensions = "html,htm,cfm,asp,jsp";
	   url_suffix = ".html";
	   path_to_parse = replacenocase(cgi.path_info, cgi.script_name, ""); 
	   if (listlen(path_to_parse, "/") gte 2) {
		  var_name = "";
		  for (x = 1; x lte listlen(path_to_parse, "/"); x = x + 1) {
		  if (var_name eq "") {
			 var_name = trim(listgetat(path_to_parse, x, "/"));
			 if (not refind("^[A-Za-z][A-Za-z0-9_]*$", var_name)) {
				var_name = "";
				x = x + 1;
			 }
		  } 
		  else {
			   value_to_set = listgetat(path_to_parse, x, "/");
			   if (trim(valid_extensions) neq "" and x eq listlen(path_to_parse, "/")) {
				   for (ext = 1; ext lte listlen(valid_extensions); ext = ext + 1) {
						 extension = "." & listgetat(valid_extensions, ext);
						 if (right(value_to_set, len(extension)) eq extension) {
							  value_to_set = left(value_to_set, len(value_to_set) - len(extension));
							  url_suffix = extension;
							  break;
						 }
				}
		  }
	  setvariable(var_name, value_to_set);
	  if (isdefined("debug") and debug) {
		 writeoutput("<!-- " & var_name & " = " & value_to_set & " -->" & chr(10));
	  }
	  var_name = "";
	  }
	 }
	}
	</cfscript>
	</cffunction>
	
	
	<cffunction name="excludecheck" access="private" returntype="boolean" hint="I exclude unwanted urls">
	<cfargument name="link" type="string" required="no" default="NULL" hint="a url">
	<cfset var excludelist = "">

	
	<cfset sourcelink = replace(arguments.link, "http://", "", "One")>
	<cfset sourcelink = replace(sourcelink, "https://", "", "One")>
	<cfset sourcelink = replace(sourcelink, "www.", "", "One")>
	<cfset sourcelink = gettoken(sourcelink,1,"/")>
	
	<cfset excludelist="gadball.com,workcircle.com,workcircle.co.uk,workcircle.us,jobs2web.com">
	
	<cfif listcontains(excludelist,"#sourcelink#")>
		<cfreturn true>
	</cfif>
	
	<cfreturn false>
	</cffunction>
	
	

	<cffunction name="logSearch" access="public" hint="I log search terms">
        <cfargument name="kw" type="string" required="no" default="NULL" hint="job description or keywords">
        <cfargument name="l" type="string" required="no" default="NULL" hint="location">
	</cffunction>
	
	
	<cffunction name="getJob" access="public" output="true" returntype="struct" hint="I make a cfhttp query call to Indeed for a single job and parse the XML, format it and return it as a string variable.">
        <cfargument name="jobid" required="yes" default="0" hint="unique job id provide by google">
    
        <cfset var jobData = structNew()>
        <cfset var rawXML = "">
        <cfset var XML = "">
        <cfset var link = "">
    
		<cfset link = "http://api.indeed.com/ads/apigetjobs?publisher=#variables.publisher#&jobkeys=#arguments.jobid#&v=2">
       
		
		<cfif isDefined('url.test')>
            <cfhttp method="get" url="#link#">
            <cfdump var="#cfhttp.filecontent#"><cfabort>
        </cfif>
            
        <cfhttp method="get" url="#link#">
        

        
        <!--- if bad request create and return blank query --->
        <cfif cfhttp.statuscode does not contain "200">
            <cfset jobdata = structNew()>
            <cfset jobdata.recordcount = 0>
            <cfreturn jobdata>
            <cfexit>
        </cfif>

	<!---  parse the raw XML into CF usable struct --->
	<cfset XML= xmlparse(cfhttp.filecontent)>
    
   
        <cfif isdefined("xml.response.results.result.jobtitle") and arraylen(xml.response.results.result) eq 1>

            <cfset jobdata = structNew()>
                       
                        <cfif structkeyexists(xml.response.results.result, "jobkey")>
                            <cfset jobdata.jobid = xml.response.results.result.jobkey.xmltext>				
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "url")> 
                          <cfset jobdata.link = "/jobs/view.cfm?do=1&jobid=" & arguments.jobid> 
                        <!---  <cfset jobdata.link = xml.response.results.result.url.xmltext> --->
                        </cfif>
                        
                      <cfif structkeyexists(xml.response.results.result, "jobtitle")>
                            <cfset jobdata.title = xml.response.results.result.jobtitle.xmltext>
                        </cfif>

                        <cfif structkeyexists(xml.response.results.result, "snippet")>
                            <cfset jobdata.description = xml.response.results.result.snippet.xmltext>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "formattedLocationFull")>
                            <cfset jobdata.location = xml.response.results.result.formattedLocationFull.xmltext>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "city")>
                            <cfset jobdata.city = xml.response.results.result.city.xmltext>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "state")>
                            <cfset jobdata.state = xml.response.results.result.state.xmltext>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "country")>
                            <cfset jobdata.country = xml.response.results.result.country.xmltext>
                            <cfif jobdata.country eq "GB"><cfset jobdata.country = "United Kingdom"></cfif>
                        </cfif>
                        
                        
                        <cfif structkeyexists(xml.response.results.result, "source")>
                            <cfset jobdata.source = xml.response.results.result.source.xmltext>
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "company")>
                            <cfset jobdata.employer = xml.response.results.result.company.xmltext>
                            <cfif jobdata.employer is "">
                            	<cfset jobdata.employer = "N/A">
                            </cfif>
                        </cfif>
                        
                        
                        <cfif structkeyexists(xml.response.results.result, "date")>
                            <cfset jobdata.published = xml.response.results.result.date.xmltext>
                        </cfif>
                        
                        
                        <cfif structkeyexists(xml.response.results.result, "formattedRelativeTime")>
                         <cfset jobdata.publisheddisplay = xml.response.results.result.formattedRelativetime.xmltext>
                        </cfif>
                        
                         <cfif structkeyexists(xml.response.results.result, "latitude")>
                            <cfset jobdata.latitude = xml.response.results.result.latitude.xmltext>
                         <cfelse>
                         	<cfset jobdata.latitude = "0">
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "longitude")>
                            <cfset jobdata.longitude = xml.response.results.result.longitude.xmltext>
                        <cfelse>
                            <cfset jobdata.longitude = "0">
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result, "sponsored")>
                            <cfset jobdata.sponsored =  xml.response.results.result.sponsored.xmltext>
                        </cfif>
                        
                        
        <cfset jobdata.recordcount = 1>
        <cfset request.totalrecords = 1>
   	
	<cfelse>
	<!--- no data returned from google base, show message --->
		<cfset jobdata.recordcount = 0>
	</cfif>
    
    
	<cfreturn jobdata>
    
	</cffunction>
</cfcomponent>