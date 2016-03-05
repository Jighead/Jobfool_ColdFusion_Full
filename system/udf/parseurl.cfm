	<cffunction name="parseURL" access="public" returntype="void" hint="Used on any page that uses seo urls">
	<cfscript> 
	// search engine friendly url script: parses /character back to ? & characters
	// Create links this way http://www.domain.com/page.cfm/var1/value1/var2/value2/
	   debug = 0;
	   valid_extensions = "html,htm,cfm,asp,jsp";
	   url_suffix = ".html";
	   path_to_parse = replacenocase(cgi.path_info, cgi.script_name, ""); 
	   if (listlen(path_to_parse, "/") gte 2) {
		  var_name = "";
		  for (x = 1; x lte listlen(path_to_parse, "/"); x = x + 1) {
		  if (var_name eq "") {
			 var_name = trim(listgetat(path_to_parse, x, "/"));
			 if (not refind("^[A-Za-z][A-Za-z0-9_]*$", var_name)) {
				var_name = "";
				x = x + 1;
			 }
		  } 
		  else {
			   value_to_set = listgetat(path_to_parse, x, "/");
			   if (trim(valid_extensions) neq "" and x eq listlen(path_to_parse, "/")) {
				   for (ext = 1; ext lte listlen(valid_extensions); ext = ext + 1) {
						 extension = "." & listgetat(valid_extensions, ext);
						 if (right(value_to_set, len(extension)) eq extension) {
							  value_to_set = left(value_to_set, len(value_to_set) - len(extension));
							  url_suffix = extension;
							  break;
						 }
				}
		  }
	  setvariable(var_name, value_to_set);
	  if (isdefined("debug") and debug) {
		 writeoutput("<!-- " & var_name & " = " & value_to_set & " -->" & chr(10));
	  }
	  var_name = "";
	  }
	 }
	}
	</cfscript>
	</cffunction>
