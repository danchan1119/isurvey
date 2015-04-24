<cfsetting enablecfoutputonly=true>
<!---
	Name         : handlers/truefalse/save.cfm
	Author       : Raymond Camden 
	Created      : September 21, 2004
	Last Updated : March 30, 2006
	History      : tableprefix fix (rkc 3/30/06)
	Purpose		 : Supports True/False, Yes/No
--->

<cfparam name="attributes.answer">
<cfparam name="attributes.questionidfk">
<cfparam name="attributes.owner">

<cfif len(attributes.answer)>
	<cfquery datasource="#application.settings.dsn#">
		insert into #application.settings.tableprefix#results(owneridfk,questionidfk,truefalse,textbox)
		values(
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="320" value="#attributes.owner#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="35" value="#attributes.questionidfk#">,
			<cfif attributes.answer is "false">
				<cfqueryparam cfsqltype="#application.utils.getQueryParamType(application.settings.dbtype,"CF_SQL_BIT")#" value="#attributes.answer#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="255" value="">
			<cfelse>
				<cfqueryparam cfsqltype="#application.utils.getQueryParamType(application.settings.dbtype,"CF_SQL_BIT")#" value="true">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="255" value="#left(attributes.answer,255)#">
			</cfif>
		)
	</cfquery>
</cfif>
				
<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">