
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

<cfset url.q = "line cook">
<cfset url.loc = "chicago">

<cfset link = "http://api.indeed.com/ads/apisearch?publisher=1271737033048898&v=2&format=json&q=#url.q#&l=#url.loc#&cache=false&start=1&limit=10&fromage=30&sort=date&filter=1&latlong=1&radius=50&userip=74.52.81.178&useragent=HiFi CMS">


<cfoutput><p><a href="#link#">View results</a></p></cfoutput>
<cfhttp method="get" url="#link#">


<cfset results = deserializeJSON(cfhttp.filecontent)>


<cfdump var="#results#">


<cfset resultsArray = results.results >
<cfloop array="#resultsArray#" index="item">
    <cfdump var="#item#">
</cfloop>

