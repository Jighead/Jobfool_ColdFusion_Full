<cfcomponent>

	<cfset variables.kw = "">
    <cfset variables.l ="">
    <cfset variables.qt = "">
    <cfset variables.st = "">
	<cfset variables.prev = "">
	<cfset variables.next = "">
    <cfset variables.radius = "">
    <cfset variables.GBtotalrecords = "">
    <cfset variables.totalrecords = "">
	<cfset variables.pages = "">
	<cfset variables.columlist = "">
    
    
    <cffunction name="getJobs" access="public" output="true" returntype="any" hint="I make a cfhttp query call to googlebase for jobs parse the XML format it and return it  as a string variable.">
    
    <cfargument name="kw" required="no" default="sales" hint="keyword search string">
	<cfargument name="l" required="yes" default="USA">
	<cfargument name="qt" required="no" default="20" hint="max results per page">
	<cfargument name="st" required="no" default="1" hint="start at record no.">
	<cfargument name="p" required="no" default="1" hint="pageumber to calc start record from.">
	<cfargument name="radius" required="no" default="50" hint="radius from location">
	<cfargument name="emp" required="no" hint="employer search attibute for job function">
	<cfargument name="jf" required="no" hint="job function search attibute for job function">
	<cfargument name="jt" required="no" hint="job type search attibute for job type">
	<cfargument name="ji" required="no" hint="job industry search attibute for job industry">
    <cfargument name="link" required="no" hint="source search attibute for specific providers 'monster.com'">
	<cfargument name="salary" required="no" hint="salary search attibute for salary">
	<cfargument name="days" required="no" hint="search attibute for published">
	<cfargument name="sb" required="no" default="relevancy" hint="search attibute for sort by">
    
    <cfset xml1 = getGoogleJobs(argumentcollection=arguments)>
    <cfset xml2 = getIndeedJobs(argumentcollection=arguments)>
    
    <!--- combine our feeds --->
    <cfset rawXML = xml1 &''& xml2>
    <cfset XML = xmlparse(rawxml)>
<!--- 	<!--- initialize/create an empty 1 row query --->
    <cfset qrydata = createNewQuery()>
    <!--- populate the query with the xml data --->
    <cfset qryData = XML2Query(#XML#)> --->

    <cfreturn XML>
    </cffunction>
       
	
	<cffunction name="getGoogleJobs" access="public" output="true" returntype="any" hint="I make a cfhttp query call to googlebase for jobs parse the XML format it and return it  as a string variable.">
	<cfargument name="kw" required="no" default="sales" hint="keyword search string">
	<cfargument name="l" required="yes" default="USA">
	<cfargument name="qt" required="no" default="20" hint="max results per page">
	<cfargument name="st" required="no" default="1" hint="start at record no.">
	<cfargument name="p" required="no" default="1" hint="pageumber to calc start record from.">
	<cfargument name="radius" required="no" default="50" hint="radius from location">
	<cfargument name="emp" required="no" hint="employer search attibute for job function">
	<cfargument name="jf" required="no" hint="job function search attibute for job function">
	<cfargument name="jt" required="no" hint="job type search attibute for job type">
	<cfargument name="ji" required="no" hint="job industry search attibute for job industry">
    <cfargument name="link" required="no" hint="source search attibute for specific providers 'monster.com'">
	<cfargument name="salary" required="no" hint="salary search attibute for salary">
	<cfargument name="days" required="no" hint="search attibute for published">
	<cfargument name="sb" required="no" default="relevancy" hint="search attibute for sort by">
	
    <cfset var rawXML = "">
	<cfset var XML = "">
		
	<cfif arguments.kw eq "enter+keyword" or arguments.KW is ""><cfset arguments.KW = "in"></cfif>

    <!--- our setters --->
	<cfscript>
	variables.kw = arguments.kw;
	variables.q = "";
	variables.bq = "bq=";
	variables.L = arguments.L;
	variables.qt = arguments.qt;
	variables.radius = arguments.radius;
	variables.sb = arguments.sb; //sort by 
	</cfscript>
	
	
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
	
		<cfset variables.q = "q=#lcase(trim(arguments.kw))#&">
        <cfset variables.kw = "[title:#trim(arguments.kw)#][description:#trim(arguments.kw)#]">
        
        <!--- If this is an employer search without keyword --->   
        <cfif isdefined('arguments.emp') and len(arguments.emp)>
    		<cfif arguments.kw eq 'job'><cfset variables.kw = ""></cfif>
            <cfset variables.bq = variables.bq>
        <cfelse>
        	<cfset variables.bq = variables.bq &''& variables.kw>
        </cfif>
        <!--- --------------------------------------------- --->
        
        
	<cfelse>
		<cfset variables.bq = variables.bq>
	</cfif>
	
	<cfif isdefined('arguments.jf')>
		<cfset arguments.jf = #replace(arguments.jf, "-", "", "all")#>
		<cfset arguments.jf = #replace(arguments.jf, "?", "", "all")#>
		<cfset arguments.jf = reReplace(arguments.jf, "[0-9]K", "", "all")>
		<cfset arguments.jf = reReplace(arguments.jf, "[0-9]+", "", "all")>
		<cfset variables.jf = urlencodedFormat('[job_function: #trim(arguments.jf)#]')>
		<cfif len(trim(arguments.jf))>
		<cfset variables.bq = variables.bq &''& variables.jf>
		</cfif>
	</cfif>
	<cfif isdefined('arguments.emp') and len(arguments.emp)>
	<cfset arguments.emp = #replace(arguments.emp, "-", " ", "all")#>
		<cfset variables.emp = '[employer: #arguments.emp#]'>
		<cfset variables.bq = variables.bq &''& variables.emp>
	</cfif>
	<cfif isdefined('arguments.jt') and len(arguments.jt)>
	<cfset arguments.jt = #replace(arguments.jt, "-", " ", "all")#>
		<cfset variables.jt = '[job_type: #arguments.jt#]'>
		<cfset variables.bq = variables.bq &''& variables.jt>
	</cfif>
	<cfif isdefined('arguments.ji') and len(arguments.ji)>
		<cfset arguments.ji = #replace(arguments.ji, "-", "", "all")#>
		<cfset arguments.ji = #replace(arguments.ji, "  ", " ", "all")#>
		<cfset variables.ji = urlencodedformat ('[job_industry: #arguments.ji#]')>
		<cfset variables.bq = variables.bq &''& variables.ji>
	</cfif>
	
	<cfif isdefined('arguments.link') and len(arguments.link)>
		<cfset arguments.link = replace(arguments.link, "!", "", "all")>
		<cfset arguments.link = replace(arguments.link, ".com", "", "all")>
		<cfset arguments.link = replace(arguments.link, ".net", "", "all")>
		<cfset arguments.link = replace(arguments.link, ".org", "", "all")>
		<cfset arguments.link = replace(arguments.link, ".", " ", "all")>
		<cfset variables.link = urlencodedformat ('[link: #arguments.link#]')>
		<cfset variables.bq = variables.bq &''& variables.link>
	</cfif>
	
	<cfif isdefined('arguments.salary') and len(arguments.salary)>
		<cfset variables.salary = urlencodedformat('[salary >= #arguments.salary#]')>
		<cfset variables.bq = variables.bq &''& variables.salary>
	</cfif>
	
	<cfif isdefined('arguments.days') and len(arguments.days)>
	<cfset from = dateformat(now(), "yyyy-mm-dd")>
	<cfset too = dateFormat(DateAdd("d", -arguments.days, fix(now())), "yyyy-mm-dd")> 
		<cfset variables.days = urlencodedformat('[publish date:2008-03-12Z]')>
		<cfset variables.bq = variables.bq &''& variables.days>
	</cfif>
	
	<cfif len(variables.l)>
		<cfset variables.location = urlencodedformat ('[location:@"#variables.l#" +#variables.radius#mi]')>
		<cfset variables.bq = variables.bq &''& variables.location>
	</cfif>
	
	<cfif isDefined('arguments.p') and arguments.p gt 1>
		<cfset variables.st = (arguments.p * arguments.qt) - arguments.qt +1>
	<cfelse>
		<cfset variables.st = 1>
	</cfif>
	
	<!--- if we have no attributes clear the bq prefix --->
	<cfif variables.bq is "bq=">
		<cfset variables.bq = "">
	<cfelse>
	<cfset variables.bq = variables.bq & "&">
	</cfif>

	<cfif isDefined('url.test')>
	<cfoutput>
	<cfset link="http://www.google.com/base/feeds/snippets/-/jobs?#variables.bq#max-results=#variables.qt#&start-index=#variables.st#&orderby=#arguments.sb#">
	
	<a href="#link#">#urldecode(link)#</a>
	</cfoutput>
	<cfabort>
	</cfif>
	
	
<cfhttp method="get" url="http://www.google.com/base/feeds/snippets/-/jobs?#variables.bq#max-results=#variables.qt#&start-index=#variables.st#&orderby=#arguments.sb#">
	<!--- if bad request create and return blank query --->

	<cfif cfhttp.statuscode contains "200">
    

	<!--- coldfusion yells at us if we use : so we need to remove them --->
	<cfset rawXML=#replaceNoCase(cfhttp.filecontent, "g:", "", "all")#>
	<cfset rawXML=#replaceNoCase(rawXML, "openSearch:", "", "all")#>
	<!---  parse the raw XML into CF usable struct --->
	<cfset XML = xmlparse(rawXML)>
    
      
	<!---
    <cfdump var="#xml#">   
    <cfabort>
    --->	
		 
		<cfif NOT isdefined("XML.feed.entry") and #arraylen(XML.feed.entry)# gt 0>
        <!--- no data returned from google base, show message --->
            <cfset XML = "">
        </cfif>
        

     <cfreturn XML>  
	</cfif>
   
	<cfreturn XML>
</cffunction>
    
	
    
    
 <cffunction name="getIndeedJobs" access="public" output="true" returntype="any" hint="I make a cfhttp query call to indeed API for jobs, parse the XML, format it and return it as a query.">
    
        <cfargument name="kw" required="no" default="sales" hint="keyword search string">
        <cfargument name="L" required="yes" default="">
        <cfargument name="co" required="yes" default="US">
        <cfargument name="emp" required="no" default="">
        <cfargument name="qt" required="no" default="10" hint="max results per page">
        <cfargument name="st" required="no" default="" hint="Job Site type">
        <cfargument name="start" required="no" default="1" hint="start at record">
        <cfargument name="p" required="no" default="1" hint="pageumber to calc start record from.">
        <cfargument name="radius" required="no" default="25" hint="radius from location">
        <cfargument name="fromage" required="no" default ="30" hint="How many days back to search">
        <cfargument name="sort" required="no" default ="relevance" hint="relevance or date">
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
		variables.fromage = "90";
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
	</cfif>
    
    <cfif isDefined('arguments.emp') and arguments.emp gt 2>
		<cfset variables.q = "company:#arguments.emp#">
	</cfif>
	
	<cfif isDefined('arguments.p') and arguments.p gt 1>
		<cfset variables.st = (arguments.p * arguments.qt) - arguments.qt +1>
	<cfelse>
		<cfset variables.st = 1>
	</cfif>
	
<cfset variables.start = variables.st>
<cfif variables.q contains "company:">
<cfset link="http://api.indeed.com/ads/apisearch?publisher=7261948035881192&v=2&q=#variables.q#&limit=#variables.qt#&co=#variables.co#&userip=#cgi.REMOTE_ADDR#&useragent=#cgi.HTTP_USER_AGENT#">
<cfelse>

<cfset link="http://api.indeed.com/ads/apisearch?publisher=7261948035881192&v=2&q=#variables.q#&l=#variables.l#&st=&start=#variables.st#&limit=#variables.qt#&fromage=#variables.fromage#&sort=#sort#&filter=1&latlong=1&co=#variables.co#&chnl=&radius=#variables.radius#&userip=#cgi.REMOTE_ADDR#&useragent=#cgi.HTTP_USER_AGENT#">
</cfif>

	<!--- testing stuff --->
	<cfif isDefined('url.test') and url.test>
            <a href="#link#">#urldecode(link)#</a>
            <cfhttp method="get" url="#link#">
            <br><br>
            <cfdump var="#cfhttp.filecontent#">
            <cfabort>
	</cfif>
	
	<cfhttp method="get" url="#link#">


    
    <!--- if bad request create and return blank query --->
    <cfif cfhttp.statuscode does not contain "200">
	<cfset xml = "">
    <cfreturn XML>
    </cfif>



	<!---  parse the raw XML into CF usable struct --->
	<cfset XML = xmlparse(cfhttp.filecontent)>
  
	<!---  <cfdump var='#xml#'> <cfabort> --->

	<!--- if nothing retured from indeed  --->
    <cfif xml.response.totalresults.xmltext is "0">
        <cfset xml = "">
    </cfif>

    
	<cfreturn XML>
	</cffunction>   
    
    
   

    
    <cffunction name="createNewQuery" access="public" output="false" returntype="query" 
	hint="I create/initilize a 1 row query to to force datatyping ">	
		<cfset var myquery = "">
		<cfset var typelist = "">
		<cfset var str = "">
		<cfset var date = "">
 
		<!--- ad your column names --->
		<cfset columnlist = "jobid,title,link,description,employer,salary,job_function,job_type,location,job_industry,expiration_date,publish_date,	source,sourcelink,published,PublishedDisplay,locationFilter,zip">
		<!--- seupt datatypes for our columns --->
		<cfset typelist = "str,str,str,str,str,str,str,str,str,str,date,date,str,str,date,str,str,str">
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
		<cfargument name="orderby" required="yes" default="Published DESC" hint="query sort order">
		
		<cfset var exclude = "">
        
        <!--- create a new query which sets one row to force datayping for columns --->
		<cfif not isDefined('arguments.queryname')>
			<cfset myquery= createNewQuery()>
		</cfif>
<cftry>
<!--- LOOP THRU GOOGLE XML AND POPULATE QUERY  --->
<cfif structkeyexists(xml.feed.entry[i], "link")>
    	<!--- create a query object from the XML data --->
    	<cfset size = arraylen(XML.feed.entry)>
  		
		<!--- Now add XML data to our query --->
    	<cfset queryaddrow(myquery, size)>
		<cfloop from="1" to="#size#" index="i">  
		   

    <!--- our exlude list - sites we dont want in the results --->
	<cfset exclude = excludecheck(XML.feed.entry[i].link.xmlattributes.href)>

	<cfif exclude is "false">
			<cfset link = XML.feed.entry[i].link.xmlattributes.href>
			
			<cfif structkeyexists(xml.feed.entry[i], "id")>
			<!--- This won't work here, querysetcell will not format it correctly 
					(do it in the output template instead)
			<cfset jobid = getToken(XML.feed.entry[i].id.xmltext, 6, "/")> --->
				<cfset querysetcell(myquery, "jobid", XML.feed.entry[i].id.xmltext, i)>				
			</cfif>
  
			<cfif structkeyexists(xml.feed.entry[i], "title")>
				<cfset querysetcell(myquery, "title",  XML.feed.entry[i].title.xmltext, i)>
				<cfif not len(XML.feed.entry[i].title.xmltext)>
				<cfset querysetcell(myquery, "title",  " ", i)>
				</cfif>
			</cfif>
			
			<cfif structkeyexists(xml.feed.entry[i], "link")>
            	<cfset sourcelink = replace(XML.feed.entry[i].link.xmlattributes.href, "http://", "", "One")>
				<cfset sourcelink = replace(sourcelink, "https://", "", "One")>
				<cfset sourcelink = replace(sourcelink, "www.", "", "One")>
				<cfset sourcelink = gettoken(sourcelink,1,"/")>
				
				<cfset link = REReplacenocase(XML.feed.entry[i].link.xmlattributes.href,"googlebase|google","thejobfool","all")>
				
                <cfif sourcelink neq 'base.google.com'>
				<cfset querysetcell(myquery, "sourcelink", sourcelink, i)>
				<cfset querysetcell(myquery, "link", link, i)>
                </cfif>
			</cfif>
			
			<cfif structkeyexists(xml.feed.entry[i], "content")>
			<cfset content = replaceNoCase(XML.feed.entry[i].content.xmltext, "POSITION SUMMARY ","", "one")>
			<cfset content = replaceNoCase(content, "*","", "all")>
            	<cfset querysetcell(myquery, "description",content, i)>
            </cfif>
			
			<cfif structkeyexists(xml.feed.entry[i], "location")>
                <cfset querysetcell(myquery, "location",#trim(XML.feed.entry[i].location.xmltext)#, i)>
            </cfif>
			
			<cfif structkeyexists(xml.feed.entry[i], "location")>
				<cfparam name="loc2" default="">
				<cfset loc1 = #gettoken(XML.feed.entry[i].location.xmltext, 1, ",")#>
				<cfset loc2 = #gettoken(XML.feed.entry[i].location.xmltext, 2, ",")#>
				<cfset zip = #gettoken(XML.feed.entry[i].location.xmltext, 3, ",")#>
				<cfif len('loc2')>
					<cfset locationfilter = loc1 &", "& loc2>
				<cfelse>
					<cfset locationfilter = loc1>
				</cfif>
				<cfset locationfilter = replace(locationfilter, "  ", " ", "all")>
                <cfset querysetcell(myquery, "locationFilter",#trim(locationfilter)#, i)>			
				<cfif len(trim(zip)) is 5 and isNumeric(trim(zip))>
					<cfset querysetcell(myquery, "zip", #trim(zip)#, i)>
				</cfif>
            </cfif>
			
            <cfif structkeyexists(xml.feed.entry[i], "job_type")>
			<cfset jobtype = XML.feed.entry[i].job_type.xmltext>
			<cfset jobtype = replace(jobtype, "  ", " ", "all")>
			<cfif jobtype contains "full"><cfset jobtype = "Full-Time"></cfif>
			<cfif jobtype contains "part"><cfset jobtype = "Part-Time"></cfif>
                <cfset querysetcell(myquery, "job_type",  trim(jobtype), i)>
            </cfif>
            
            <cfif structkeyexists(xml.feed.entry[i], "employer")>
                <cfset querysetcell(myquery, "employer",  XML.feed.entry[i].employer.xmltext, i)>
            </cfif>
			
            <cfif structkeyexists(xml.feed.entry[i], "job_function")>
				<cfset jf = XML.feed.entry[i].job_function.xmltext>
				<cfif jf eq "other"><cfset jf = ""></cfif>
				<cfset jf = reReplace(jf,"[_()]", " ", "all")>
				<cfset jf = replace(jf, ",", "", "all")>
                <cfset querysetcell(myquery, "job_function", jf, i)>
            </cfif>
			
            <cfif structkeyexists(xml.feed.entry[i], "job_Industry")>
				<cfif XML.feed.entry[i].job_Industry.xmltext eq "it">
					<cfset job_industry = ucase(XML.feed.entry[i].job_Industry.xmltext)>
					<cfset job_industry = replace(job_industry, "  ", " ", "all")>
				</cfif>
                <cfset querysetcell(myquery, "job_Industry", trim(XML.feed.entry[i].job_Industry.xmltext), i)>
            </cfif>
            
            <cfif structkeyexists(xml.feed.entry[i], "expiration_date")>
				<cfset expiration_date = "#XML.feed.entry[i].expiration_date.xmltext#">
                <cfset new = #replaceNoCase(expiration_date, "Z", "", "one")#>
				<cfset new = #replaceNoCase(new, "T", " ", "one")#>
				<cfset expiration_date = ParseDateTime( new ) />
                <cfset querysetcell(myquery, "expiration_date",  "#expiration_date#", i)>
            </cfif>
            
            <cfif structkeyexists(xml.feed.entry[i], "publish_date")>
				<cfset publish_date = #replaceNoCase(XML.feed.entry[i].publish_date.xmltext, "Z", "", "one")#>
				<cfset new = #replaceNoCase(publish_date, "T", " ", "one")#>
                <cfset publish_date = ParseDateTime( new ) />
                <cfset querysetcell(myquery, "publish_date",  "#publish_date#", i)>
            </cfif>
            
            <cfif structkeyexists(xml.feed.entry[i], "updated")>
				<cfset published = XML.feed.entry[i].updated.xmltext>
                <cfset new = #replaceNoCase(published, ".000Z", "", "one")#>
				<cfset new = #replaceNoCase(new, "T", " ", "one")#>
				<cfif NOT isDate(new)><cfset new = #now()#></cfif>
				<cfset published = ParseDateTime( new ) />
				<cfset days = DateDiff("d", published, now())> 
                <cfset hrs = DateDiff("h", published, now())>
                <cfset hrs = hrs - (days * 24)>
                <cfif days GT 1>
                <cfset publishedDisplay = "#days# days and #hrs# hours">
				<cfelseif days eq 1>
				 <cfset publishedDisplay = "1 day and #hrs# hours">
                <cfelseif hrs eq 0>
                 <cfset publishedDisplay = "#days# days">
			   	<cfelseif hrs lte 0>
			   		<cfset publishedDisplay = "1 hour">
				<cfelse>
                 <cfset publishedDisplay = "#hrs# hours">
                </cfif>
              <cfset querysetcell(myquery, "publishedDisplay",  "#publishedDisplay#", i)>
              <cfset querysetcell(myquery, "published",  "#published#", i)>
            </cfif>
           
            <cfif structkeyexists(xml.feed.entry[i], "author")>
                <cfset querysetcell(myquery, "source",  trim(XML.feed.entry[i].author.name.xmltext), i)>
            </cfif>
			<cfif structkeyexists(xml.feed.entry[i], "salary")>
               <cfset salary = gettoken(XML.feed.entry[i].salary.xmltext, 1, ".")>
				<cfif salary gt 9999 and isNumeric(salary)>
				<cfset salary = numberFormat(salary, "9,999,999")><cfelse><cfset salary = ""></cfif>
                <cfset querysetcell(myquery, "salary", salary, i)>
            </cfif>
	</cfif><!--- end exclude --->
		</cfloop>
</cfif><!--- END LOOP GOOGLE XML --->
			<cfcatch>
				<cfif cgi.remote_addr is "70.119.116.159">
					<cfdump var="#arguments.xml#">
					<cfdump var="#error#">
					<cfdump var="#cfcatch#"><cfabort>
				</cfif>
			</cfcatch>
		</cftry>
        
        
 <!--- LOOP THRU INDEED XML --->       
        
        <!--- create a query object from the XML data --->
    	<cfset size = arraylen(xml.response.results.result)>
 		
		<!--- Now add XML data to our query --->
		<cftry>
    	<cfset queryaddrow(myquery, size)>
		<cfloop from="1" to="#size#" index="i">  
        
        #xml.response.results.result[i].jobtitle.xmltext#<br>
        
			 <cfif structkeyexists(xml.response.results.result[i], "jobtitle")>
            
                  
                        <cfif structkeyexists(xml.response.results.result[i], "jobkey")>
                            <cfset querysetcell(myquery, "jobid", xml.response.results.result[i].jobkey.xmltext, i)>				
                        </cfif>
                        
                        <cfif structkeyexists(xml.response.results.result[i], "url")>
                      
    
						<!--- <cfset querysetcell(myquery, "link", xml.response.results.result[i].url.xmltext, i)> --->
 						<cfset link = "/uk/jobs/view.cfm?do=1&amp;id=" & xml.response.results.result[i].jobkey.xmltext> 
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
                        
            </cfif>
            
		</cfloop>

			<cfcatch>
            <cfif isdefined('cfcatch')>
					<cfdump var="#cfcatch#"><cfabort>
            </cfif>
			</cfcatch>
            
		</cftry>
        <!--- / END LOOP THRU INDEED XML --->
        

		<cfif myquery.RecordCount gt 1> 
		<cftry>		
            <cfquery dbtype="query" name="Rquery">
            select #variables.columnlist#
			from myquery
            where link is not null
			order by #arguments.orderby#
            </cfquery>	
		<cfcatch type="any">	
		<cfif cgi.remote_addr is "70.119.116.159">
			<cfdump var="#error#">
			<cfdump var="#cfcatch#"><cfabort>
		</cfif>
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
            select distinct(locationfilter) as location
			from myquery
            where locationfilter is not NULL
			group by locationfilter
      </cfquery>
	</cfif>
	<cfreturn locations>
	</cffunction>
	
	<cffunction name="getZips" access="public" returntype="query" output="no" hint="">
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
	</cffunction>
	
	
	<cffunction name="getJobType" access="public" returntype="query" output="no" hint="">
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
	</cffunction>
	
	<cffunction name="getJobFunction" access="public" returntype="query" output="no" hint="">
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
	</cffunction>
	
    
    <cffunction name="getJobIndustry" access="public" returntype="query" output="no" hint="">
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
	</cffunction>
	
	<cffunction name="getSource" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="source">
            select distinct(sourcelink) 
			from myquery
            where sourcelink is not NULL
			group by sourcelink
			order by sourcelink asc
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
	
	<cffunction name="getSalarys" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="employer">
            select salary, title, location
			from myquery
            where salary is not NULL
      </cfquery>
	</cfif>
	<cfreturn employer>
	</cffunction>
	
	
	<cffunction name="getDescription" access="public" returntype="query" output="no" hint="">
	<cfargument name="myquery" type="query" required="no">
	<cfif isDefined('arguments.myquery')>
	 <cfquery dbtype="query" name="desc" maxrows="1" cachedwithin="#createtimespan(0,0,2,0)#">
            select title, description 
			from myquery
            where description is not NULL
      </cfquery>
	</cfif>
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
	
	
	<cffunction name="getJob" access="public" output="FALSE" returntype="struct" hint="I make a cfhttp query call to googlebase for a single job and parse the XML, format it and return it as a string variable.">
	<cfargument name="jobid" required="no" default="0" hint="unique job id provide by google">

	<cfset var qrydata = structNew()>
    <cfset var rawXML = "">
	<cfset var XML = "">

		 

	<cfif isDefined('url.test')>
	<cfoutput>
	<cfset link="http://www.google.com/base/feeds/snippets/#arguments.jobid#">
	<a href="#link#">#urldecode(link)#</a>
	</cfoutput>
	<cfabort>
	</cfif>
	    
	<cfhttp method="get" url="http://www.google.com/base/feeds/snippets/#arguments.jobid#">
	
	
	<!--- if bad request create and return blank query --->
    <cfif cfhttp.statuscode does not contain "200">
        <cfset qrydata = structNew()>
		<cfset qrydata.recordcount = 0>
        <cfreturn qrydata>
        <cfexit>
    </cfif>

	<!--- coldfusion yells at us if we use : so we need to remove them --->
	<cfset rawXML=#replaceNoCase(cfhttp.filecontent, "g:", "", "all")#>
	<cfset rawXML=#replaceNoCase(rawXML, "openSearch:", "", "all")#>
	<!---  parse the raw XML into CF usable struct --->
	<cfset XML= xmlparse(rawXML)>
   
	
	<cfif isdefined("XML.entry") and arraylen(XML.entry) gt 0>
		<!--- CONVERT THE PARSED XML ARRAY INTO A COLDFUSION struct --->
    	<cfset qrydata = structnew() />
        
        	<cfif structkeyexists(xml.entry, "id")>
				<cfset qrydata.jobid = getToken(XML.entry.id.xmltext, 6, "/")>
			</cfif>

			<cfif structkeyexists(xml.entry, "title")>
				<cfset qrydata.title = XML.entry.title.xmltext>
			</cfif>
            
            <cfif structkeyexists(xml.entry, "content")>
				<cfset qrydata.description = XML.entry.content.xmltext>
			</cfif>
            
            <cfif structkeyexists(xml.entry, "link")>
				<cfset qrydata.link = XML.entry.link.xmlattributes.href>
                <cfset sourcelink = replace(XML.entry.link.xmlattributes.href, "http://", "", "One")>
				<cfset sourcelink = replace(sourcelink, "https://", "", "One")>
				<cfset sourcelink = replace(sourcelink, "www.", "", "One")>
				<cfset sourcelink = gettoken(sourcelink,1,"/")>
				<cfset qrydata.link = REReplacenocase(XML.entry.link.xmlattributes.href,"googlebase|google","thejobfool","all")>
                <cfif sourcelink neq 'base.google.com'>
				<cfset qrydata.sourcelink = trim(sourcelink)>
				<cfset qrydata.link = trim(qrydata.link)>
                </cfif>
            </cfif>      
			
			<cfif structkeyexists(xml.entry, "expiration_date")>
				<cfset expiration_date = "#XML.entry.expiration_date.xmltext#">
                <cfset new = #replaceNoCase(expiration_date, "Z", "", "one")#>
				<cfset new = #replaceNoCase(new, "T", " ", "one")#>
				<cfset expiration_date = ParseDateTime( new ) />
                <cfset qrydata.expiration_date = expiration_date>
            </cfif>
            
            <cfif structkeyexists(xml.entry, "location")>
				<cfparam name="loc2" default="">
				<cfset loc1 = #gettoken(XML.entry.location.xmltext, 1, ",")#>
				<cfset loc2 = #gettoken(XML.entry.location.xmltext, 2, ",")#>
				<cfset zip = #gettoken(XML.entry.location.xmltext, 3, ",")#>
				<cfif len('loc2')>
					<cfset location = loc1 &", "& loc2>
				<cfelse>
					<cfset location = loc1>
				</cfif>
				<cfset location = replace(location, "  ", " ", "all")>
                <cfset qrydata.location  = #trim(location)#>			
				<cfif len(trim(zip)) is 5 and isNumeric(trim(zip))>
					<cfset qrydata.zip =  #trim(zip)#>
				</cfif>
            </cfif>
            
            <cfif structkeyexists(xml.entry, "job_type")>
			<cfset jobtype = XML.entry.job_type.xmltext>
			<cfset jobtype = replace(jobtype, "  ", " ", "all")>
			<cfif jobtype contains "full"><cfset jobtype = "Full-Time"></cfif>
			<cfif jobtype contains "part"><cfset jobtype = "Part-Time"></cfif>
            <cfset qrydata.job_type =  "#trim(jobtype)#">
            </cfif>
            
            <cfif structkeyexists(xml.entry, "employer")>
                <cfset qrydata.employer =  XML.entry.employer.xmltext>
            </cfif>
			
            <cfif structkeyexists(xml.entry, "job_function")>
				<cfset jf = XML.entry.job_function.xmltext>
				<cfif jf eq "other"><cfset jf = ""></cfif>
				<cfset jf = reReplace(jf,"[_()]", " ", "all")>
				<cfset jf = replace(jf, ",", "", "all")>
                <cfset qrydata.job_function = jf>
            </cfif>
			
            <cfif structkeyexists(xml.entry, "job_industry")>
            	<cfif XML.entry.job_Industry.xmltext eq "it">
					<cfset job_industry = ucase(XML.entry.job_Industry.xmltext)>
					<cfset job_industry = replace(job_industry, "  ", " ", "all")>
				</cfif>
                <cfset qrydata.job_industry = "#trim(XML.entry.job_industry.xmltext)#">
            </cfif>
            
           <cfif structkeyexists(xml.entry, "salary")>
               <cfset salary = gettoken(XML.entry.salary.xmltext, 1, ".")>
				<cfif salary gt 9999 and isNumeric(salary)>
				<cfset salary = numberFormat(salary, "9,999,999")><cfelse><cfset salary = ""></cfif>
                <cfset qrydata.salary = salary>
            </cfif>
            
            <cfif structkeyexists(xml.entry, "publish_date")>
				<cfset publish_date = #replaceNoCase(XML.entry.publish_date.xmltext, "Z", "", "one")#>
				<cfset new = #replaceNoCase(publish_date, "T", " ", "one")#>
                <cfset publish_date = ParseDateTime( new ) />
                <cfset qrydata.publish_date =  trim(publish_date)>
            </cfif>
            
            <cfif structkeyexists(xml.entry, "updated")>
				<cfset published = XML.entry.updated.xmltext>
                <cfset new = #replaceNoCase(published, ".000Z", "", "one")#>
				<cfset new = #replaceNoCase(new, "T", " ", "one")#>
				<cfif NOT isDate(new)><cfset new = #now()#></cfif>
				<cfset published = ParseDateTime( new ) />
				<cfset days = DateDiff("d", published, now())> 
                <cfset hrs = DateDiff("h", published, now())>
                <cfset hrs = hrs - (days * 24)>
                <cfif days GT 1>
                <cfset publishedDisplay = "#days# days and #hrs# hours">
				<cfelseif days eq 1>
				 <cfset publishedDisplay = "1 day and #hrs# hours">
                <cfelseif hrs eq 0>
                 <cfset publishedDisplay = "#days# days">
			   	<cfelseif hrs lte 0>
			   		<cfset publishedDisplay = "1 hour">
				<cfelse>
                 <cfset publishedDisplay = "#hrs# hours">
                </cfif>
              <cfset qrydata.publishedDisplay = trim(publishedDisplay)>
              <cfset qrydata.published = dateformat(trim(published), "yyyy-mm-dd hh:mm:ss")>
            </cfif>
            
            <cfif structkeyexists(xml.entry, "author")>
                <cfset qrydata.source = trim(XML.entry.author.name.xmltext)>
            </cfif>

        <cfset qrydata.recordcount = 1>
        <cfset request.totalrecords = 1>
   	
	<cfelse>
	<!--- no data returned from google base, show message --->
		<cfset qrydata.recordcount = 0>
		<cfset qryData = querynew("title")>
	</cfif>
	
	<cfreturn qryData>
	</cffunction>
</cfcomponent>