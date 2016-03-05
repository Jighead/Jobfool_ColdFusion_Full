<cfcomponent>	
	<cffunction name="zipLocation" access="public" hint="Given a zip code, it will look up the city and state">
		<cfargument name="zip" type="string" required="true">
		
		<cfquery name="qGetZip" datasource="sc">
			select city,state
			from zipcode
			where zipcode = <cfqueryparam value="#zip#" cfsqltype="CF_SQL_CHAR">
		</cfquery>
		
		<cfreturn qGetZip>
    </cffunction>

	<cffunction name="zipToLL" access="public">
		<!--- 
			This is a helper function.  Given a zip code, it will look up the
			relevant lats and longs (and their corresponding values in radians)
			and then pass back a structure containing this information --->
			
		<cfargument name="zip" type="string" required="true">
		
		<!--- gets a new coordinate pair --->
		<cfset cp = getNewCoordinate()>	
		
		<cfquery name="qGetLL" datasource="sc">
		select latitude, longitude
		from zipcode
		where zipcode = <cfqueryparam value="#zip#" cfsqltype="CF_SQL_CHAR">
		and latitude IS NOT NULL  <!--- tpullis fix --->
		</cfquery>
		
		<cfif qGetLL.recordcount gt 0>
			<cfset cp.latitude		= qGetLL.latitude>
			<cfset cp.longitude		= qGetLL.longitude>
			<cfset cp.rlatitude 	= 0> <!--- qGetLL.rlatitude> --->
			<cfset cp.rlongitude 	= 0> <!--- qGetLL.rlongitude> --->
		</cfif>
		
		<cfreturn cp>
    </cffunction>

	<!--- +++++++++++++++++++++++++++++++++++++++++++++ --->		
	
	<cffunction name="getNewCoordinate" access="public">
		<!--- 
			Basically, this is a constructor that gives us a blank coordinate pair.
		 --->
		 
		<cfset retVal 				= structNew()>
		<cfset retVal.latitude		= 0>
		<cfset retVal.longitude		= 0>
		<cfset retVal.rlatitude		= 0>
		<cfset retVal.rlongitude	= 0>
		<cfreturn retVal>		
    </cffunction>
	
	
	<!--- +++++++++++++++++++++++++++++++++++++++++++++ --->		
	
	<cffunction name="squareSearch" access="public">	
		<!--- 
			This function performs a proximity search by building out a rectangle
			from a given set of coordinates, and then returning matching items that
			fall within that area.  It is not the most accurate way to search, but 
			for smaller distances, it is okay.  It is also very fast. 
		--->
		<cfargument name="radius" 	type="numeric" 	required="true">
		<cfargument name="zip" 		type="string" 	required="true">
		
		<cfset radius 		= arguments.radius>
		<cfset zip			= arguments.zip>		
		<cfset z1			= zipToLL(zip)>
		
		<cfset lat_miles	= 69.1>	<!--- You can change this if you need more precision --->
		<cfset lon_miles	= abs(lat_miles * cos(z1.latitude * 0.0174))>
		<cfset lat_degrees	= radius / lat_miles>
		<cfset lon_degrees	= radius / lon_miles>
		
		<!--- This is where we calculate the bounds of the search rectangle --->
		<cfset lat1			= z1.latitude - lat_degrees>
		<cfset lat2			= z1.latitude + lat_degrees>
		<cfset lon1			= z1.longitude - lon_degrees>
		<cfset lon2			= z1.longitude + lon_degrees>
		
		
		<!--- 
			To perform the search, we're going to use trigonometry.  Remember the equation, x^2 + y^2 = z^2, 
			aka the Pythazizzle Thizzle? If you look closely, you can see that we are using that in order 
			to calculate the distance (dist) in the query below.
			
			This is good, because it is a fast calculation.  But, it is bad because it is calculating the 
			distance as if it were a line.  If the world were flat, this would be perfect.  But, since it isn't,
			this will start to show errors the larger the radius gets.
			
			Still, for your applications, the errors might be small enough to justify the BLAZING SPEED.
		 --->
		<cfquery name="qSquareSearch" datasource="sc">
			select 	zipcode as zip, state, city,
				SQRT(SQUARE(#lat_miles# * (latitude - (#z1.latitude#))) 
					+
					square(#lon_miles# * (longitude - (#z1.longitude#)))
					) as dist
			from zipcode
			where latitude between #lat1# AND #lat2#
			AND longitude between #lon1# AND #lon2#
			order by dist asc
		</cfquery>
		
		<!--- 
			This is just a quick filter query that will remove some of the zips that get erroneously
			included in the result set.  This helps to offset the errors that this method introduces, 
			but only just a little.
		 --->
		<cfquery name="qRefine" dbtype="query">
		select * from qSquareSearch where dist < <cfqueryparam value="#radius#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>
		
		<cfreturn qRefine>	
    </cffunction>
	
	<!--- +++++++++++++++++++++++++++++++++++++++++++++ --->	
	
	<cffunction name="pythagoreanSearch" access="public">	
		<!--- 
			This function performs a proximity search by using the pythagorean theorum.  
			It's really similar to the above search, but actually calculates the distance instead
			of using a bounding bo.
		--->
		<cfargument name="radius" 	type="numeric" 	required="true">
		<cfargument name="zip" 		type="string" 	required="true">
		
		<cfset radius 		= arguments.radius>
		<cfset zip			= arguments.zip>		
		<cfset z1			= zipToLL(zip)>
		
		<cfset lat_miles	= 69.1>	<!--- You can change this if you need more precision --->
		<cfset lon_miles	= abs(lat_miles * cos(z1.latitude * 0.0174))>
		
		<!--- 
			To perform the search, we're going to use trigonometry.  Remember the equation, x^2 + y^2 = z^2, 
			aka the Pythazizzle Thizzle? If you look closely, you can see that we are using that in order 
			to calculate the distance (dist) in the query below.
			
			This is good, because it is a fast calculation.  But, it is bad because it is calculating the 
			distance as if it were a line.  If the world were flat, this would be perfect.  But, since it isn't,
			this will start to show errors the larger the radius gets.
		 --->
		<cfquery name="qPythagoreanLookup" datasource="sc">
		select 	zip, state, city,
			SQRT(
					SQUARE(#lat_miles# * (latitude - (#z1.latitude#))) 
					+
					square(#lon_miles# * (longitude - (#z1.longitude#)))
				) as dist
		from 	zipcodes
		where
			SQRT(
					SQUARE(#lat_miles# * (latitude - (#z1.latitude#))) 
					+
					square(#lon_miles# * (longitude - (#z1.longitude#)))
				) < #radius#
			
		order by dist asc
		</cfquery>
		
		<cfreturn qPythagoreanLookup>	
    </cffunction>
	
	<!--- +++++++++++++++++++++++++++++++++++++++++++++ --->	
	
	<cffunction name="slcSearch" access="public">
		<!--- 
			This search uses the spherical law of cosines to conduct the proximity search.  
			Supposedly, this search has some drawbacks on small distances.  But, it seems
			to work like a charm through my testing.  YMMV.
			
			A = arccos{sinY1sinY2+cosY1cosY2cos(X2-X1)}
		 --->
	
		<cfargument name="radius" 	type="numeric" 	required="true">
		<cfargument name="zip" 		type="string" 	required="true">
		
		<cfset radius 		= arguments.radius>
		<cfset zip			= arguments.zip>		
		<cfset z1			= zipToLL(zip)>
		
		<cfquery name="qSphericalLawofCosinesSearch" datasource="sc">
		
		select zip,state,city,
			acos(
				(sin(#z1.rlatitude#)*sin(rlatitude))
				+
				(cos(#z1.rlatitude#)*cos(rlatitude)*cos(rlongitude-(#z1.rlongitude#)))
				) * #3956#
			as dist
		from 
			zipcodes
		where
			acos(
				(sin(#z1.rlatitude#)*sin(rlatitude))
				+
				(cos(#z1.rlatitude#)*cos(rlatitude)*cos(rlongitude-(#z1.rlongitude#)))
				) * #3956#
			 < <cfqueryparam value="#radius#" cfsqltype="CF_SQL_INTEGER">
		order by dist
		</cfquery>
	
		<cfreturn qSphericalLawofCosinesSearch>
	</cffunction>
	
	<!--- +++++++++++++++++++++++++++++++++++++++++++++ --->		
		
	<cffunction name="haversineSearch" access="public">
		<!---
		  This performs a proximity search by using the Haversine Formula.  
		  This is a much more accurate way of doing it, but it is also a lot slower.
		  
			//The Haversine Formula
		   		dLon (difference in longitude)	= longitude 2 - longitude 1
		        dLat (difference in latitude)	= latitude 2 - latitude 1
				
		        a = sin^2(dLat/2) + cos(latitude 1) * cos(latitude 2) * sin^2(dLon /2)
		        c = 2 * arcsin(min(1,sqrt(a)))
		        distance = radius * c
		--->
		
		<cfargument name="zip" 		type="string" 	required="true">
		<cfargument name="radius" 	type="numeric" 	required="true">
		
		<cfset radius 		= arguments.radius>
		<cfset zip			= arguments.zip>		
		<cfset z1			= zipToLL(zip)>
		
		<cfquery name="qHaversineSearch" datasource="sc">
		SELECT  zip, state, city,
			(
				#3956# * 2 * 
					ASIN
						(	 
							(SQRT
								(
								POWER(SIN(((RLATITUDE-#z1.RLATITUDE#))/2),2) 
								+ COS(#z1.RLATITUDE#) 
								* COS(RLATITUDE)
								* POWER(SIN(((abs(RLONGITUDE)- (#z1.RLONGITUDE#)))/2),2) 
								)
							) 
						) 
			) AS dist
		from zipcodes
		WHERE
			(#3956# * 2 * 
				ASIN
					( 
						(SQRT
							( 
							POWER(SIN(((RLATITUDE-#z1.RLATITUDE#))/2),2) 
							+ COS(#z1.RLATITUDE#) 
							* COS(RLATITUDE) 
		                  	* POWER(SIN(((abs(RLONGITUDE)-(#z1.RLONGITUDE#)))/2),2) )
						) 
					) 
			) < <cfqueryparam value="#radius#" cfsqltype="CF_SQL_INTEGER">
		ORDER BY dist
		</cfquery>	
	
		<cfreturn qHaversineSearch>
    </cffunction>
</cfcomponent>