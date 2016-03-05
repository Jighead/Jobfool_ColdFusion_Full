<cfparam name="url.kw" default="developer">
<cfparam name="url.l" default="Chicago">
<cfparam name="url.p" default="1">
<cfset args = structnew()>
<cfset args.locale_code = "en_US">
<cfset args.keywords = url.kw>
<cfset args.location = url.l>
<cfset args.page = url.p>
<cfinvoke component="#request.componentpath#.careerjet" method="renderJobs" argumentcollection="#args#" returnvariable="request.jobs">

