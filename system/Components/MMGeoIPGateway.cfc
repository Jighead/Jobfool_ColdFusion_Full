<cfcomponent>
	<cfset dsn = "#request.dsn#">
	
	<cffunction name="getGeoSP" access="public" returntype="query">
		<cfargument name="ip1" type="string" required="no" default="">
		<cfset var geodata1 = "">
		<cfstoredproc datasource="#dsn#" procedure="lookup_geoip">
			<cfprocparam  value="#arguments.ip1#" cfsqltype="cf_sql_varchar">
			<cfprocresult  name="geodata1">
		</cfstoredproc>
		<cfreturn geodata1>
	</cffunction>
	
	<cffunction name="getGeoQRY" access="public" returntype="query">
		<cfargument name="ip" type="string" required="no" default="">
		<cfset var geodata2 = "">
		<cfset var ip2 = arguments.ip>
	    <cfset ip2 = ListToArray(ip,'.')>
        <cfset ip2 = ((ip2[1] * 16777216) + (ip2[2] * 65536) + (ip2[3] * 256) + (ip2[4]))>

        <cfquery name="geodata2" datasource="#request.dsn#">
            SELECT geoloc.*
			FROM GeoLook 
			INNER JOIN Geoloc ON GeoLook.locId = Geoloc.locId 
			WHERE #ip2# BETWEEN GEOBlock.startIpNum AND GEOBlock.endIpNum
        </cfquery>
		<cfreturn geodata2>
	</cffunction>
</cfcomponent>