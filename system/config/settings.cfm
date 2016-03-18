<cfscript>
application.root = replace(expandPath("."), "/system/config", "", "one");
request.componentpath = "system.components";
request.dsn = "jobs";
request.dbuser = "jobfool";
request.dbpass = "5berlin5";
request.perpage ="10";
//application.skin = "default";
application.partner="indeed";
//application.PublisherID = "3384564181756091";
application.SimplyHiredID = "";
application.BeyondID="";
application.skinpath = "/themes/";
</cfscript>
