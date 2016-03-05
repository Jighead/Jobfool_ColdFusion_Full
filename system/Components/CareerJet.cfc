<cfcomponent>

	<cfset variables.locale_code = "">
	<cfset variables.keywords = "">
    <cfset variables.location ="">
    <cfset variables.start_num = "start_num">
    <cfset variables.page = "">
    <cfset variables.pagesize = "">
    <cfset variables.sort = "">
    <cfset variables.contracttype = ""> 
    <cfset variables.publisher = "3">
    
    
    
    <cffunction name="renderJobs" access="public" returntype="string" output="true" description="I'm the public function to get the jobs. I return HTML">
        <cfargument name="locale_code" type="string" default="en_US">
        <cfargument name="keywords" type="string" default="">
        <cfargument name="location" type="string" default="">
        <cfargument name="page" type="string" default="1">
        <cfargument name="start_num" type="string" default="1">
        <cfargument name="sort" type="string" default="relevance">
        <cfargument name="pagesize" type="string" default="20">

        <cfset var link = buildLink(arguments) />
        <cfset var jsondata = getdata(link) />
        <cfset var JobStruct = DeserializeJSON( jsondata )>
		<cfset var query = struct2Query(jobstruct) />
        

        <cfif isDefined('jobstruct.solveLocations')>
                <cfsavecontent variable="htmloutput">
                <div id="jbox" class="choose-loc">
                <cfoutput>
                   <cfloop from="1" to="#arrayLen(jobstruct.solveLocations)#" index="i">
                   <!--- note change this url to correct url for production --->
                    <a href="/sandbox/cfm/careerjet.cfm/kw/#arguments.keywords#/l/#jobstruct.solveLocations[i].name#/">#jobstruct.solveLocations[i].name# </a><br>
                  </cfloop> 
                  </cfoutput>
                </div>
                </cfsavecontent>
                <return htmloutput>
        <cfelse>
			<cfset htmloutput = buildHTML(JobStruct) />
        </cfif>
        
        <cfreturn htmloutput>

    </cffunction>
    
    
  	<cffunction name="buildHTML" access="private" returntype="string" description="I build the HTML job results output" output="true">
        <cfargument name="data" required="yes" type="struct">
        <cfset var html = "" />
        <cfset var request.jobtotals = "" />
        <cfset var request.jobpages = "" />
        <cfsavecontent variable="html"> 
        
        
        <!--- #data.hits# jobs found<br> --->
        
        <cfset request.jobtotals = data.hits>   
        <cfset request.jobpages = data.pages> 
  
        <cfloop from="1" to="#arrayLen(data.jobs)#" index="i">
         <div id="jbox" class="choose-loc">
           <!--- note change this url to correct url for production --->
           <a class="jobtitle" href="#data.jobs[i].url#" rel="nofollow">#data.jobs[i].title#</a>
           <span class="jobcompany">#data.jobs[i].company# - </span> <span class="jobloc" style="color:silver">#data.jobs[i].locations#</span>
           <span class="jobdescription">#data.jobs[i].description#</span>
           <!--- <a class="joburl" href="#data.jobs[i].url#"  rel="nofollow">#data.jobs[i].site#</a> --->
         </div>
        </cfloop>
        
        </cfsavecontent>
        
        <cfreturn html>
   </cffunction>
      
   <cffunction name="struct2Query" access="private" returntype="any" description="I convert a struct to a query">
      <cfargument name="theStruct" type="struct" required="true" />
  
		<cfset var key    = "" />
        <cfset var myQuery  = queryNew(structKeyList(arguments.theStruct)) />
    
        <cfset queryAddRow(myQuery, 1) />  
    
        <cfloop collection="#theStruct#" item="key">
            <cfset querySetCell(myQuery, key, arguments.theStruct[key])/>
        </cfloop>
      
        <cfreturn myQuery />  
   </cffunction>
    
    
    
	
   <cffunction name="buildLink" access="private" returntype="string" description="I build the API url">
    <cfargument name="arg" type="struct" required="yes">

            <cfif isdefined('arguments.arg.keywords') and len(arguments.arg.keywords)>
                <!--- remove all non-alpha numeric characters --->
                <cfset arguments.arg.keywords = REreplace(arguments.arg.keywords, "[^\\\w]", "_", "all")>
            </cfif>
        
        <cfset link = "http://public.api.careerjet.net/search?locale_code=#arguments.arg.locale_code#&keywords=#arguments.arg.keywords#&location=#arguments.arg.location#&page=#arguments.arg.page#&start_num=#arguments.arg.start_num#&sort=#arguments.arg.sort#&pagesize=#arguments.arg.pagesize#">
        
        <cfreturn link>
   </cffunction>
    
   <cffunction name="getData" access="public" returntype="string" description="I build the API url">
   	<cfargument name="APIurl" type="string" required="yes">
    
    	<cfhttp method="get" url="#arguments.APIurl#" timeout="5" />
        
        <cfif cfhttp.Responseheader.Status_Code EQ "200">
        	<cfreturn cfhttp.filecontent>
        <cfelse>
        	<cfset error = "An Error has occured!">
            <cfreturn error>
        </cfif>

   </cffunction>
   

   
   </cfcomponent>
   