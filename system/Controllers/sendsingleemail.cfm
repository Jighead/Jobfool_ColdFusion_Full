<cfsilent>
<cfparam name="form.fromemail" default="">
<cfparam name="form.toemail" default="">
<cfparam name="form.subject" default="">
<cfparam name="form.meto" default="0">
<cfparam name="result" default="">

<cfif len(form.fromemail) and isValid("email",form.fromemail) and len(form.toemail) and isValid("email",form.toemail) and form.fromemail does not contain "jobfool">

        <cfsavecontent variable="emailbody">
		<cfoutput>		
        <p>Full details can be viewed at the following link until #LSDateFormat(qrydata.EXPIRATION_DATE, "short")#.</p>

		  Job listing referral from <a href="thejobfool.com">The Job Fool</a><br />
		  <br /> 
          <strong><a href="http://thejobfool.com/jobs/detail.cfm#cgi.path_info#/">#qrydata.title#</a></strong>
          <p>#qrydata.description#</p>
          
          <small>Please visit us often at <a href="thejobfool.com">TheJobFool.com</a><br />
          We add thousands of new jobs daily!<br><br>
          <br /><br />
          </small>
		  </cfoutput>

        </cfsavecontent>
        <cfinvoke component="#request.componentpath#.emailer" method="sendsingle" 
            fromemail="#form.fromemail#" 
            toemail="#form.toemail#" 
            subject="#form.subject#"
            meto="#val(form.meto)#" 
            body="#emailbody#"
        returnvariable="result" />
        
        <cfif result is "0">
            <cfset MESSAGE = '<p class="red">THERE WAS AN ERROR SENDING YOUR EMAIL<br>Please check the information you entered in the form.</p>'>
        <cfelse>
            <cfset message = '<p class="dgreen"><big>Your email to #form.toemail# has been sent!</big></p>'>
        </cfif>
<cfelse>
<cfif isdefined('form.fieldnames')>
	<cfset MESSAGE = '<p class="red">THERE WAS AN ERROR SENDING YOUR EMAIL<br>Please check the information you entered in the form.</p>'>
</cfif>
</cfif>
</cfsilent>
<cfoutput> 
<cfif isdefined('message')>#message#</cfif>
<h4>Why not send this job to yourself or a friend?</h4>
<form method="post" action="">
<table>
<tr><td width="20%" nowrap="nowrap"><label>From My Email Address: </label></td><td><input type="text" name="fromemail" value="#form.fromemail#" class="text" /></td></tr>
<tr><td><label>To Email Address: </label></td><td><input type="text" name="toemail"  class="text" /></td></tr>
<tr><td><label>Subject: </label></td><td><input type="text" name="subject" value="#form.subject#" class="text" /></td></tr>
<tr><td><label>Send me a copy </label></td><td><input type="checkbox" name="meto" value="1" /></td></tr>
<tr><td><label></label></td><td><input type="submit" value="Send" /></td></tr>
</table>
</form>
</cfoutput>