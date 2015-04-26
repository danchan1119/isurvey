<cfsetting enablecfoutputonly=true>
<!---
	Name         : surveydisplay.cfm
	Author       : Raymond Camden 
	Created      : September 21, 2004
	Last Updated : November 14, 2007
	History      : work w/o mapping (rkc 3/10/06)
				 : Include title of survey (rkc 4/10/06)
				 : Fix for broken arrays (rkc 8/22/07)
				 : problem with maxquestions (rkc 11/14/07)
	Purpose		 : Handles the survey display. 
--->

<cfparam name="attributes.survey">
<cfset surveyComplete = false>

<!--- Initialize in session scope if it doesn't exist --->
<cfif not structKeyExists(session,"surveys")>
	<cfset session.surveys = structNew()>
</cfif>

<!--- Initialize certain values in the session struct --->
<cfif not structKeyExists(session.surveys,attributes.survey.id)>
	<cfset session.surveys[attributes.survey.id] = structNew()>
	<cfset session.surveys[attributes.survey.id].started = now()>
	<cfset session.surveys[attributes.survey.id].currentStep = 1>
	<cfset session.surveys[attributes.survey.id].answers = structNew()>
	<cfset session.surveys[attributes.survey.id].maxQuestions = application.question.getQuestions(attributes.survey.id).recordCount>
	<cfset session.surveys[attributes.survey.id].toskip = structNew()>
	<cfset session.surveys[attributes.survey.id].toenter = structNew()>
</cfif>

<!--- First see if survey is protected --->
<!--- Is it protected by date begin? --->
<cfif isDate(attributes.survey.dateBegin) and dateCompare(attributes.survey.dateBegin,now()) gte 0>
	<cfoutput>
	<p>
	<div class="surveyMessages">Sorry, but this survey has not yet begun.</div>
	</p>
	</cfoutput>
	<cfabort>
</cfif>
<!--- Is it protected by date end? --->
<cfif isDate(attributes.survey.dateEnd) and dateCompare(attributes.survey.dateEnd,now()) is -1>
	<cfoutput>
	<p>
	<div class="surveyMessages">Sorry, but this survey is over.</div>
	</p>
	</cfoutput>
	<!---<cfabort>--->
</cfif>
<!--- Is it protected by password? --->
<cfif len(attributes.survey.surveypassword) and not structKeyExists(session.surveys[attributes.survey.id],"auth")>
	<cfset showForm = true>
	<cfset showError = false>
	<cfif isDefined("form.password")>
		<cfif form.password eq attributes.survey.surveypassword>
			<cfset session.surveys[attributes.survey.id].auth = true>
			<cfset showForm = false>
		<cfelse>
			<cfset showError = true>
		</cfif>
	</cfif>
	
	<cfif showForm>
		<cfoutput>
		<p>
		<div class="surveyMessages">In order to use this survey, you must enter a password. This password should have been
		sent to you with your survey invitation.</div>
		<cfif showError></p><p><b>Sorry, but the password you entered is not correct.</b></cfif>
		<form action="#cgi.script_name#?#cgi.query_string#" method="post">
		<input type="password" name="password"> <input type="submit" value="Enter Password">
		</form>
		</p>
		</cfoutput>
		<cfabort>
	</cfif>
</cfif>
<!--- Is it protected by an email list? --->
<cfif len(attributes.survey.emaillist) and not structKeyExists(session.surveys[attributes.survey.id],"auth")>
	<cfset showForm = true>
	<cfset showDisclaimer = false>
	<cfset showError = false>
	<cfset showDone = false>
	<cfif isDefined("form.email")>
		<cfif listFindNoCase(attributes.survey.emailList, form.email)>
			<cfif application.survey.surveyCompletedBy(attributes.survey.id,form.email)>
				<cfset showDone = true>
			<cfelse>
				<cfset session.surveys[attributes.survey.id].auth = true>
				<cfset session.surveys[attributes.survey.id].owner = form.email>
				<cfset showForm = false>
				<cfset showDisclaimer = true>
			</cfif>
		<cfelse>
			<cfset showError = true>
		</cfif>
	</cfif>
	<cfif isDefined("form.disclaimer")>
		<cfset showDisclaimer = false>
	</cfif>
	
	<cfif showForm>
		<cfoutput><script type="text/javascript">document.getElementById("header").innerHTML = "";</script>
		<p>
			<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
				<div class="surveyMessages">This survey is open by invitation only. In order to continue, please enter a valid login.</div>
			<cfelseif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
				<div class="surveyMessages">&##24403;&##12450;&##12531;&##12465;&##12540;&##12488;&##12399;&##12372;&##26696;&##20869;&##12434;&##24046;&##12375;&##19978;&##12370;&##12383;&##12362;&##23458;&##27096;&##12395;&##12362;&##31572;&##12360;&##12356;&##12383;&##12384;&##12356;&##12390;&##12362;&##12426;&##12414;&##12377;&##12290;&##12525;&##12464;&##12452;&##12531;&##12497;&##12473;&##12527;&##12540;&##12489;&##12434;&##12372;&##20837;&##21147;&##12367;&##12384;&##12373;&##12356;&##12290;</div>
			<cfelse>
				<div class="surveyMessages">This survey is open by invitation only. In order to continue, please enter a valid login.</div>
			</cfif>
		</p>
		<cfif showDone>
			<p>
				<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
					<div class="error">Thank you. You have already completed the survey.</div>
				<cfelseif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
					<div class="error">&##12354;&##12426;&##12364;&##12392;&##12358;&##12372;&##12374;&##12356;&##12414;&##12375;&##12383;&##12290;&##12371;&##12428;&##12391;&##12289;&##12450;&##12531;&##12465;&##12540;&##12488;&##12399;&##32066;&##20102;&##12391;&##12377;&##12290;</div>
				<cfelse>
					<div class="error">Thank you. You have already completed the survey.</div>
				</cfif>
			</p>
		</cfif>
		<cfif showError>
			<p>
				<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
					<div class="error">Sorry, please enter a valid login.</div>
				<cfelseif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
					<div class="error">&##26377;&##21177;&##12394;&##12525;&##12464;&##12452;&##12531;&##12497;&##12473;&##12527;&##12540;&##12489;&##12434;&##12372;&##20837;&##21147;&##12367;&##12384;&##12373;&##12356;&##12290;</div>
				<cfelse>
					<div class="error">Sorry, please enter a valid login.</div>
				</cfif>
			</p>
		</cfif>
		<form action="#cgi.script_name#?#cgi.query_string#" method="post">
			<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
				<input type="text" name="email"> <input type="submit" value="Enter Login">
			<cfelseif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
				<input type="text" name="email"> <input type="submit" value="&##12525;&##12464;&##12452;&##12531;">
			<cfelse>
				<input type="text" name="email"> <input type="submit" value="Enter Login">
			</cfif>
		</form>
		</cfoutput>
		<cfabort>
	</cfif>
	<cfif showDisclaimer>
		<cfoutput><script type="text/javascript">document.getElementById("header").innerHTML = "";</script>
		<p>
			<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
				<div class="surveyMessages">Thank you in advance for completing this questionnaire. Your feedback will help us further enhance our service. Your responses will be analysed by ORC International Holdings, Inc. in Hong Kong, who will provide individual and aggregated data reports and analysis to Credit Suisse. When entering information in the free text fields, you acknowledge that the recipients of your information may infer your identity depending on the information you provided. Your answers will be treated securely.<br/><br/>
											Please note that your participation is absolutely voluntary. As we will be conducting the survey electronically, we kindly ask you to take note of the following risks:<br/><br/>
											Please note that data transported over an open network may be accessible to anybody. Credit Suisse cannot guarantee the confidentiality of any communication or material transmitted via such open networks. In particular, while individual data packets are often encrypted, the names of the sender and recipient are not. A third party may therefore be able to infer an existing bank account or relationship or one that is subsequently created. Even if both the sender and recipient are located in the same country data may also be transmitted via such networks to other countries regularly and without controls, including to countries that do not afford the same level of data protection as your country of domicile.
				</div>
			</cfif>
			<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
				<div class="surveyMessages">&##12450;&##12531;&##12465;&##12540;&##12488;&##35519;&##26619;&##12408;&##12398;&##12372;&##21332;&##21147;&##12395;&##12289;&##24481;&##31036;&##30003;&##12375;&##19978;&##12370;&##12414;&##12377;&##12290;&##12362;&##23458;&##27096;&##12398;&##12372;&##22238;&##31572;&##12399;&##12289;&##24330;&##31038;&##12398;&##12469;&##12540;&##12499;&##12473;&##12398;&##19968;&##23652;&##12398;&##21521;&##19978;&##12398;&##12383;&##12417;&##12395;&##21033;&##29992;&##12373;&##12379;&##12390;&##12356;&##12383;&##12384;&##12365;&##12414;&##12377;&##12290;&##12372;&##22238;&##31572;&##12399;&##35519;&##26619;&##20998;&##26512;&##23554;&##38272;&##20250;&##31038;&##65288;&##39321;&##28207;ORC International Holdings&##65289;&##12408;&##36578;&##36865;&##12373;&##12428;&##12289;&##21516;&##31038;&##12364;&##20491;&##21029;&##12539;&##32207;&##21512;&##12487;&##12540;&##12479;&##12392;&##12381;&##12398;&##20998;&##26512;&##32080;&##26524;&##12434;&##12463;&##12524;&##12487;&##12451;&##12539;&##12473;&##12452;&##12473;&##12395;&##25552;&##20379;&##12375;&##12414;&##12377;&##12290;&##12372;&##35352;&##21517;&##12356;&##12383;&##12384;&##12356;&##12383;&##12487;&##12540;&##12479;&##32080;&##26524;&##12399;&##12289;&##12463;&##12524;&##12487;&##12451;&##12539;&##12473;&##12452;&##12473;&##20869;&##12395;&##12390;&##20998;&##26512;&##12398;&##12383;&##12417;&##12395;&##12362;&##23458;&##27096;&##12392;&##29031;&##21512;&##12375;&##12289;&##38306;&##36899;&##12375;&##12390;&##25285;&##24403;&##12522;&##12524;&##12540;&##12471;&##12519;&##12531;&##12471;&##12483;&##12503;&##12539;&##12510;&##12493;&##12540;&##12472;&##12515;&##12540;&##12364;&##12362;&##23458;&##27096;&##12395;&##12372;&##36899;&##32097;&##12377;&##12427;&##22580;&##21512;&##12364;&##12354;&##12426;&##12414;&##12377;&##12290;&##12414;&##12383;&##12289;&##33258;&##30001;&##35352;&##20837;&##27396;&##12395;&##12372;&##35352;&##20837;&##12373;&##12428;&##12383;&##24773;&##22577;&##12395;&##22522;&##12389;&##12356;&##12390;&##12450;&##12531;&##12465;&##12540;&##12488;&##21463;&##38936;&##32773;&##12364;&##12362;&##23458;&##27096;&##12434;&##29305;&##23450;&##12377;&##12427;&##21487;&##33021;&##24615;&##12364;&##12354;&##12427;&##12371;&##12392;&##12395;&##21516;&##24847;&##12373;&##12428;&##12383;&##12418;&##12398;&##12392;&##12373;&##12379;&##12390;&##12356;&##12383;&##12384;&##12365;&##12414;&##12377;&##12290;<br/><br/>
										&##12372;&##22238;&##31572;&##12399;&##12354;&##12367;&##12414;&##12391;&##12418;&##20219;&##24847;&##12391;&##12377;&##12290;&##24330;&##31038;&##12364;&##12371;&##12398;&##12450;&##12531;&##12465;&##12540;&##12488;&##35519;&##26619;&##12434;&##12452;&##12531;&##12479;&##12540;&##12493;&##12483;&##12488;&##19978;&##12391;&##34892;&##12358;&##12383;&##12417;&##12395;&##12289;&##20197;&##19979;&##12398;&##12522;&##12473;&##12463;&##12395;&##12372;&##30041;&##24847;&##12356;&##12383;&##12384;&##12367;&##12424;&##12358;&##12289;&##12362;&##39000;&##12356;&##12356;&##12383;&##12375;&##12414;&##12377;&##12290;<br/><br/>
										&##20844;&##38283;&##12398;&##12493;&##12483;&##12488;&##12527;&##12540;&##12463;&##19978;&##12391;&##36865;&##20449;&##12373;&##12428;&##12427;&##12487;&##12540;&##12479;&##12395;&##12399;&##12289;&##35504;&##12391;&##12418;&##12450;&##12463;&##12475;&##12473;&##12391;&##12365;&##12427;&##21487;&##33021;&##24615;&##12364;&##12354;&##12426;&##12414;&##12377;&##12290;&##24330;&##31038;&##12399;&##12289;&##12381;&##12398;&##12424;&##12358;&##12394;&##20844;&##38283;&##12493;&##12483;&##12488;&##12527;&##12540;&##12463;&##19978;&##12391;&##20253;&##36948;&##12373;&##12428;&##12427;&##24773;&##22577;&##12414;&##12383;&##12399;&##32032;&##26448;&##12398;&##31192;&##23494;&##24615;&##12434;&##20445;&##35388;&##12391;&##12365;&##12414;&##12379;&##12435;&##12290;&##29305;&##12395;&##12289;&##20491;&##12293;&##12398;&##12497;&##12465;&##12483;&##12488;&##12487;&##12540;&##12479;&##12399;&##24448;&##12293;&##12395;&##12375;&##12390;&##26263;&##21495;&##21270;&##12373;&##12428;&##12414;&##12377;&##12364;&##12289;&##36865;&##20449;&##32773;&##12392;&##21463;&##20449;&##32773;&##12398;&##21517;&##31216;&##12399;&##26263;&##21495;&##21270;&##12373;&##12428;&##12414;&##12379;&##12435;&##12290;&##24467;&##12387;&##12390;&##12289;&##31532;&##19977;&##32773;&##12364;&##26082;&##23384;&##12398;&##37504;&##34892;&##21475;&##24231;&##12414;&##12383;&##12399;&##21462;&##24341;&##38306;&##20418;&##12289;&##12414;&##12383;&##12399;&##20170;&##24460;&##38283;&##35373;&##12373;&##12428;&##12427;&##37504;&##34892;&##21475;&##24231;&##12434;&##25512;&##23450;&##12391;&##12365;&##12427;&##21487;&##33021;&##24615;&##12364;&##12354;&##12426;&##12414;&##12377;&##12290;&##36865;&##20449;&##32773;&##12392;&##21463;&##20449;&##32773;&##12364;&##21516;&##12376;&##22269;&##20869;&##12395;&##23621;&##20303;&##12375;&##12390;&##12356;&##12383;&##12392;&##12375;&##12390;&##12418;&##12289;&##12487;&##12540;&##12479;&##12399;&##12289;&##12362;&##23458;&##27096;&##12364;&##23621;&##20303;&##12377;&##12427;&##22269;&##12392;&##21516;&##31243;&##24230;&##12398;&##12487;&##12540;&##12479;&##20445;&##35703;&##12364;&##34892;&##12431;&##12428;&##12390;&##12356;&##12394;&##12356;&##35576;&##22269;&##12434;&##21547;&##12415;&##12289;&##22806;&##22269;&##12398;&##20844;&##38283;&##12493;&##12483;&##12488;&##12527;&##12540;&##12463;&##12395;&##23450;&##26399;&##30340;&##12395;&##12363;&##12388;&##28961;&##21046;&##38480;&##12395;&##36578;&##36865;&##12373;&##12428;&##12427;&##21487;&##33021;&##24615;&##12364;&##12354;&##12426;&##12414;&##12377;&##12290;
				</div>
			</cfif>
		</p>
		<form action="#cgi.script_name#?#cgi.query_string#" method="post">
			<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
					<input type="submit" name="disclaimer" value="Continue">
			</cfif>
			<cfif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
					<input type="submit" name="disclaimer" value="&##12388;&##12389;&##12367;">
			</cfif>
		</form>
		</cfoutput>
		<cfabort>
	</cfif>
</cfif>

<!--- Get a pointer to current session info on the survey --->
<cfset currentInfo = session.surveys[attributes.survey.id]>

<!--- how many per page? --->
<cfif isNumeric(attributes.survey.questionsperpage)>
	<cfset perpage = attributes.survey.questionsperpage>
<cfelse>
	<cfset perpage = application.settings.perpage>
</cfif>
<!--- how many pages? --->
<cfset numPages = currentInfo.maxQuestions \ perpage>
<cfif currentInfo.maxQuestions/perpage neq currentInfo.maxQuestions\perpage>
	<cfset numPages = numPages + 1>
</cfif>
<cfif currentInfo.currentStep gt 1>
	<cfset firstOnPage = (currentInfo.currentStep-1) * perpage + 1>
<cfelse>
	<cfset firstOnPage = 1>
</cfif>
<cfset lastOnPage = min(firstOnPage + perpage - 1, currentInfo.maxQuestions)>

<!--- They finished the survey --->
<cfif firstOnPage gt currentInfo.maxQuestions>
	<cfset extra = structNew()>
	<cfif structKeyExists(session.surveys[attributes.survey.id],"owner")>
		<cfset extra.owner = session.surveys[attributes.survey.id].owner>
	</cfif>		
	<cf_surveycomplete survey="#attributes.survey#" data="#session.surveys[attributes.survey.id]#" attributeCollection="#extra#"/>
	<cfset structDelete(session.surveys,attributes.survey.id)>
	<cfset surveyComplete = true>
</cfif>

<cfif isDefined("form.goback")>
	<!--- go back a step --->
	<cfif currentInfo.currentStep gte 2>
		<cfset currentInfo.currentStep = currentInfo.currentStep - 1>
		
		<!--- 
		We need to check for skipped questions. It's possible when we answer
		question X, we were told to skip ahead N questions. If we were, then
		currentStep is marked as skipped. So I will subtract one and check again.
		I eventually end up where I'm allowed to be. 

		Note that we also auto remove them.
		--->
		<cfloop condition="structKeyExists(currentInfo.toskip, currentinfo.currentstep)">
			<cfset structDelete(currentInfo.toSkip, currentInfo.currentStep)>
			<cfset currentInfo.currentStep = currentInfo.currentStep - 1>
		</cfloop>
		
		<cfloop condition="structKeyExists(currentInfo.toenter, currentinfo.currentstep)">
			<cfset structDelete(currentInfo.toEnter, currentInfo.currentStep)>
			<cfset currentInfo.currentStep = currentInfo.currentStep - 1>
		</cfloop>

		<!---
		This is a direct cut and paste of the logic below, minus all done check. Idea is when
		you hit previous we still want to store your answers, but we ignore errors. 
		--->
		<cfset form.submit = true>
		<cfloop index="step" from="#firstOnPage#" to="#lastOnPage#">
	
			<!--- Get current step --->
			<cfset question = application.question.getQuestions(attributes.survey.id,step)>
	
			<!--- fire display handler for q --->
			<cfset answer = "">
			<cfif structKeyExists(currentInfo.answers, question.id)>
				<cfset answer = currentInfo.answers[question.id]>
			</cfif>
			<cfmodule template="../handlers/#question.handlerRoot#/display.cfm" 
				step="#step#" question="#question#" answer="#answer#" r_result="result#step#" />
			
			<cfif isDefined("result#step#")>
				<!--- save answer --->
				<cfset currentInfo.answers[question.id] = variables["result#step#"]>
				<!----
				<cfset currentInfo.answers[step] = variables["result#step#"]>
				--->
			</cfif>

		</cfloop>
		
		<cflocation url="#cgi.script_name#?#cgi.query_string#" addToken="false">
	</cfif>
</cfif>


<cfif not surveyComplete>
	<cfoutput>
	<!---<div class="surveyName">#attributes.survey.name#</div>--->
	<!---
		TODO: Rework to a % for 1 per page question surveys
	--->
	<!---<cfif numPages neq 1><div class="pages">Page #currentInfo.currentStep# out of #numPages#</div></cfif>
	<div><strong class="required">Questions marked with '*' are required to complete the survey.</strong></div><br /><br />--->
	</cfoutput>
<cfelse>
	<cfoutput>
	<!---<div class="surveyDone">Survey Complete!</div>---><script type="text/javascript">document.getElementById("header").innerHTML = "";</script>
	</cfoutput>
</cfif>


<cfif not surveyComplete>

	<cfset allDone = true>

	<cfoutput>
	<form action="#cgi.script_name#?#cgi.query_string#" method="post">
	</cfoutput>
	
	<!--- loop from the first on page till end --->
	<cfloop index="step" from="#firstOnPage#" to="#lastOnPage#">
		
		<cfif step neq 1><cfoutput><script type="text/javascript">document.getElementById("header").innerHTML = "";</script></cfoutput></cfif>
		
		<!--- Get current step --->
		<cfset question = application.question.getQuestions(attributes.survey.id,step)>
		
		<!--- Check if entry criteria exists --->
		<cfif question.skips[1].recordCount>
			<cfset skips = question.skips[1]>
			<cfset answer = currentInfo.answers[skips.criteriaquestion]>

			<cfset criteriaMatches = false>
			<!--- first do a simple check - assumes answer is simple --->
			<cfif isSimpleValue(answer) and answer is skips.criteriaQuestionValue>
				<cfset criteriaMatches = true>
			</cfif>
			<!--- next support our MC with a .list key --->
			<cfif isStruct(answer) and structKeyExists(answer,"list") and listFind(answer.list, skips.criteriaQuestionValue)>
				<cfset criteriaMatches = true>
			</cfif>

			<!--- In this skipping rule, we ALWAYS go to the next q --->
			<cfif not criteriaMatches>
				<cfset currentInfo.toEnter[currentInfo.currentStep] = 1>

				<cfset currentInfo.currentStep = currentInfo.currentStep + 1>
				<cflocation url="#cgi.script_name#?#cgi.query_string#" addToken="false">
			</cfif>
		</cfif>
		
		<!--- fire display handler for q --->
		<cfset answer = "">
		<cfif structKeyExists(currentInfo.answers, question.id)>
			<cfset answer = currentInfo.answers[question.id]>
		</cfif>

		<cfmodule template="../handlers/#question.handlerRoot#/display.cfm" 
			step="#step#" question="#question#" answer="#answer#" r_result="result#step#" />
		
		<cfif isDefined("result#step#")>
			<!--- save answer --->
			<cfset currentInfo.answers[question.id] = variables["result#step#"]>
		<cfelse>
			<cfset allDone = false>
		</cfif>

		<cfset lastQuestion = question>
	</cfloop>

	<cfoutput>
		<br /><br />
		<!---<cfif numPages neq 1><div class="pages">Page #currentInfo.currentStep# out of #numPages#</div></cfif>--->
		<p>
		<cfif currentInfo.currentStep gt 1>
			<input type="submit" name="goback" value="Previous Page">
		</cfif>
		<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
			<input id="nBtn" type="submit" name="submit" value="Next Page">
		<cfelseif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
			<input id="nBtn" type="submit" name="submit" value="&##27425;&##12408;">
		<cfelse>
			<input id="nBtn" type="submit" name="submit" value="Next Page">
		</cfif>
		<cfif currentInfo.currentStep eq currentInfo.maxQuestions>
			<cfif cgi.query_string eq 'id=BB93E46B-B329-1021-4F3B8B18BD62C210'>
				<script type="text/javascript">document.getElementById("nBtn").value = "Submit";</script>
			<cfelseif cgi.query_string eq 'id=41046F96-F857-E28A-1A253A7CD94741F1'>
				<script type="text/javascript">document.getElementById("nBtn").value = "\u63D0\u51FA";</script>
			<cfelse>
				<script type="text/javascript">document.getElementById("nBtn").value = "Submit";</script>
			</cfif>
		</cfif>
		</p>
		</form>
	</cfoutput>
	
	<!--- 
	So this is the logic we need to modify for conditionals:
	
	Currently "currentStep" represents the page you are on. This works
	ok but for conditionals we need to go to a question, not a page. 
	However, we are going to document that a survey with conditionals
	should be using 1 question per page logic (and we may need to enforce it).
	
	So our logic here will be - look at the last question answered and determine if it
	has post conditional logic.

	Note - our code to load stuff in question.cfc works even if you have messed up ranks,
	ie: 1,2,4

	We can't rely on that. So I'll be updating deleteQuestion to correctly reset ranks.
	--->
	<cfif allDone>
		<cfif lastQuestion.branches[1].recordCount>
			<cfset branches = lastQuestion.branches[1]>
			<cfset setTarget = false>
			<cfloop query="branches">

				<cfif nextQuestionValue eq "">
					<!--- In this branch, we ALWAYS go to another q --->
					<cfset questionToLoad = application.question.getQuestion(nextQuestion)>
					<!--- remember we are skipping some --->
					<cfset fromSkip = currentInfo.currentStep + 1>
					<cfset toSkip = questionToLoad.rank-1>
					<cfloop index="x" from="#fromSkip#" to="#toSkip#">
						<cfset currentInfo.toSkip[fromSkip] = 1>
					</cfloop>
					<cfset currentInfo.currentStep = questionToLoad.rank>
					<cfset setTarget = true>
				<cfelse>
					<cfset answer = currentInfo.answers[lastQuestion.id]>
					<cfset theanswermatches = false>
					<!--- first do a simple check - assumes answer is simple --->
					<cfif isSimpleValue(answer) and answer is nextQuestionValue>
						<cfset theAnswerMatches = true>
					</cfif>
					<!--- next support our MC with a .list key --->
					<cfif isStruct(answer) and structKeyExists(answer,"list") and listFind(answer.list, nextQuestionValue)>
						<cfset theAnswerMatches = true>
					</cfif>	
					<cfif theanswermatches>
						<cfset questionToLoad = application.question.getQuestion(nextQuestion)>
						<cfset fromSkip = currentInfo.currentStep + 1>
						<cfset toSkip = questionToLoad.rank-1>
						<cfloop index="x" from="#fromSkip#" to="#toSkip#">
							<cfset currentInfo.toSkip[fromSkip] = 1>
						</cfloop>
						<cfset currentInfo.currentStep = questionToLoad.rank>
						<cfset setTarget = true>
					</cfif>
				</cfif>
				<cfif setTarget>
					<cfbreak>
				</cfif>
			</cfloop>

			<cfif not setTarget>
				<cfset currentInfo.currentStep = currentInfo.currentStep + 1>
			</cfif>

			<!---
			<!--- Ok, we definitely need to go someplace else. But do we have to have an answer? --->		
			<cfif lastQuestion.nextQuestionValue eq "">
				<!--- In this branch, we ALWAYS go to another q --->
				<cfset questionToLoad = application.question.getQuestion(lastQuestion.nextQuestion)>
				<!--- remember we are skipping some --->
				<cfset fromSkip = currentInfo.currentStep + 1>
				<cfset toSkip = questionToLoad.rank-1>
				<cfloop index="x" from="#fromSkip#" to="#toSkip#">
					<cfset currentInfo.toSkip[fromSkip] = 1>
				</cfloop>
				<cfset currentInfo.currentStep = questionToLoad.rank>
			<cfelse>
				<cfset answer = currentInfo.answers[lastQuestion.id]>
				<cfset theanswermatches = false>
				<!--- first do a simple check - assumes answer is simple --->
				<cfif isSimpleValue(answer) and answer is lastQuestion.nextQuestionValue>
					<cfset theAnswerMatches = true>
				</cfif>
				<!--- next support our MC with a .list key --->
				<cfif isStruct(answer) and structKeyExists(answer,"list") and listFind(answer.list, lastQuestion.nextQuestionValue)>
					<cfset theAnswerMatches = true>
				</cfif>	
				<cfif theanswermatches>
					<cfset questionToLoad = application.question.getQuestion(lastQuestion.nextQuestion)>
					<cfset fromSkip = currentInfo.currentStep + 1>
					<cfset toSkip = questionToLoad.rank-1>
					<cfloop index="x" from="#fromSkip#" to="#toSkip#">
						<cfset currentInfo.toSkip[fromSkip] = 1>
					</cfloop>
					<cfset currentInfo.currentStep = questionToLoad.rank>
				<cfelse>
					<cfset currentInfo.currentStep = currentInfo.currentStep + 1>
				</cfif>
			</cfif>
			--->
		<cfelse>
			<cfset currentInfo.currentStep = currentInfo.currentStep + 1>
		</cfif>
		<cflocation url="#cgi.script_name#?#cgi.query_string#" addToken="false">
	</cfif>
	
<cfelse>

	<cfif len(attributes.survey.thankYouMsg)>
		<cfoutput>
		<div class="surveyDone"><p>#attributes.survey.thankYouMsg#</p></div>
		<!---<form action="https://www.credit-suisse.com/global/en/">
		<input type="submit" name="surveySubmit" value="Submit">
		</form>--->
		</cfoutput>
	<cfelse>
		<cfoutput>
		<div class="surveyDone"><p>Thank you for finishing the survey.</p></div>
		</cfoutput>
	</cfif>
	
</cfif>

<cfsetting enablecfoutputonly=false>
<cfexit method="exittag">
