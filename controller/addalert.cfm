<!--- for testing only
<cfparam name="form.what" default="UI ">
<cfparam name="form.what" default="UI developer">
<cfparam name="form.where" default="Orlando, fl">
<cfparam name="form.email" default="gerdsuhr@gmail.com">
--->

<!--- ********** ADD ALERT ACTION ******************* --->
<cfif isdefined('form.email') and isdefined('form.what') and isdefined('form.where')>
    <cfparam name="form.cfid" default="unknown" />
    <cfset form.kw = form.what>
    <cfset form.loc = form.where>
    <cfset form.country = request.co> 
    <cfset form.radius = '50'>
    <!--- save the form data --->
    <cfinvoke component="#request.componentpath#.jobalerts" method="addalertconfirm" argumentcollection="#form#" returnvariable="result">
    <cfoutput>
    <cfif result.status is "OK">
        <div class='col-xs-12'><h2>Sweet! You're Almost Done.</h2><p>To activate your job alert, please check your email and click the confirmation button.</p></div>
    <cfelse>
        <cfswitch expression="#result.message#">
        <cfcase value="invalid email">
            <div class="col-xs-12"><h2>Invalid Email!</h2><p>Please enter a valid email address.</p></div>
        </cfcase>
        <cfcase value="no keyword">
            <div class="col-xs-12"><h2>No Keyword or Job Title!</h2><p>Please enter a keyword or job title.</p></div>
        </cfcase>
        <cfcase value="no location">
            <div class="col-xs-12"><h2>No Location!</h2><p>Please enter a state, city or zip/postal code.</p></div>
        </cfcase>
        <cfcase value="duplicate">
            <div class="col-xs-12"><h2>Duplicate Job Alert!</h2><p>You already have a job alert with these exact parameters.</p></div>
        </cfcase>
        <cfdefaultcase>    
        <div class="col-xs-12"><h2>Sorry for the Inconvenience.</h2><p>The email alert system is undergoing maintenance.</p></div>    
        </cfdefaultcase>
        </cfswitch> 
    </cfif>
    </cfoutput>
</cfif>