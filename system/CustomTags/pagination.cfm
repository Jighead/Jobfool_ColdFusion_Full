<cfsilent>
<cfif not isdefined("Attributes.recordcount")>
	<cfabort showerror="You need to pass a recordcount">
</cfif>
<cfparam name="Attributes.setRange" default="5">
<cfparam name="Attributes.perPage" default="10">
<cfparam name="Attributes.Class" default="">
<cfparam name="Attributes.GoTo" default="false">
<cfparam name="Attributes.Next" default="Next&nbsp;&raquo;">
<cfparam name="Attributes.Previous" default="&laquo;&nbsp;Previous">
<cfparam name="st" default="1">

<cfif not(isnumeric(Attributes.recordcount))>
	<cfset Attributes.recordcount = 0>
</cfif>

<cfif isDefined("Caller.P")>
	<cfset P = caller.P>
<cfelseif isDefined("attributes.p")>
	<cfset P = attributes.p>
<cfelse>
	<cfset P = 1>
</cfif>


<cfscript>
	pgs = int(Attributes.Recordcount / Attributes.perPage);
		
	if ((Attributes.Recordcount mod Attributes.perPage) neq 0)
		pgs = pgs + 1;
	if (P gt (Attributes.setRange/2)) {
		if (pgs ge (Attributes.setRange + P - (int(Attributes.setRange/2) - 1))) {
			start = p - ((Attributes.setRange/2) - 1);
			end = p + (Attributes.setRange/2);
		} else {
			start = pgs - (Attributes.setRange - 1);
			end = pgs;
		}			
	} else {
		if (pgs gt Attributes.setRange) {
			start = 1;
			end = Attributes.setRange;
		} else {
			start = 1;
			end = pgs;
		}
	}
	//qst = cgi.query_string;
	//autovars = cgi.query_string;
	//if (refind("[Pp][Nn]=[0-9]+", autovars) gt 0)
	//	autovars = rereplace(autovars, "[Pp][Nn]=[0-9]+", "", "ALL");
	//  autovars = replace(autovars, "&&", "&", "All");
	
	showst = st ;
	showend =  showst + Attributes.perPage;
</cfscript>

<!---
		<cfif cgi.path_info eq cgi.script_name>
		- we have a standard url, do nothing -
		<cfelse>
			<cfset qst="">
            <cfloop collection="#url#" item="i"> 
                 <cfoutput> 
                 <cfif i neq "p" and i neq "qt" and i neq "st" and i neq "co" and i neq "SB" and i neq "END" and i neq "radius" and i neq "kwlink">
                     <cfif len(url[i])>
                        <cfset namevalue="#i#=#url[i]#">
                        <cfset qst = listAppend(qst, "#namevalue#","&")>
                     </cfif>
                 </cfif>
                 </cfoutput> 
            </cfloop>
		</cfif>
--->  
    

			<cfset qst="">
            <cfloop collection="#url#" item="i"> 
                 <cfoutput> 
                 <cfif i neq "p" and i neq "qt" and i neq "st" and i neq "co" and i neq "SB" and i neq "END" and i neq "radius" and i neq "kwlink">
                     <cfif len(url[i])>
                        <cfset namevalue="#i#=#url[i]#">
                        <cfset qst = listAppend(qst, "#namevalue#","&")>
                        <!---#namevalue#<br>--->
                     </cfif>
                 </cfif>
                 </cfoutput> 
            </cfloop>          
                
<!---
<cfset qst1 = reReplace(qst, "[Pp]=[0-9]+", "", "all")>
<cfset qst2 = reReplace(qst1, "[Ss][Tt]=[0-9]+", "", "all")>
<cfset qst3 = reReplace(qst2, "[Aa][Cc]=[0-9]+", "", "all")>
<cfset qstr = reReplace(qst3, "&&", "&", "all")>
<cfset cfnocache = false>


<cfset qstr = replacenocase(qstr, "?", "/", "all")>
<cfset qstr = replacenocase(qstr, "=", "/", "all")>
--->
                       
<cfset qst = replacenocase(qst, " ", "+", "all")>
    
</cfsilent>  
<cfoutput>
            <div id="pagination">
            <ul class="pagination">
                <cfif P gt 1>	
                <li class="prev <cfif st eq 1>disabled</cfif>">
                <a href="#cgi.script_name#?#qst#&p=#int(url.p - 1)#&st=#st#" class="prev">#Attributes.Previous#</a>&nbsp;
                </li>
                </cfif>

                <cfif Attributes.recordcount gt Attributes.perPage>
                    <cfif start lt 1><cfset start = 1></cfif>
                    <cfloop from="#int(start)#" to="#int(end)#" step="1" index="i">
                        <cfset st = (i * attributes.perpage)-attributes.perpage+1>
                        <li class="page <cfif i eq P>active</cfif>">
                        <a href="#cgi.script_name#?#qst#&p=#i#&st=#st#" <cfif i eq P>class="cpage"<cfelse>class="page"</cfif>>#i#</a>&nbsp;
                        </li>
                    </cfloop>
                </cfif>


                <cfif int(P * Attributes.perPage) lt Attributes.recordcount>	
                    <li class="next">
                    &nbsp;<a href="#cgi.script_name#?#qst#&p=#int(P + 1)#&st=#st#" class="next">#Attributes.Next#</a>
                    </li>
                </cfif>
            </ul>
            </div>
<!---
<cfif Attributes.GoTo and pgs gt 1>
	<div id="goto">
	<cfset st = (P * attributes.perPage) +1>
	<form name="FormPageNumber" action="javascript:void(0);">Go To Page <input type="text" size="4" name="page" value="#int(P)#" class="#Attributes.class#"> of #pgs# <input type="button" onclick="javascript:cf_pagenumbers_gotof();" value="Go">
	<input type="hidden" name="st" value="#st#" />
	</form>
	<script language="JavaScript">
	<!--//
	function cf_pagenumbers_gotof() {
		var pat = /\D/g;
		if ((!(isNaN(document.FormPageNumber.page.value))) && ((document.FormPageNumber.page.value.replace(pat,"")).length != 0) && (document.FormPageNumber.page.value > 0) && (document.FormPageNumber.page.value <= #pgs#)) {
			document.location.href = '#cgi.script_name#/P/' + document.FormPageNumber.page.value + '&#jsstringformat(urldecode(qstr))#'; 
		} else { 
			alert('The Page number must be a numeric value between 1 and #pgs#'); 
		}
	}
	//-->
	</script>
	</div>
</cfif>
--->
</cfoutput>
