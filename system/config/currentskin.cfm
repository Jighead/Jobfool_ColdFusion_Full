<cfif not isDefined('application.skin') or isDefined('url.reinit')>
<!--- TODO: Get this from the DB --->
	<cfset application.skin = "default">
</cfif>
