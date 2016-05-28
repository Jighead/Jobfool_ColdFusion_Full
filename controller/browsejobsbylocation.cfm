<cfsilent>
<cfparam name="url.l" default="">
<cfif request.co eq 'GB'>

    <cfparam name="url.l" default="England">
    <cfif len(url.l) LT 2><cfset url.l='England'></cfif>
    <cfif url.l is "England"><cfset loc = "eng"><cfset url.co="gb"></cfif>
	<cfif url.l is "Northern Ireland"><cfset loc = "NIR"><cfset url.co="gb"></cfif>
    <cfif url.l is "wales"><cfset loc = "wls"><cfset url.co="gb"></cfif>
    <cfif url.l is "scotland"><cfset loc = "sct"><cfset url.co="gb"></cfif>
    <cfinvoke component="#request.componentpath#.browsejobs" 
              method="getCitiesByCountry" 
              country="#loc#" 
              returnvariable="cities">
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
