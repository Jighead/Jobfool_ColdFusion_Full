<cfcomponent>

    <cfset _import.io.apikey = "bdeda0ebc3bb4fd696546651700867539b2fc649b94c893d3b91041f2f9a9c5cb2b8b270c42c59c85f7431457bebf0caebfc8f76554755aa5271a87efbdcc34a2f00868f478f906b8a1868a5f1311519">

    <cffunction name="getSalary" output="false">
        <cfargument name="qry" default="">
        <cfargument name="loc" default="">  

        <cfif len(arguments.qry) or len(arguments.loc)>
            <cfset indeedurl = urlencodedformat("http://www.indeed.com/salary?q1=#qry#&l1=#loc#&tm=1")>
            <cfset importurl = "https://api.import.io/store/connector/_magic?url=#indeedurl#&format=JSON&js=false&_apikey=#import.io.apikey#">
            <cfhttp result="result" url="#importurl#" method="get">

            <cfif result.Responseheader.status_code id "200">
                <cfreturn result>
            <cfelse>
                <cfset result = "error">   
            </cfif>

        <cfelse>
            <cfset result = "">
        </cfif>

            <cfreturn result>
    </cffunction>
    
    
</cfcomponent>
