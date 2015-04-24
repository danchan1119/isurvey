<cfsetting enablecfoutputonly=true>
<!---
	Name         : handlers/multiplechoice/display.cfm
	Author       : Daniel Chan 
	Created      : February 23, 2013
	Last Updated : 
	History      : Added option for section header, disabled display of question number
	Purpose		 : Supports True/False, Yes/No
--->

<cfparam name="attributes.single" default="true">
<cfparam name="attributes.other" default="false">
<cfparam name="attributes.question">
<cfparam name="attributes.r_result" default="result">
<cfparam name="attributes.answer">
<cfparam name="attributes.step">

<cfset showForm = true>
<cfset forceOther = false>

<cfif isDefined("form.submit")>
	<cfif not isDefined("form.question#attributes.step#") and attributes.question.required>
		<cfset errors = "You must answer the question.">
	<!---<cfelseif attributes.other and isDefined("form.question#attributes.step#") and form["question#attributes.step#"] is "" and not len(trim(form["question#attributes.step#_other"]))>
		<cfset forceOther = true>
		<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
			<cfset errors = "If you select 'Other', please specify.">
		</cfif>
		<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
			<cfset errors = "&##12300;&##12381;&##12398;&##20182;&##12301;&##12398;&##27396;&##12395;&##20855;&##20307;&##30340;&##12395;&##12372;&##35352;&##20837;&##12367;&##12384;&##12373;&##12356;&##12290;">
		</cfif>--->
	<cfelse>
		<cfparam name="form.question#attributes.step#" default="">
		<!--- removed 255 - breaks with uuids 
		<cfset form["question#attributes.step#"] = left(form["question#attributes.step#"], 255)>
		--->
		<cfset form["question#attributes.step#"] = form["question#attributes.step#"]>
		<cfset attributes.answer = structNew()>
		<cfset attributes.answer.list = form["question#attributes.step#"]>
		<cfif isDefined("form.question#attributes.step#_other") and len(form["question#attributes.step#_other"])>
			<cfset attributes.answer.other = htmlEditFormat(form["question#attributes.step#_other"])>
		</cfif>
		<cfset caller[attributes.r_result] = attributes.answer>
	</cfif>
</cfif>

<cfif not structKeyExists(attributes, "answers")>
	<cfset answers = application.question.getAnswers(attributes.question.id)>	
<cfelse>
	<cfset answers = attributes.answers>
</cfif>

<!--- 
If a value exists in the answer that is NOT in the list, then its the Other
--->
<cfif isStruct(attributes.answer) and structKeyExists(attributes.answer,"other")>
	<cfparam name="form.question#attributes.step#_other" default="#attributes.answer.other#">
<cfelse>
	<cfparam name="form.question#attributes.step#_other" default="">
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
		<cfif attributes.single>
			<cfset type="radio">
			<cfset otherPrefix=", specify:">
		<cfelse>
			<cfset type="checkbox">
			<cfset otherPrefix=", that is:">
		</cfif>
		<cfloop query="answers">
		<input type="#type#" name="question#attributes.step#" id="question#attributes.step#_#id#" value="#id#" <cfif type eq 'radio'>onclick="removeValidateTxt#attributes.step#()"</cfif> <cfif isStruct(attributes.answer) and structKeyExists(attributes.answer,"list") and listFindNoCase(attributes.answer.list,id)>checked</cfif>><label id="question#attributes.step#_#id#_lbl" for="question#attributes.step#_#id#">#answer#</label><br>
		<cfif id eq '7535C169-20CF-30E1-C47D3ED92BF58DAD'>(&##20844;&##30410;&##36001;&##22243;&##27861;&##20154;&##28040;&##38450;&##32946;&##33521;&##20250;&##12399;&##12289;&##28779;&##28797;&##12420;&##27700;&##23475;&##31561;&##12398;&##28040;&##38450;&##27963;&##21205;&##12395;&##21332;&##21147;&##12375;&##27515;&##20129;&##12373;&##12428;&##12383;&##19968;&##33324;&##12398;&##26041;&##12289;&##12362;&##12424;&##12403;&##27529;&##32887;&##12375;&##12383;&##28040;&##38450;&##22243;&##21729;&##31561;&##12398;&##36986;&##20816;&##12398;&##20462;&##23398;&##12434;&##25903;&##12360;&##12427;&##32946;&##33521;&##20107;&##26989;&##12434;&##34892;&##12356;&##12414;&##12377;&##12290;2011&##24180;&##12398;&##26481;&##26085;&##26412;&##22823;&##38663;&##28797;&##12395;&##12362;&##12356;&##12390;&##12399;&##22810;&##12367;&##12398;&##36986;&##20816;&##12364;&##30330;&##29983;&##12375;&##12289;&##24444;&##12425;&##12434;&##25903;&##25588;&##12377;&##12427;&##12300;&##26481;&##26085;&##26412;&##22823;&##38663;&##28797;&##28040;&##38450;&##27529;&##32887;&##32773;&##36986;&##20816;&##32946;&##33521;&##22888;&##23398;&##22522;&##37329;&##12301;&##12434;&##35373;&##32622;&##12375;&##36939;&##21942;&##12375;&##12390;&##12356;&##12414;&##12377;&##12290;)<br/><a href="http://www.nissho-jyouhou.jp/ikueikai/" target="_blank">http://www.nissho-jyouhou.jp/ikueikai/</a><br/><br/></cfif>
		<cfif id eq '32AA72F0-C445-B987-BCC2E1AAB044423C'>(&##32117;&##26412;&##12496;&##12473;&##12503;&##12525;&##12472;&##12455;&##12463;&##12488;&##12399;&##29305;&##23450;&##38750;&##21942;&##21033;&##27963;&##21205;&##27861;&##20154;&##12300;&##22320;&##29699;&##12398;&##27005;&##22909;&##12301;&##12364;&##20225;&##30011;&##12539;&##36939;&##21942;&##12375;&##12390;&##12356;&##12414;&##12377;&##12290; 2011&##24180;&##12398;&##26481;&##26085;&##26412;&##22823;&##38663;&##28797;&##30452;&##24460;&##12424;&##12426;&##12289;&##20840;&##19990;&##30028;&##12363;&##12425;&##23492;&##12379;&##12425;&##12428;&##12427;&##32117;&##26412;&##12289;&##20816;&##31461;&##26360;&##12434;&##23470;&##22478;&##30476;&##12289;&##31119;&##23798;&##30476;&##12398;&##20445;&##32946;&##25152;&##12289;&##24188;&##31258;&##22290;&##12289;&##20206;&##35373;&##20303;&##23429;&##12395;&##20986;&##21521;&##12365;&##23376;&##20379;&##12383;&##12385;&##12395;&##22909;&##12365;&##12394;&##12418;&##12398;&##12434;&##36984;&##12435;&##12391;&##12418;&##12425;&##12356;&##12503;&##12524;&##12476;&##12531;&##12488;&##12375;&##12390;&##12356;&##12414;&##12377;&##12290;&##12414;&##12383;&##20445;&##35703;&##32773;&##12289;&##20445;&##32946;&##32773;&##12394;&##12393;&##12398;&##24515;&##12398;&##12465;&##12450;&##12392;&##12418;&##12394;&##12427;&##12527;&##12540;&##12463;&##12471;&##12519;&##12483;&##12503;&##12418;&##34892;&##12387;&##12390;&##12356;&##12414;&##12377;&##12290;)<br/><a href="http://chikyuunogakkou.org/" target="_blank">http://chikyuunogakkou.org/</a><br/><br/></cfif>
		</cfloop>
		<cfif attributes.other>
		<input type="#type#" name="question#attributes.step#" id="question#attributes.step#__" value="" onclick="checkClick#attributes.step#()" <cfif len(form["question#attributes.step#_other"]) or forceOther>checked</cfif>><label for="question#attributes.step#__"><cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>&##12381;&##12398;&##20182;&##65288;&##20855;&##20307;&##30340;&##12395;&##65289;&##65306;<cfelse>Other#otherPrefix#</cfif></label>
		<span id="sprytextfield#attributes.step#">
			<input type="text" name="question#attributes.step#_other" value="#form["question#attributes.step#_other"]#" maxlength="255" onclick="form.question#attributes.step#__.checked=true; checkClick#attributes.step#()">
			<span class="textfieldRequiredMsg">
				<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
					If you select 'Other', please specify.
				</cfif>
				<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
					&##12300;&##12381;&##12398;&##20182;&##12301;&##12434;&##36984;&##12400;&##12428;&##12383;&##22580;&##21512;&##12399;&##12289;&##35443;&##32048;&##12434;&##12372;&##20837;&##21147;&##12367;&##12384;&##12373;&##12356;&##12290;
				</cfif>
			</span>
  			<span class="textfieldMaxCharsMsg">
  				<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
					Maximum number of characters exceeded.
				</cfif>
				<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
					&##26368;&##22823;&##25991;&##23383;&##25968;&##21046;&##38480;&##12434;&##36229;&##12360;&##12390;&##12356;&##12414;&##12377;&##12290;
				</cfif>
  			</span>
		</span>
		</cfif>
</div>
<script type="text/javascript">
	//var sprytextfield#attributes.step# = new Spry.Widget.ValidationTextField("sprytextfield#attributes.step#", "none", {minChars:0, maxChars:50, validateOn:["change"]});
	
	if (document.getElementById("question#attributes.step#__").checked){
	          validateTxt#attributes.step#();
	}
	else
	{
          removeValidateTxt#attributes.step#();
	}
	
	function checkClick#attributes.step#(){
		if (document.getElementById("question#attributes.step#__").checked){
	          validateTxt#attributes.step#();
		}
		else
		{
	          removeValidateTxt#attributes.step#();
		}
	}
	
	function validateTxt#attributes.step#(){
		var sprytextfield#attributes.step# = new Spry.Widget.ValidationTextField("sprytextfield#attributes.step#", "none", {minChars:0, maxChars:50, validateOn:["change"]});
	}
	function removeValidateTxt#attributes.step#(){
		document.getElementById("sprytextfield#attributes.step#").className = "";
		new Spry.Widget.Utils.destroyWidgets("sprytextfield#attributes.step#");
	}
</script>
<!---<cfif attributes.step eq 54>
	<div id="tooltipText1" class="tooltipContent">(&##20844;&##30410;&##36001;&##22243;&##27861;&##20154;&##28040;&##38450;&##32946;&##33521;&##20250;&##12399;&##12289;&##28779;&##28797;&##12420;&##27700;&##23475;&##31561;&##12398;&##28040;&##38450;&##27963;&##21205;&##12395;&##21332;&##21147;&##12375;&##27515;&##20129;&##12373;&##12428;&##12383;&##19968;&##33324;&##12398;&##26041;&##12289;&##12362;&##12424;&##12403;&##27529;&##32887;&##12375;&##12383;&##28040;&##38450;&##22243;&##21729;&##31561;&##12398;&##36986;&##20816;&##12398;&##20462;&##23398;&##12434;&##25903;&##12360;&##12427;&##32946;&##33521;&##20107;&##26989;&##12434;&##34892;&##12356;&##12414;&##12377;&##12290;2011&##24180;&##12398;&##26481;&##26085;&##26412;&##22823;&##38663;&##28797;&##12395;&##12362;&##12356;&##12390;&##12399;&##22810;&##12367;&##12398;&##36986;&##20816;&##12364;&##30330;&##29983;&##12375;&##12289;&##24444;&##12425;&##12434;&##25903;&##25588;&##12377;&##12427;&##12300;&##26481;&##26085;&##26412;&##22823;&##38663;&##28797;&##28040;&##38450;&##27529;&##32887;&##32773;&##36986;&##20816;&##32946;&##33521;&##22888;&##23398;&##22522;&##37329;&##12301;&##12434;&##35373;&##32622;&##12375;&##36939;&##21942;&##12375;&##12390;&##12356;&##12414;&##12377;&##12290;) <a href="http://www.nissho-jyouhou.jp/ikueikai/" target="_blank">http://www.nissho-jyouhou.jp/ikueikai/</a></div>
	<div id="tooltipText2" class="tooltipContent">(&##32117;&##26412;&##12496;&##12473;&##12503;&##12525;&##12472;&##12455;&##12463;&##12488;&##12399;&##29305;&##23450;&##38750;&##21942;&##21033;&##27963;&##21205;&##27861;&##20154;&##12300;&##22320;&##29699;&##12398;&##27005;&##22909;&##12301;&##12364;&##20225;&##30011;&##12539;&##36939;&##21942;&##12375;&##12390;&##12356;&##12414;&##12377;&##12290; 2011&##24180;&##12398;&##26481;&##26085;&##26412;&##22823;&##38663;&##28797;&##30452;&##24460;&##12424;&##12426;&##12289;&##20840;&##19990;&##30028;&##12363;&##12425;&##23492;&##12379;&##12425;&##12428;&##12427;&##32117;&##26412;&##12289;&##20816;&##31461;&##26360;&##12434;&##23470;&##22478;&##30476;&##12289;&##31119;&##23798;&##30476;&##12398;&##20445;&##32946;&##25152;&##12289;&##24188;&##31258;&##22290;&##12289;&##20206;&##35373;&##20303;&##23429;&##12395;&##20986;&##21521;&##12365;&##23376;&##20379;&##12383;&##12385;&##12395;&##22909;&##12365;&##12394;&##12418;&##12398;&##12434;&##36984;&##12435;&##12391;&##12418;&##12425;&##12356;&##12503;&##12524;&##12476;&##12531;&##12488;&##12375;&##12390;&##12356;&##12414;&##12377;&##12290;&##12414;&##12383;&##20445;&##35703;&##32773;&##12289;&##20445;&##32946;&##32773;&##12394;&##12393;&##12398;&##24515;&##12398;&##12465;&##12450;&##12392;&##12418;&##12394;&##12427;&##12527;&##12540;&##12463;&##12471;&##12519;&##12483;&##12503;&##12418;&##34892;&##12387;&##12390;&##12356;&##12414;&##12377;&##12290;) <a href="http://chikyuunogakkou.org/" target="_blank">http://chikyuunogakkou.org/</a></div>
	<div id="tooltipText3" class="tooltipContent">(Hong Chi Association operates 74 service training units to serve people of all ages and all grades of intellectual disabilities) <a href="http://www.hongchi.org.hk/intro.html" target="_blank">http://www.hongchi.org.hk/intro.html</a></div>
	<div id="tooltipText4" class="tooltipContent">(Half the Sky is dedicated to bringing the love and concern of family to orphaned children in China. The charity provides individual nurture for babies, innovative preschools, personalized learning opportunities for older children, and most importantly, permanent foster homes for children with special needs.) <a href="http://www.halfthesky.org/" target="_blank">http://www.halfthesky.org/</a></div>
	<script type="text/javascript">
			var tooltip54_1 = new Spry.Widget.Tooltip("tooltipText1", "##question54_7535C169-20CF-30E1-C47D3ED92BF58DAD_lbl", {closeOnTooltipLeave: true, hideDelay: 250});
			var tooltip54_2 = new Spry.Widget.Tooltip("tooltipText2", "##question54_32AA72F0-C445-B987-BCC2E1AAB044423C_lbl", {closeOnTooltipLeave: true, hideDelay: 250});
	</script>
			var tooltip54_3 = new Spry.Widget.Tooltip("tooltipText3", "##question54_754D73CC-20CF-30E1-C47D1605E3C413DF_lbl", {closeOnTooltipLeave: true, hideDelay: 250});
			var tooltip54_4 = new Spry.Widget.Tooltip("tooltipText4", "##question54_754D7418-20CF-30E1-C47D624820A39783_lbl", {closeOnTooltipLeave: true, hideDelay: 250});
</cfif>--->
</cfoutput>
				
<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">