<cfcomponent>

	<cfset variables.locale_code = "">
	<cfset variables.keywords = "">
    <cfset variables.location ="">
    <cfset variables.radius ="">
    <cfset variables.start_num = "start_num">
    <cfset variables.page = "">
    <cfset variables.pagesize = "">
    <cfset variables.sort = "">
    <cfset variables.contracttype = ""> 
    <cfset variables.publisher = "3">
    
    
    
    <cffunction name="renderJobs" access="public" returntype="string" output="true" description="I'm the public function to get the jobs. I return HTML">
        <cfargument name="locale_code" type="string" default="en_US" required="true">
        <cfargument name="keywords" type="string" default="">
        <cfargument name="location" type="string" default="">
        <cfargument name="page" type="string" default="1">
        <cfargument name="start_num" type="string" default="1">
        <cfargument name="sort" type="string" default="relevance">
        <cfargument name="pagesize" type="string" default="20">
        <cfargument name="radius" type="string" default="30" required="yes">

        <cfset var link = buildLink(arguments) />
        <cfset var data = getdata(link) />

        
        <cfset XMLData = xmlParse(data)>

<!--- <cfdump var="#XMLData#">
    <cfabort>  ---> 
        
       
        <cfif isDefined('XMLData.sherror')>
			<cfset locNodes = xmlSearch(XMLData,'/sherror/error/option')>
                <cfsavecontent variable="htmloutput">
                <div id="jbox" class="choose-loc">
 				<cfloop from="1" to="#arrayLen(locnodes)#" index="i">
       		<a href="http://#cgi.server_name#/jobs/index.cfm/kw/#url.kw#/l/#locNodes[i].xmltext#/radius/#url.radius#/p/#url.p#/sb/#url.sb#/">#locNodes[i].xmltext#</a><br>
        		</cfloop>
                </div>
      			</cfsavecontent>
                <return htmloutput>
             
        <cfelse>
			<cfset baseNode = xmlSearch(XMLData,'/shrs/rq')>
            <cfloop from="1" to="#arrayLen(basenode)#" index="i">
            <cfif #basenode[1].tr.xmltext# gt 0 >
                <cfset request.totalrecords = #basenode[i].tr.xmltext#>
                <cfset request.totalviewable = #basenode[i].tv.xmltext#>
            </cfif>
            </cfloop>
            
            <!--- If we have more than 2 results output the results HTML --->
            <cfif request.totalviewable GT 2 >
				<cfset jobnodes = xmlSearch(XMLData,'/shrs/rs/r')>
<!---                 <cfdump var="#jobnodes#"> --->


                
                <cfset htmloutput = buildHTML(JobNodes) />
            
            </cfif>
        </cfif>
        
        <cfreturn htmloutput>

    </cffunction>
    
    
  	<cffunction name="buildHTML" access="private" returntype="string" description="I build the HTML job results output" output="true">
        <cfargument name="data" required="yes" type="array">
        <cfset var html = "" />
        
        
    <!---             <cfoutput>
                <!--- we probably want toc conver this to a query just like the indeed version --->
                <cfsavecontent variable="htmloutput">
                    <cfloop from="1" to="#arrayLen(jobnodes)#" index="i">
                         Title =  #jobnodes[i].jt.xmltext#<br>
                         description = #jobnodes[i].e.xmltext#<br>
                         location = #jobnodes[i].loc.xmltext#<br>
                         zipcode = #jobnodes[i].loc.xmlAttributes.postal#<br>
                         <cfset date = left(jobnodes[i].dp.xmltext,"10")>
                         posted on #date# #jobnodes[i].dp.xmltext#<br>
                         source = #jobnodes[i].src.xmltext#<br>
                         company = #jobnodes[i].cn.xmltext#<br>
                         URL = #jobnodes[i].src.xmlattributes.url#<br>
                    </cfloop>
                </cfsavecontent>
				</cfoutput> --->
        
        
        <cfsavecontent variable="html"> 
       
        <cfloop from="1" to="#arrayLen(data)#" index="i">
         <div id="jbox" class="choose-loc" style="border:1px solid silver; margin-bottom:10px;">
           <!--- note change this url to correct url for production --->
           <a class="jobtitle" href="#data[i].src.xmlattributes.url#">#data[i].jt.xmltext#</a>
           <span class="jobcompany" style="color:silver">#data[i].cn.xmltext# - </span> <span class="jobloc" style="color:silver">#data[i].loc.xmltext#</span>
           <span class="jobdescription">#data[i].e.xmltext#</span>
           <span class="jobposted">Posted on #data[i].dp.xmltext#</span><br>
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
             
        <cfset link = "http://api.simplyhired.com/a/jobs-api/xml-v2/q-#arguments.arg.keywords#/l-#arguments.arg.location#/ws-#arguments.arg.pagesize#/pn-#arguments.arg.page#/mi-#arguments.arg.radius#/sb-#arguments.arg.sb#?pshid=25886&ssty=2&cflg=r&jbd=jobfool.jobamatic.com&clip=#cgi.remote_addr#">
        
        
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
   
   
  
<cffunction name="XmlToStruct" access="public" returntype="struct" output="false"
				hint="Parse raw XML response body into ColdFusion structs and arrays and return it.">
	<cfargument name="xmlNode" type="string" required="true" />
	<cfargument name="str" type="struct" required="true" />
	<!---Setup local variables for recurse: --->
	<cfset var i = 0 />
	<cfset var axml = arguments.xmlNode />
	<cfset var astr = arguments.str />
	<cfset var n = "" />
	<cfset var tmpContainer = "" />
	
	<cfset axml = XmlSearch(XmlParse(arguments.xmlNode),"/node()")>
	<cfset axml = axml[1] />
	<!--- For each children of context node: --->
	<cfloop from="1" to="#arrayLen(axml.XmlChildren)#" index="i">
		<!--- Read XML node name without namespace: --->
		<cfset n = replace(axml.XmlChildren[i].XmlName, axml.XmlChildren[i].XmlNsPrefix&":", "") />
		<!--- If key with that name exists within output struct ... --->
		<cfif structKeyExists(astr, n)>
			<!--- ... and is not an array... --->
			<cfif not isArray(astr[n])>
				<!--- ... get this item into temp variable, ... --->
				<cfset tmpContainer = astr[n] />
				<!--- ... setup array for this item beacuse we have multiple items with same name, ... --->
				<cfset astr[n] = arrayNew(1) />
				<!--- ... and reassing temp item as a first element of new array: --->
				<cfset astr[n][1] = tmpContainer />
			<cfelse>
				<!--- Item is already an array: --->
				
			</cfif>
			<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
					<!--- recurse call: get complex item: --->
					<cfset astr[n][arrayLen(astr[n])+1] = XmlToStruct(axml.XmlChildren[i], structNew()) />
				<cfelse>
					<!--- else: assign node value as last element of array: --->
					<cfset astr[n][arrayLen(astr[n])+1] = axml.XmlChildren[i].XmlText />
			</cfif>
		<cfelse>
			<!---
				This is not a struct. This may be first tag with some name.
				This may also be one and only tag with this name.
			--->
			<!---
					If context child node has child nodes (which means it will be complex type): --->
			<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
				<!--- recurse call: get complex item: --->
				<cfset astr[n] = XmlToStruct(axml.XmlChildren[i], structNew()) />
			<cfelse>
				<!--- else: assign node value as last element of array: --->
				<!--- if there are any attributes on this element--->
				<cfif IsStruct(aXml.XmlChildren[i].XmlAttributes) AND StructCount(aXml.XmlChildren[i].XmlAttributes) GT 0>
					<!--- assign the text --->
					<cfset astr[n] = axml.XmlChildren[i].XmlText />
						<!--- check if there are no attributes with xmlns: , we dont want namespaces to be in the response--->
					 <cfset attrib_list = StructKeylist(axml.XmlChildren[i].XmlAttributes) />
					 <cfloop from="1" to="#listLen(attrib_list)#" index="attrib">
						 <cfif ListgetAt(attrib_list,attrib) CONTAINS "xmlns:">
							 <!--- remove any namespace attributes--->
							<cfset Structdelete(axml.XmlChildren[i].XmlAttributes, listgetAt(attrib_list,attrib))>
						 </cfif>
					 </cfloop>
					 <!--- if there are any atributes left, append them to the response--->
					 <cfif StructCount(axml.XmlChildren[i].XmlAttributes) GT 0>
						 <cfset astr[n&'_attributes'] = axml.XmlChildren[i].XmlAttributes />
					</cfif>
				<cfelse>
					 <cfset astr[n] = axml.XmlChildren[i].XmlText />
				</cfif>
			</cfif>
		</cfif>
	</cfloop>
	<!--- return struct: --->
	<cfreturn astr />
</cffunction>

   

   
   </cfcomponent>
   