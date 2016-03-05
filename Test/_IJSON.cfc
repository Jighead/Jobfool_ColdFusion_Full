<cfcomponent>


   <cffunction name="getJobs" returntype="any" output="true">
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

            <cfdump var="#arguments#" label="arguments"><cfabort>

        getPublisher();
      <!---
      <cfset link="http://api.indeed.com/ads/apisearch?publisher=#trim(getPublisher())#&v=2&q=#variables.q#&l=#variables.l#&st=#variables.st#&start=#variables.start#&limit=#variables.qt#&fromage=#variables.fromage#&salary=#variables.salary#&sort=#variables.sb#&filter=1&latlong=1&co=#variables.co#&chnl=&radius=#variables.radius#&filter=1&userip=#cgi.REMOTE_ADDR#&useragent=#cgi.HTTP_USER_AGENT#">
    --->



    </cffunction>


    <cffunction name="getPublisher" returntype="string" output="false" access="private">

    <cfset idlist="
                   2059896800093889,
                   5168306077281773,
                   7570038743238473,
                   4957686695268887,
                   4957686695268887,
                   5656845852938153,
                   4939942668444045,
                   4011229145604540,
                   6717239641963456,
                   2113264712719746,
                   513220477112201,
                   6124646274859299,
                   4718663163266575,
                   4751269202013823,
                   9196068365305411,
                   287632479529517,
                   3915226238946704,
                   2079644992618586,
                   1643549737839785,
                   5447900290690089,
                   9457234687056194,
                   6013464740111584,
                   8969708858431755,
                   8940071724993764,
                   8397709210207872,
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
                   3510772137080679
                   ">

    <cfset objRandom=ArrayNew(1)>
    <cfset objRandom=ListToArray(idlist)>
    <cfset arraylen = ArrayLen(objRandom)>
    <!--- <cfset ArraySort(objRandom,"textnocase","ASC")> --->
    <!--- random number b/n 1 and length of list/array --->
    <cfset randpubid = objRandom[RandRange(1, arraylen, "SHA1PRNG")]>
    <cfreturn randpubid>

    </cffunction>














<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

<cfset url.q = "ux designer">
<cfset url.loc = "new york city">

<cfset link = "http://api.indeed.com/ads/apisearch?publisher=1271737033048898&v=2&format=json&q=#url.q#&l=#url.loc#&cache=false&start=1&limit=10&fromage=30&sort=date&filter=1&latlong=1&radius=50&userip=74.52.81.178&useragent=HiFi CMS">


<cfoutput><p><a href="#link#">View results</a></p></cfoutput>
<cfhttp method="get" url="#link#">


<cfset results = deserializeJSON(cfhttp.filecontent)>


<cfdump var="#results#">


<cfset resultsArray = results.results >
<cfloop array="#resultsArray#" index="item">
    <cfdump var="#item#">
</cfloop>


</cfcomponent>
