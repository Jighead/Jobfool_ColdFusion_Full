<cfcomponent>
	<cffunction name="sendsingle" access="public" returntype="boolean" output="yes" hint="for job detail page form">
		<cfargument name="fromemail" type="string" required="yes">
        <cfargument name="toemail" type="string" required="yes">
        <cfargument name="meto" type="boolean" required="yes" default="0" hint="Send the sender and copy?">
        <cfargument name="subject" type="string" required="no">
        <cfargument name="body" type="string" required="yes" default="">
        <cfargument name="type" required="yes" default="html" hint="HTML or Text">
        <cfargument name="server" required="no" default="69.67.29.95">
        
        

        <cfif arguments.subject is "">
        	<cfset arguments.subject = "Job listing referral from #arguments.fromemail#">
        </cfif>
        
        
 
        
            <cfmail from="#arguments.fromemail#" to="#arguments.toemail#" subject="#arguments.subject#" type="html">
            #arguments.body#
            </cfmail>
            
            <cfmail from="singlemail@thejobfool.com" to="jobfool@gmail.com" subject="#arguments.subject#" type="html">
            #arguments.fromemail# sent to #arguments.toemail#<br>
            
            #arguments.body#
            </cfmail>
            
            <cfif arguments.meto>
            <cfmail from="#arguments.fromemail#" to="#arguments.fromemail#" subject="#arguments.subject#" type="html">
            #arguments.body#
            </cfmail> 
            </cfif>
  
        
		<cfreturn "1">
	</cffunction>
</cfcomponent>