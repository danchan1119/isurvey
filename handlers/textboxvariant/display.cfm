<cfsetting enablecfoutputonly=true>
<!---
	Name         : handlers/truefalse/display.cfm
	Author       : Raymond Camden 
	Created      : September 21, 2004
	Last Updated : April 10, 2006
	History      : New row for answers (rkc 10/7/05)
				 : Minor HTML mod (rkc 4/10/06)
	Purpose		 : Supports True/False, Yes/No
--->

<cfparam name="attributes.yesno" default="false">
<cfparam name="attributes.question">
<cfparam name="attributes.r_result" default="result">
<cfparam name="attributes.answer">
<cfparam name="attributes.step">

<cfset showForm = true>

<cfif isDefined("form.submit")>
	<cfif not isDefined("form.question#attributes.step#") and attributes.question.required>
		<cfset errors = "You must answer the question.">
	<cfelse>
		<!--- param for non required results --->
		<cfparam name="form.question#attributes.step#" default="">
		<cfset caller[attributes.r_result] = form["question#attributes.step#"]>
		<cfset attributes.answer = form["question#attributes.step#"]>
	</cfif>
</cfif>

<cfif not structKeyExists(attributes, "answers")>
	<cfset answers = application.question.getAnswers(attributes.question.id)>	
<cfelse>
	<cfset answers = attributes.answers>
</cfif>

<cfif isDefined("errors")>
	<cfoutput>
	<p class="error">#errors#</p>
	</cfoutput>
</cfif>
	
<cfoutput>
<p>
<div class="section_header"><strong>#attributes.question.header#</strong></div>
<div class="question"><!---#attributes.step#)---> #attributes.question.question# <cfif attributes.question.required EQ 1><strong class="required">*</strong></cfif></div>
<div class="answers">
		<span id="sprytextfield#attributes.step#">
			<input type="text" name="question#attributes.step#" id="question#attributes.step#" value="#attributes.answer#" maxlength="255" onclick="validateInt#attributes.step#()">#answers["answer"][1]#
			<span class="textfieldRequiredMsg">#answers["answer"][2]#</span>
			<span class="textfieldMinValueMsg">#answers["answer"][2]#</span>
			<span class="textfieldMaxValueMsg">#answers["answer"][3]#</span>
  			<span class="textfieldInvalidFormatMsg">#answers["answer"][3]#</span>	
		</span>
</div>
</p>
<script type="text/javascript">
	function validateInt#attributes.step#(){
		var sprytextfield#attributes.step# = new Spry.Widget.ValidationTextField("sprytextfield#attributes.step#", "integer", {allowNegative:false, <cfif attributes.step eq 37 or attributes.step eq 41>minValue:"1900", maxValue:"2013", </cfif><cfif attributes.step eq 39 or attributes.step eq 42>minValue:"0", maxValue:"99", </cfif>validateOn:["change"]});
	}
	function removeValidateInt#attributes.step#(){
		new Spry.Widget.Utils.destroyWidgets("sprytextfield#attributes.step#");
	}
</script>
</cfoutput>
				
<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">