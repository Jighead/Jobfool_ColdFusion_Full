<!--- MANAGE COUNTRY SEARCHES HERE --->
<cfif application.partner eq 'indeed'>
		<cfif cgi.http_host contains 'uk.'>
            <cfset request.co = 'gb'>
        <cfelseif cgi.http_host contains 'au.'>
            <cfset request.co = 'au'>
        <cfelseif cgi.http_host contains 'can.'>
            <cfset request.co = 'ca'>
        <cfelseif cgi.http_host contains 'es.'>
            <cfset request.co = 'es'>
        <cfelseif cgi.http_host contains 'de.'>
            <cfset request.co = 'de'>
        <cfelseif cgi.http_host contains 'fr.'>
            <cfset request.co = 'fr'>
        <cfelseif cgi.http_host contains "HealthCare.">
        	<cfset request.chnl = "HealthCare">
        <cfelseif cgi.http_host contains "IT.">
        	<cfset request.chnl = "IT">
        <cfelse>
            <cfset request.co = 'us'>
        </cfif>
</cfif>