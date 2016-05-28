<cfsilent>

    <cfinvoke component="#request.componentpath#.browsejobs"   method="getCategories" 
              returnvariable="categories">	
	<cfset thistitle = "Job Search - Jobs By Category">

</cfsilent>
<!---<cfdump var="#categories#"><cfabort>--->