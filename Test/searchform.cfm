<cfparam name="noreturn" default="false">
<cfparam name="url.kw" default="">
<cfset intStartTime = GetTickCount() />
<cfparam name="url.l" default="">
<cfparam name="url.co" default="US">
<cfparam name="url.sb" default="">
<cfparam name="url.radius" default="50">
<cfparam name="request.grecords" default="0">
<cfparam name="url.qt" default="10"><!--- qty per page --->
<cfparam name="url.p" default="1"><!--- default page were on --->
<cfparam name="url.st" default="1"><!--- default start row were on --->
<cfparam name="url.from" default="90"><!--- default start row were on --->
<cfset url.fromage = url.from>
<cfparam name="request.intotalrecords" default="">
<cfset foo = randrange(1, 10)>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>



<form method="get" action="searchform.cfm">
    <label>What</label><input type="text" name="kw" value="" id="kw">
    <label>Where</label><input type="text" name="loc" value="" id="kw">
    <input type="submit" value="search">
</form>

<cfif len(url.kw) GT 0>
    <cfinvoke component="components.ijson" method="getJobs" returnvariable="results">
    <cfset total = results.totalResults>

    <script>
        var results = {};
        results.total = <cfoutput>#total#</cfoutput>;
    </script>


    <cfdump var="#results#">
        <cfloop array="#results.results#" index="item">
        <cfoutput>
        <div class="job">
            <h2><a href="/jobs/view.cfm?do=1&amp;jobid=">#item.jobtitle#</a></h2>
            <span class="employer" itemtype="http://schema.org/Organization">#item.company#</span>
            <p class="summary">#item.snippet#</p>
            <p class="location" itemtype="http://schema.org/Postaladdress">#item.formattedLocationFull#</p>
            <p class="posted">#item.formattedRelativeTime#</p>
        </div>
        </cfoutput>
    </cfloop>

        <div id="job-results-pagination"></div>
</cfif>



