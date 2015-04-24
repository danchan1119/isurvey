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
<div>
	<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>If you complete and return this questionnaire, it will be received by Credit Suisse employees who will anonymise your name (if you have included this information). The anonymised questionnaire results will then be transferred to and analysed by ORC International Holdings, Inc. in Hong Kong, who will provide individual and aggregated data reports and analysis to Credit Suisse. Data results may be matched with your name (if provided) for analysis purposes within Credit Suisse and your relationship manager may contact you in this context. Furthermore, when entering information in the free text fields, you acknowledge that the recipients of the questionnaire results may infer your identity depending on the information you have provided.</cfif>
	<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>&##12371;&##12398;&##12450;&##12531;&##12465;&##12540;&##12488;&##12395;&##12372;&##35352;&##21517;&##12391;&##12372;&##22238;&##31572;&##12356;&##12383;&##12384;&##12356;&##12383;&##22580;&##21512;&##12395;&##12399;&##12289;&##24330;&##31038;&##12395;&##12390;&##21311;&##21517;&##21270;&##12375;&##12390;&##12381;&##12398;&##24460;&##12398;&##21462;&##12426;&##25201;&##12356;&##12434;&##12356;&##12383;&##12375;&##12414;&##12377;&##12290;&##21311;&##21517;&##21270;&##12373;&##12428;&##12383;&##12450;&##12531;&##12465;&##12540;&##12488;&##32080;&##26524;&##12398;&##24773;&##22577;&##12399;&##12289;&##35519;&##26619;&##20998;&##26512;&##23554;&##38272;&##20250;&##31038;&##65288;&##39321;&##28207; ORC International Holdings&##65289;&##12408;&##36578;&##36865;&##12373;&##12428;&##12289;&##21516;&##31038;&##12364;&##20491;&##21029;&##12539;&##32207;&##21512;&##12487;&##12540;&##12479;&##12392;&##12381;&##12398;&##20998;&##26512;&##32080;&##26524;&##12434;&##12463;&##12524;&##12487;&##12451;&##12539;&##12473;&##12452;&##12473;&##12395;&##25552;&##20379;&##12375;&##12414;&##12377;&##12290;&##12372;&##35352;&##21517;&##12356;&##12383;&##12384;&##12356;&##12383;&##12487;&##12540;&##12479;&##32080;&##26524;&##12399;&##12289;&##12463;&##12524;&##12487;&##12451;&##12539;&##12473;&##12452;&##12473;&##20869;&##12395;&##12390;&##20998;&##26512;&##12398;&##12383;&##12417;&##12395;&##12362;&##23458;&##27096;&##12392;&##29031;&##21512;&##12375;&##12289;&##38306;&##36899;&##12375;&##12390;&##25285;&##24403;&##12522;&##12524;&##12540;&##12471;&##12519;&##12531;&##12471;&##12483;&##12503;&##12539;&##12510;&##12493;&##12540;&##12472;&##12515;&##12540;&##12364;&##12362;&##23458;&##27096;&##12395;&##12372;&##36899;&##32097;&##12377;&##12427;&##22580;&##21512;&##12364;&##12354;&##12426;&##12414;&##12377;&##12290;&##12414;&##12383;&##12289;&##33258;&##30001;&##35352;&##20837;&##27396;&##12395;&##12372;&##35352;&##20837;&##12373;&##12428;&##12383;&##24773;&##22577;&##12395;&##22522;&##12389;&##12356;&##12390;&##12450;&##12531;&##12465;&##12540;&##12488;&##21463;&##38936;&##32773;&##12364;&##12362;&##23458;&##27096;&##12434;&##29305;&##23450;&##12377;&##12427;&##21487;&##33021;&##24615;&##12364;&##12354;&##12427;&##12371;&##12392;&##12395;&##21516;&##24847;&##12373;&##12428;&##12383;&##12418;&##12398;&##12392;&##12373;&##12379;&##12390;&##12356;&##12383;&##12384;&##12365;&##12414;&##12377;&##12290;</cfif>
</div>
<br/>
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