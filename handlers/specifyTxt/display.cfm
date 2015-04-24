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
<div class="section_header"><strong>#attributes.question.header#</strong></div>
<div class="question"><!---#attributes.step#)---> #attributes.question.question# <cfif attributes.question.required EQ 1><strong class="required">*</strong></cfif></div>
<div class="answers">
<cfif attributes.yesno>
		<input type="radio" name="question#attributes.step#" id="question#attributes.step#_yes" value="yes" <cfif attributes.answer is "yes">checked</cfif>><label for="question#attributes.step#_yes">Yes</label><br>
		<input type="radio" name="question#attributes.step#" id="question#attributes.step#_no" value="no" <cfif attributes.answer is "no">checked</cfif>><label for="question#attributes.step#_no">No</label><br>
		<cfelse>
		<label for="question#attributes.step#_specify">
			<input type="radio" name="question#attributes.step#" id="question#attributes.step#_true" value="" <cfif len(attributes.answer)>checked</cfif>><span id="sprytextfield#attributes.step#">#answers["answer"][1]#
			<input type="text" name="question#attributes.step#" id="question#attributes.step#_specify" value="#attributes.answer#" maxlength="255" onclick="form.question#attributes.step#_true.checked=true; validateTxt#attributes.step#();">
				#answers["answer"][2]# &nbsp;&nbsp;
			<span class="textfieldRequiredMsg">#answers["answer"][3]#</span>
  			<span class="textfieldMaxCharsMsg">#answers["answer"][4]#</span></span>
		</label><br>
		<input type="radio" name="question#attributes.step#" id="question#attributes.step#_false" value="false" onclick="question#attributes.step#_specify.value=''; removeValidateTxt#attributes.step#();" <cfif attributes.answer is "false">checked</cfif>><label for="question#attributes.step#_false">#answers["answer"][5]#</label><br>		
  </cfif>
</div>
<script type="text/javascript">
	//var sprytextfield#attributes.step# = new Spry.Widget.ValidationTextField("sprytextfield#attributes.step#", "none", {minChars:0, maxChars:100, validateOn:["change"]});
	
	if (document.getElementById("question#attributes.step#_true").checked){
          validateTxt#attributes.step#();
	}
	else
	{
          removeValidateTxt#attributes.step#();
	}
	
	function validateTxt#attributes.step#(){
		var sprytextfield#attributes.step# = new Spry.Widget.ValidationTextField("sprytextfield#attributes.step#", "none", {minChars:0, maxChars:100, validateOn:["change"]});
	}
	function removeValidateTxt#attributes.step#(){
		document.getElementById("sprytextfield#attributes.step#").className = "";
		new Spry.Widget.Utils.destroyWidgets("sprytextfield#attributes.step#");
	}
</script>
</cfoutput>
				
<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">