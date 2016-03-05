<cfcomponent>
	<cfset this.dsn = "jobs">


	<cffunction name="getNetGeoLoc" access="public" returntype="struct">
	<cfargument name="ip" type="string" required="yes">
	
	<cfhttp url="http://netgeo.caida.org/perl/netgeo.cgi?target=#arguments.ip#" method="get" useragent="IE5.5">

	<!--- parse the result into a struct --->
	<cfscript>
	data = structnew();
	citystart 	= findNoCase('CITY:',cfhttp.filecontent)+6;
	cityend 	= findNoCase('<br>',cfhttp.filecontent,citystart);
	data.city 	= trim(mid(cfhttp.filecontent,citystart,cityend-citystart));
	statestart 	= findNocase('STATE: ',cfhttp.filecontent)+7;
	stateend 	= findNoCase('<br>',cfhttp.filecontent,statestart);
	data.state 	= trim(mid(cfhttp.filecontent,statestart,stateend-statestart));
	countrystart = findNoCase('COUNTRY: ',cfhttp.filecontent)+9;
	countryend 	= findNoCase('<br>',cfhttp.filecontent,countrystart);
	data.country = trim(mid(cfhttp.filecontent,countrystart,countryend-countrystart));
	latstart 	= findNoCase('LAT: ',cfhttp.filecontent)+4;
	latend 		= findNoCase('<br>',cfhttp.filecontent,latstart);
	data.lat 	= trim(mid(cfhttp.filecontent,latstart,latend-latstart));
	longstart 	= findNoCase('LONG: ',cfhttp.filecontent)+5;
	longend 	= findNoCase('<br>',cfhttp.filecontent,longstart);
	data.long 	= trim(mid(cfhttp.filecontent,longstart,longend-longstart));
	</cfscript>
	<cfif isDefined('data.city') and len('data.city')>
		<cfquery name="dupcheck" datasource="#this.dsn#" username="#request.dbuser#" password="#request.dbpass#">
		select ip from geoip 
		where ip = '#arguments.ip#'
		</cfquery>
		
		<cfif dupcheck.recordcount is 0>
			<cfquery name="doinsert" datasource="#this.dsn#" username="#request.dbuser#" password="#request.dbpass#">>
			insert into geoip (ip,city,state,country,latitude,longitude)
			values ('#arguments.ip#','#data.city#','#data.state#','#data.country#','#data.lat#','#data.long#')
			</cfquery>
		</cfif>
	</cfif>

	<cfreturn data>

	</cffunction>
	
	
	<cffunction name="getArinLoc" access="public" returntype="struct">
	<cfargument name="ip" type="string" required="yes">
	<cfhttp url="http://ws.arin.net/whois/?queryinput=#ip#" method="get" useragent="IE5.5">
	
		<cfscript>
		data = structnew();
		result = cfhttp.filecontent;
		start = findnocase("<pre>",result,1);
		end = findnocase("</pre>",result,start);
		data.set = trim(mid(result,start,end-start));
		
		citystart 	= findNoCase('CITY:',data.set)+6;
		cityend 	= findNoCase('StateProv:',data.set,citystart);
		data.city 	= trim(mid(data.set,citystart,cityend-citystart));
		
		statestart 	= findNoCase('StateProv:',data.set)+10;
		stateend 	= findNoCase('PostalCode:',data.set,statestart);
		data.state 	= trim(mid(data.set,statestart,stateend-statestart));
		
		zipstart 	= findNoCase('PostalCode:',data.set)+12;
		zipend 	= findNoCase('Country:',data.set,zipstart);
		data.zip 	= trim(mid(data.set,zipstart,zipend-zipstart));
		
		countrystart 	= findNoCase('Country:',data.set)+9;
		countryend 	= findNoCase('NetRange:',data.set,countrystart);
		data.country 	= trim(mid(data.set,countrystart,countryend-countrystart));
		
		</cfscript>
	<cfreturn data>
	</cffunction>

	<cffunction name="getIPPagesLoc" access="public" output="false" returntype="struct">
	<cfargument name="ip" type="string" required="yes">
	<cfargument name="returntype" type="string" required="yes" default="XML">
	<cfset data = structNew()>
    <cfset data.city ="">
    <cfset data.state="">
    <cfset data.country="">

		<cfquery name="getloc" datasource="#this.dsn#" username="#request.dbuser#" password="#request.dbpass#">
		select IP, city, state, statefull, country, continent,latitude,longitude,countrycode1 
		from geoip 
		where ip = <CFQUERYPARAM cfsqltype="cf_sql_varchar" value="#arguments.ip#">
		</cfquery>	

		<cfif getloc.recordcount GT 0>
		
			<cfscript>
			data.city = getloc.city;
			data.state = getloc.state;
			data.statefull = getloc.statefull;
			data.country = getloc.country;
			data.continent  = getloc.continent;
			data.latitude = getloc.latitude;
			data.longitude = getloc.longitude;
			data.countrycode1 = getloc.countrycode1;
			</cfscript>
			
		</cfif>
	
	<cfif getloc.recordcount is 0>
	<cftry>	
			<cfhttp url="http://www.ippages.com/xml/?ip=#ip#" method="get" useragent="IE5.5">
			
			<cfset XML = xmlparse(cfhttp.filecontent)>
			<cfset isValidIP = xml.ip_address.lookups.lookup_ip_is_valid.xmltext>
			
			<!--- for testing only 
			<cfdump var="#xml#"><CFABORT>
				--->
		
			<!--- If the ip is valid convert to struct --->
			<cfif isValidIP>
			
				<cfscript>
				data.city = xml.ip_address.lookups.lookup_city2.xmltext;
				data.state = xml.ip_address.lookups.lookup_state_province_code2.xmltext;
				data.statefull = xml.ip_address.lookups.lookup_state_province_name2.xmltext;
				data.country = xml.ip_address.lookups.lookup_country.xmltext;
				data.countrycode1 = xml.ip_address.lookups.lookup_country_code3.xmltext;
				data.longitude = xml.ip_address.lookups.lookup_longitude2.xmltext;
				data.latitude = xml.ip_address.lookups.lookup_latitude2.xmltext;
				data.continent = xml.ip_address.lookups.lookup_country_continent.xmltext;
				data.lookupcount = xml.ip_address.lookups.lookup_count.xmltext;
				data.hostname = xml.ip_address.lookups.lookup_host.xmltext;
				data.date = createODBCDateTime(now());
				</cfscript>
				
		
					<cfquery name="doinsert" datasource="#this.dsn#" username="#request.dbuser#" password="#request.dbpass#">
					insert into geoip (ip,city,state,statefull,country,countrycode1,continent,latitude,longitude,datestamp,hostname)
					values ('#arguments.ip#','#data.city#','#data.state#','#data.statefull#','#data.country#','#data.countrycode1#','#data.continent#',#data.latitude#,#data.longitude#, #data.date#,'#data.hostname#')
					</cfquery>
			<cfelse>
			<cfset data.city = "">
			</cfif>
		<cfcatch><cfset data.city = ""></cfcatch>
		</cftry>
	</cfif>			
	
	<cfreturn data>
	</cffunction>
	
</cfcomponent>