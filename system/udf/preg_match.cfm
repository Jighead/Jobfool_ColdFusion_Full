<cfscript>
/**
 * Emulates the preg_match function in PHP for returning a regex match along with any backreferences.
 * 
 * @param regex 	 Regular expression. (Required)
 * @param str 	 String to search. (Required)
 * @return Returns an array. 
 * @author Aaron Eisenberger (&#97;&#97;&#114;&#111;&#110;&#64;&#120;&#45;&#99;&#108;&#111;&#116;&#104;&#105;&#110;&#103;&#46;&#99;&#111;&#109;) 
 * @version 1, February 15, 2004 
 * http://www.cflib.org/index.cfm?event=page.udfbyid&udfid=1042
 ******** use example ******************************************************
 * <cfset domain=preg_match("([^\.\/]+)\.([^\.\/]+$)", cgi.server_name)>
 * <cfdump var="#domain#">
 ***************************************************************************
 */
function preg_match(regex,str) {
	var results = arraynew(1);
	var match = "";
	var x = 1;
	if (REFind(regex, str, 1)) { 
		match = REFind(regex, str, 1, TRUE); 
		for (x = 1; x lte arrayLen(match.pos); x = x + 1) {
			if(match.len[x])
				results[x] = mid(str, match.pos[x], match.len[x]);
			else
				results[x] = '';
		}
	}
	return results;
}
</cfscript>