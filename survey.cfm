<cfheader name="P3P" value="CP=""CAO PSA OUR""">
<cfsetting enablecfoutputonly=true>
<!---
	Name         : survey.cfm
	Author       : Daniel Chan
	Created      : February 20, 2013
	Last Updated : 
	History      : added default & custom template
	Purpose		 : Displays a survey
--->
<cfimport taglib="./tags/" prefix="tags">

<cfif not isDefined("url.id") or not len(url.id)>
	<cflocation url="index.cfm" addToken="false">
</cfif>
<cftry>
	<cfset survey = application.survey.getSurvey(url.id)>
	<cfif not survey.active or (survey.datebegin neq "" and dateCompare(survey.datebegin,now()) is 1) or 
			(survey.dateend neq "" and dateCompare(now(), survey.dateend) is 1)>
		<cflocation url="./error/expire.cfm" addToken="false">
	</cfif>
	<cfif survey.templateidfk neq "">
		<cfset template = application.template.getTemplate(survey.templateidfk)>
	</cfif>
	<cfcatch>
		<cflocation url="index.cfm" addToken="false">
	</cfcatch>
</cftry>

<cfif structKeyExists(url, "embed")>
	<cfoutput><link rel="stylesheet" type="text/css" href="stylesheets/embed.css" media="screen, projection"></link></cfoutput>
	<tags:surveydisplay survey="#survey#" />
<cfelseif not structKeyExists(variables, "template")>
	<!--- Loads header --->
	<tags:layout templatename="default" title="#survey.name#">
		<cfoutput><div class="content">
			<tags:surveydisplay survey="#survey#"/>
		</div></cfoutput>
	</tags:layout>
<cfelse>
	<tags:layout templatename="#template.name#" title="#survey.name#">
	<cfoutput><div class="content">#template.header#</cfoutput>
	<tags:surveydisplay survey="#survey#" />
	<cfoutput>#template.footer#</cfoutput>
	</tags:layout>
</cfif>
<cfsetting enablecfoutputonly=false>
