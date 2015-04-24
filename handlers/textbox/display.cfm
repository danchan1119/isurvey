<cfsetting enablecfoutputonly=true>
<!---
	Name         : handlers/textbox/display.cfm
	Author       : Raymond Camden 
	Created      : September 21, 2004
	Last Updated : April 10, 2006
	History      : minor format change (rkc 10/7/05)
				   restrict to 255 (rkc 10/12/05)
				   minor html change (rkc 4/10/06)
	Purpose		 : Supports Textbox, single and multi
--->

<cfparam name="attributes.single" default="true">
<cfparam name="attributes.step">

<cfif isDefined("form.submit")>
	<cfif (not isDefined("form.question#attributes.step#") or not len(form["question#attributes.step#"])) and attributes.question.required>
		<cfset errors = "You must answer the question.">
	<cfelse>
		<cfset form["question#attributes.step#"] = htmlEditFormat(form["question#attributes.step#"])>
		<cfif attributes.single>
			<cfset form["question#attributes.step#"] = left(form["question#attributes.step#"], 255)>
		</cfif>
		<cfset caller[attributes.r_result] = form["question#attributes.step#"]>
		<cfset attributes.answer = form["question#attributes.step#"]>
	</cfif>
</cfif>

<cfif isDefined("errors")>
	<cfoutput>
	<p class="error">#errors#</p>
	</cfoutput>
</cfif>
	
<cfoutput>
<div class="section_header"><strong>#attributes.question.header#</strong></div>
<div class="question"><!---#attributes.step#)---> <label for="question#attributes.step#">#attributes.question.question#</label> <cfif attributes.question.required EQ 1><strong class="required">*</strong></cfif></div>
<div class="answers">
		<cfif attributes.single>
		<input type="text" name="question#attributes.step#" id="question#attributes.step#" value="#attributes.answer#" maxlength="255">		
		<cfelse>
			<span id="sprytextarea#attributes.step#">
				<textarea name="question#attributes.step#" id="question#attributes.step#" cols=40 rows=10>#attributes.answer#</textarea>
				<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
					<p align="right">Number of characters remaining = <span id="counter#attributes.step#"></span>.</p>
				</cfif>
				<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
					<p align="right">&##27531;&##12426;&##25991;&##23383;&##25968; = <span id="counter#attributes.step#"></span>.</p>
				</cfif>
				<!---<span class="textareaMaxCharsMsg">Maximum number of characters exceeded.</span>--->
			</span>
		</cfif>
</div>
<script type="text/javascript">
	var sprytextarea#attributes.step# = new Spry.Widget.ValidationTextarea("sprytextarea#attributes.step#", {isRequired:false, maxChars:3000, counterType:"chars_remaining", counterId:"counter#attributes.step#", validateOn:["change"]});
</script>
</cfoutput>
				
<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">