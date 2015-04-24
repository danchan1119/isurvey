<cfsetting enablecfoutputonly=true>
<!---
	Name         : handlers/matrix/display.cfm
	Author       : Daniel Chan 
	Created      : February 23, 2013
	Last Updated : 
	History      : Added option for section header, disabled display of question number
	Purpose		 : Supports Matrix
--->

<cfparam name="attributes.question">
<cfparam name="attributes.r_result" default="result">
<cfparam name="attributes.answer">
<cfparam name="attributes.step">

<cfif not structKeyExists(attributes, "answers")>
	<cfset answers = application.question.getAnswers(attributes.question.id)>	
<cfelse>
	<cfset answers = attributes.answers>
</cfif>

<cfquery name="getAnswers" dbtype="query">
	select 		*
	from		answers
	where		rank >= 0
	order by 	rank asc
</cfquery>

<cfquery name="getItems" dbtype="query">
	select 		*
	from		answers
	where		rank < 0
	order by 	rank desc
</cfquery>

<cfif isDefined("form.submit")>
	<cfif attributes.question.required>
		<cfloop query="getItems">
			<cfif not structKeyExists(form, "q" & replace(id,"-","_","all"))>
				<cfset errors = "You must select an answer for each item.">
				<cfbreak>
			</cfif>
		</cfloop>
	</cfif>
				
	<cfif not isDefined("errors")>
		<cfset result = structNew()>
		<cfloop query="getItems">
			<cfparam name="form.q#replace(id,"-","_","all")#" default="">
			<cfset result[id] = form["q" & replace(id,"-","_","all")]>
		</cfloop>

		<!--- param for non required results --->
		<cfset caller[attributes.r_result] = result>
	</cfif>
</cfif>

	
<cfif isDefined("errors")>
	<cfoutput>
	<p class="error">#errors#</p>
	</cfoutput>
</cfif>
	
<cfoutput>
<div class="section_header"><strong>#attributes.question.header#</strong></div>
<table class="matrix">
	<tr valign="top">
		<td class="question"><!---#attributes.step#)---> #attributes.question.question# <cfif attributes.question.required EQ 1><strong class="required">*</strong></cfif></td>
	</tr>
	<tr valign="top">
		<td>
		<table class="answers" border="1" cellpadding="0">
			<tr align="center">
				<td>&nbsp;</td>
				<cfloop query="getAnswers">
					<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'><td width="145px" style="font-size:15px; vertical-align: bottom;">#answer#</td><cfelse><td width="100px" style="vertical-align: bottom;">#answer#</td></cfif>
					<!---<td width="100px">#answer#</td>--->
				</cfloop>
			</tr>
			<cfloop query="getItems">
				<cfset itemid = id>
				<cfset itemname = replace(itemid,"-","_","all")>
				<cfif itemname eq "BB93EB36_0FB5_69A0_4D753DA19886307C">
				<tr align="center">
					<th align="left" colspan="6"><b>Online Advice</b><br/></td>
				</tr>
				</cfif>
				<cfif itemname eq "BB93EB16_E5E1_A1A0_8EEADE506C437AEC">
				<tr align="center">
					<th align="left" colspan="6"><br/><b>Virtual Community & Social Media Services</b><br/></td>
				</tr>
				</cfif>
				<cfif itemname eq "6FE0B397_20CF_30E1_C47D1E90EC7251F7">
				<tr align="center">
					<th align="left" colspan="6"><b>&##12458;&##12531;&##12521;&##12452;&##12531;&##12395;&##12424;&##12427;&##12450;&##12489;&##12496;&##12452;&##12473;</b><br/></td>
				</tr>
				</cfif>
				<cfif itemname eq "BAC12878_D677_7C43_1FF428F475079FFF">
				<tr align="center">
					<th align="left" colspan="6"><br/><b>&##12496;&##12540;&##12481;&##12515;&##12523;&##12467;&##12511;&##12517;&##12491;&##12486;&##12451;&##12540;&##12392;&##12477;&##12540;&##12471;&##12515;&##12523;&##12513;&##12487;&##12451;&##12450;</b><br/></td>
				</tr>
				</cfif>
				<tr align="center">
					<td align="left" width="650px">
						<label for="q#itemname#_#id#">#answer#</label></td>
					<cfloop query="getAnswers">
					<!---<cfset selected = isDefined("form.q#itemname#") and form["q" & itemname] is id>--->
					<cfset selected = false>
					<cfif (isDefined("form.q#itemname#") and form["q" & itemname] is id)
							or
						  (structKeyExists(attributes, "answer") and isStruct(attributes.answer) and structKeyExists(attributes.answer, itemid) and attributes.answer[itemid] is id)
						  	>
						<cfset selected = true>
					</cfif>			  	
					<td><input type="radio" name="q#itemname#" id="q#itemname#_#id#" value="#id#" <cfif selected>checked</cfif>></td>
					</cfloop>
				</tr>
			</cfloop>
		</table>
		</td>
	</tr>
</table>
</cfoutput>
				
<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">