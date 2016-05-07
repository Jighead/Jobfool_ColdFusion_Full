<cfset url.kw = "ux">
<cfset url.kw = "austin, tx">
<cfinvoke component="#request.componentpath#.ijson" method="getJobs" returnvariable="results"  argumentcollection="#url#">

<cfdump var="#results#"><cfabort>