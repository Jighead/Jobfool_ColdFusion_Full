<cfsilent>
<cfparam name="url.l" default="">
<cfif request.co eq 'gb'>
    <cfparam name="url.l" default="England">
    <cfif url.l is "England"><cfset loc = "eng"><cfset url.co="gb"></cfif>
	<cfif url.l is "northern ireland"><cfset loc = "NIR"><cfset url.co="gb"></cfif>
    <cfif url.l is "wales"><cfset loc = "wls"><cfset url.co="gb"></cfif>
    <cfif url.l is "scotland"><cfset loc = "sct"><cfset url.co="gb"></cfif>
    <cfinvoke component="#request.componentpath#.browsejobs" 
              method="getCitiesByCountry" 
              country="#loc#" 
              returnvariable="getCities">
<cfelse>
	<cfif len(url.l) GTE 4 and not isNumeric(url.l)>
        <cfinvoke component="#request.componentpath#.browsejobs"  
                  method="getCitiesByCountry"   
                  country="#request.co#"  
                  state='#url.l#' 
                  returnvariable="cities" />
    <cfelse>
        
        <cfinvoke component="#request.componentpath#.browsejobs"  
          method="getStates"   
          returnvariable="states" />
        
    </cfif>
</cfif>
</cfsilent>