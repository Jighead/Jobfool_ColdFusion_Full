<!--- ********** ADD ALERT ACTION ******************* --->
<cfif isdefined('form.email') and isdefined('form.what') and isdefined('form.where')>
    <cfset form.kw = form.what>
    <cfset form.loc = form.where>
    <!--- <cfparam name="form.firstname"  default= "-"> --->
    <cfparam name="error" default="false" type="boolean">
	
    <!--- <cfif not isEmail(#form.email#)>
        <cfset error = true>
    </cfif> --->

    <cfif len(form.what) lt 2>
        <cfset error = true>
    </cfif>
        
    <cfif len(form.where) lt 3>
        <cfset error = true>
    </cfif>
        
</cfif>

<cfif error is false>
        <!--- save the form data --->
        <cfset uuid = "gerd1234">
        <cfset form.cfid="#uuid#">
            
        <cfinvoke component="#request.componentpath#.jobalerts" method="addalert" argumentcollection="#form#" returnvariable="result">
            <cfdump var="#result#"><cfabort>
        <cfif isdefined("alert") and alert is "true">
            success
        <cfelse>
            error
        </cfif>
<cfelse>
    error  
</cfif>
    
    
    