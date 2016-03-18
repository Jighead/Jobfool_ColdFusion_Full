<cfcomponent>
    <!---
    see your account at import.io it was created with your google account to login.
    you created an API to scape indeed.com job salaries
        Username: user51326579
        USERID: bdeda0eb-c3bb-4fd6-9654-665170086753
    --->
    <cfset _import.io.apikey = "bdeda0ebc3bb4fd696546651700867539b2fc649b94c893d3b91041f2f9a9c5cb2b8b270c42c59c85f7431457bebf0caebfc8f76554755aa5271a87efbdcc34a2f00868f478f906b8a1868a5f1311519">

    <cffunction name="getSalary">
        <cfargument name="qry" default="sales">
        <cfargument name="loc" default="Atlanta">  

        <cfif len(arguments.qry) or len(arguments.loc)>
            <cfset var indeedurl = urlencodedformat("http://www.indeed.com/salary?q1=#arguments.qry#&l1=#arguments.loc#&tm=1")>
            <cfset var importurl = "https://api.import.io/store/connector/_magic?url=#indeedurl#&format=JSON&js=false&_apikey=#_import.io.apikey#">
                
            <cfhttp url="#importurl#" method="get">

            <cfif cfhttp.statuscode EQ "200 OK">
                <cfset resultsJSON = replace(cfhttp.filecontent, "/_", "_", "all")>
                <cfset resultsStruct = deserializeJSON(resultsJSON)>  
                <cfset resultsArray = resultsStruct.tables[1].results>              
            <CFELSE>
                <cfset resultsArray = "ERROR">
            </cfif>

        <cfelse>
            <cfset resultsArray = "">
        </cfif>

            <cfreturn resultsArray>
    </cffunction>
    
</cfcomponent>
