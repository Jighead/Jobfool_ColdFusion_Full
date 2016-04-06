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
    <cfset variables.radius = "50">
    <cfset variables.fromage= "last">
    <cfset variables.sort= "date">
    <cfset variables.totalrecords = "">
    <cfset variables.pages = "">
    <cfset variables.columlist = "">

    <cffunction name="getJobs" output="true" returntype="any">
        <cfargument name="kw" required="no" default="sales" hint="keyword search string">
        <cfargument name="L" required="yes" default="">
        <cfargument name="co" required="yes" default="US">
        <cfargument name="emp" required="no" default="">
        <cfargument name="qt" required="no" default="10" hint="max results per page">
        <cfargument name="st" required="no" default="" hint="Job Site type">
        <cfargument name="salary" required="no" default="" hint="">
        <cfargument name="start" required="no" default="1" hint="start at record">
        <cfargument name="p" required="no" default="1" hint="pageumber to calc start record from.">
        <cfargument name="radius" required="no" default="50" hint="radius from location">
        <cfargument name="fromage" required="no" default ="30" hint="How many days back to search">
        <cfargument name="sb" required="no" default ="relevance" hint="relevance or date">
        <cfargument name="rbc" required="no" default ="30" hint="employer name - used in como with jcid">
        <cfargument name="jcid" required="no" default ="30" hint="employerid used to identify employer">
        <cfargument name="filter" required="no" default="1" hint="filter duplicates 1 or 0">
        <cfargument name="orderby" required="yes" default="Publish_date DESC" hint="query sort order">
        <cfset var pubid = ''>
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


        <cfif isDefined('arguments.salary') and arguments.salary gt 10000>
            <cfset variables.salary = arguments.salary>
        </cfif>

        <cfif isDefined('arguments.emp') and arguments.emp gt 2>
<!---            <cfset variables.q = "company:#arguments.emp#">
            <cfset variables.st = "employer">
            <cfset variables.sr = "directhire"> --->
            <cfset variables.emp = "#arguments.emp#"/>
                

        </cfif>
        <cfif isDefined('arguments.fromage')>
            <cfset variables.fromage = arguments.fromage>
        </cfif>

        <cfif isDefined('arguments.p') and arguments.p gt 1>
            <cfset variables.start = (arguments.p * arguments.qt) - arguments.qt +1>
        <cfelse>
            <cfset variables.start = 1>
        </cfif>
            
        <cfset pubid = trim(getPublisher())>
        <cfif pubid is ''>
            pubid failed!
        <cfabort>
            </cfif>
            
        <cfset link="http://api.indeed.com/ads/apisearch?publisher=#pubid#&v=2&format=json&cache=true&q=#variables.q#&l=#variables.l#&st=#variables.st#&start=#variables.start#&limit=#variables.qt#&fromage=#variables.fromage#&salary=#variables.salary#&sort=#variables.sb#&filter=1&latlong=1&co=#variables.co#&chnl=&radius=#variables.radius#&filter=1&userip=#cgi.REMOTE_ADDR#&useragent=#cgi.HTTP_USER_AGENT#">

        <!--- testing stuff --->
        <cfif isDefined('url.test') and url.test EQ "gerd">
            <!--- Paramaters available for Indeed...
            st = Site type. To show only jobs from job boards use 'jobsite'. For jobs from direct employer websites use 'employer'
            start = Start results at this result number, beginning with 0. Default is 0. 
            fromage = Number of days back to search. 
            filter = Filter duplicate results. 0 turns off duplicate job filtering. Default is 1. 
            --->
            <cfoutput>
                <a href="#link#">#link#</a>
            </cfoutput>
            <cfhttp method="get" url="#link#">
            <br><br>
            <cfdump var="#cfhttp#">
            <cfabort>
        </cfif>
        
        <cfset resultset = getJobData(link)>
            
        <!--- TODO : remove for production --->
        <cfif not isDefined('resultset.totalResults')>
            <cfdump var="#link#"><cfabort>
        </cfif>

        <cfreturn resultset>
    </cffunction>



    <cffunction name="getPublisher" returntype="string" output="false" access="private">

    <cfset idlist="
                   2059896800093889,
                   7570038743238473,
                   4957686695268887,
                   4957686695268887,
                   4939942668444045,
                   6717239641963456,
                   2113264712719746,
                   513220477112201,
                   6124646274859299,
                   4718663163266575,
                   4751269202013823,
                   287632479529517,
                   3915226238946704,
                   2079644992618586,
                   1643549737839785,
                   5447900290690089,
                   9457234687056194,
                   8969708858431755,
                   9585983862567406,
                   5077292562212580,
                   1652353865637104,
                   1825263940814973,
                   9616825572719411,
                   3095449269753141,
                   6962738377866021,
                   145021333590586,
                   2838105322279545,
                   8609926619731182,
                   3832358952142376,
                   ">

    <cfset objRandom=ArrayNew(1)>
    <cfset objRandom=ListToArray(idlist)>
    <cfset arraylen = ArrayLen(objRandom)>
    <!--- <cfset ArraySort(objRandom,"textnocase","ASC")> --->
    <!--- random number b/n 1 and length of list/array --->
    <cfset randpubid = objRandom[RandRange(1, arraylen, "SHA1PRNG")]>

    <cfreturn randpubid>
    </cffunction>

    <cffunction name="getJobData" access="private" returntype="any">
        <cfargument name="link" required="true">

        <cfhttp method="get" url="#arguments.link#">
        <cfif cfhttp.statuscode EQ "200 OK">
            <cfset result = deserializeJSON(cfhttp.filecontent)>
            <!--- <cfset qrydata = createQuery(resultsArray.results)> --->     
        <cfelse>
            <cfset result = "ERROR">
        </cfif>
        <cfreturn result>
    </cffunction>
                    
    <!--- =============================================================
        This function creates an empty query to hold the result data 
        so we can query for locations or employers, etc.
    =================================================================== --->
    <cffunction name="createQuery" access="public" output="true" returntype="any">
            <cfargument name="data" type="any">
            <cfset var q = QueryNew( StructKeyList(arguments.data[1]) ) />
                
            <cfloop from="1" to="#arrayLen(arguments.data)#" index="i">
                <cfset Row = QueryAddRow(Q) />
                    <cfloop collection="#arguments.data[i]#" item="colname">
                        <!--- <cfoutput>#colname# #arguments.data[i][colname]#</cfoutput><br> --->
                        <cfset QuerySetCell( Q , colname , data[i][colname], Row ) />    
                    </cfloop>
            </cfloop> 
            
        <!--- Force Define the datatype in the query --->
		<cfquery name="rquery" dbType="query">
		SELECT *
		FROM q
		WHERE 1 <> 1
		</cfquery>

        <cfreturn q> 
    </cffunction>     
            


        
    
        
        
    <!--- =============== SubQueries (filters) start here =============== --->
	<cffunction name="getLocations" access="public" returntype="query" output="no" hint="">
	   <cfargument name="query" type="query" required="no">
	   <cfif isDefined('arguments.query')>
         <cfquery dbtype="query" name="locations">
                select distinct(location) as location
                from query
                where location is not NULL
                group by location
          </cfquery>
        </cfif>
	<cfreturn locations>
	</cffunction>
           
    <cffunction name="getLocs" access="public" output="no">
        <cfargument name="data" type="any">   
            
        <cfset var locations = [] /> 
        <cfloop array="#arguments.data.results#" index="data"> 
            <cfif not ArrayFindNoCase(locations,data.formattedLocation)>
                <cfset arrayAppend(locations, data.formattedLocation) >
            </cfif>
        </cfloop> 
            
        <cfreturn locations>
    </cffunction>
            
    <cffunction name="getEmps" access="public" output="no">
        <cfargument name="data" type="any">   
            
        <cfset var employers = [] /> 
        <cfloop array="#arguments.data.results#" index="data"> 
            <cfif not ArrayFindNoCase(employers,data.company)>
                <cfset arrayAppend(employers, data.company) >
            </cfif>
        </cfloop> 
            
        <cfreturn employers>
    </cffunction>


</cfcomponent>
