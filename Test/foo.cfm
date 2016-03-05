<cfparam name="noreturn" default="false">
<cfparam name="url.kw" default="">
<cfset intStartTime = GetTickCount() />
<cfparam name="url.l" default="">
<cfparam name="url.co" default="US">
<cfparam name="url.sb" default="">
<cfparam name="url.radius" default="50">
<cfparam name="request.grecords" default="0">
<cfparam name="url.qt" default="10"><!--- qty per page --->
<cfparam name="url.p" default="1"><!--- default page were on --->
<cfparam name="url.st" default="1"><!--- default start row were on --->
<cfparam name="url.from" default="90"><!--- default start row were on --->
<cfset url.fromage = url.from>
<cfparam name="request.intotalrecords" default="">
<cfset foo = randrange(1, 10)>


  <cfinvoke component="test._IJSON" method="get" argumentcollection="#url#" returnvariable="jobdata">











<form method="get" action="">
    <label>What</label><input type="text" name="kw" value="" id="kw">
    <label>Where</label><input type="text" name="loc" value="" id="kw">
    <input type="submit" value="search">
</form>
