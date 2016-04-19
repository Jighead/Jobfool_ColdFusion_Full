<!--- ********** ADD ALERT ACTION ******************* --->
<cfif isdefined('form.email') and isdefined('form.what') and isdefined('form.where')>
    <cfset form.kw = form.what>
    <cfset form.loc = form.where>
    <cfset form.country = request.co> 
    <cfset form.radius = '50'>
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
        <cfinvoke component="#request.componentpath#.jobalerts" method="addalertconfirm" argumentcollection="#form#" returnvariable="result">
        <cfif isdefined("result") and result is "true">
        <cfelse>
        error
        </cfif>
<cfelse>
    error  
</cfif>
    
    
    