<cfsetting enablecfoutputonly=true>
<!---
	Name         : handlers/truefalse/edit.cfm
	Author       : Daniel Chan 
	Created      : February 23, 2013
	Last Updated : March 02, 2013
	History      : Added option for section header, added code for DP (2013-03-02)
	Purpose		 : Supports True/False, Yes/No
--->

<cfparam name="attributes.yesno" default="false">
<cfparam name="answers" default="#arrayNew(1)#">

<cfif isDefined("attributes.question")>
	<cfparam name="form.header" default="#attributes.question.header#">
	<cfparam name="form.question" default="#attributes.question.question#">
	<cfparam name="form.rank" default="#attributes.question.rank#">
	<cfparam name="form.required" default="#attributes.question.required#">
	<cfloop query="attributes.question.answers">
		<cfset answers[arrayLen(answers)+1] = structNew()>
		<cfset answers[arrayLen(answers)].answer = answer>
		<cfset answers[arrayLen(answers)].rank = rank>
		<cfset answers[arrayLen(answers)].code = code>
		<cfset answers[arrayLen(answers)].id = id>
	</cfloop>
<cfelse>
	<cfparam name="form.header" default="">
	<cfparam name="form.question" default="">
	<cfparam name="form.rank" default="#attributes.toprank+1#">
	<cfparam name="form.required" default="false">
</cfif>
<cfparam name="form.answer_new" default="">
<cfparam name="form.rank_new" default="">
<cfparam name="form.code_new" default="">
<cfparam name="form.answer_new2" default="">
<cfparam name="form.rank_new2" default="">
<cfparam name="form.code_new2" default="">

<cfif isDefined("form.delete")>
	<cfset index = listLast(form.delete," ")>
	<cfset id = answers[index].id>
	<cfset application.question.deleteAnswer(id)>
	<cfset arrayDeleteAt(answers,index)>
</cfif>

<cfif isDefined("form.save") OR isDefined("form.saveaddmore")>
	<cfset form = request.udf.cleanStruct(form)>
	<cfset errors = "">

	<cfif not len(form.question)>
		<cfset errors = errors & "You must enter a question.<br>">
	</cfif>
	
	<cfif form.rank is "" or not isNumeric(form.rank) or form.rank lte 0>
		<cfset errors = errors & "Rank must be 1 or above.<br>">
	</cfif>
	
	<cfset answers = arrayNew(1)>
	<cfset counter = 1>
	<cfloop condition="isDefined(""form.answer#counter#"")">
		<cfset a = form["answer#counter#"]>
		<cfset r = form["rank#counter#"]>
		<cfset c = form["code#counter#"]>
		<cfif len(a) and len(r) and isNumeric(r) and r gte 1>
			<cfset answers[arrayLen(answers)+1] = structNew()>
			<cfset answers[arrayLen(answers)].answer = a>
			<cfset answers[arrayLen(answers)].rank = r>
			<cfset answers[arrayLen(answers)].code = c>
			<cfif isDefined("form.answerid#counter#")>
				<cfset answers[arrayLen(answers)].id = form["answerid#counter#"]>
			</cfif>
		</cfif>
		<cfif a is "" and r is "">
			<!--- deletion of answer, it's ok, really --->
		<cfelse>
			<cfif a is "">
				<cfset errors = errors & "The answer cannot be blank.<br>">
			<cfelseif r is "">
				<cfset errors = errors & "The rank for #a# cannot be blank.<br>">
			<cfelseif not isNumeric(r) or r lte 0>
				<cfset errors = errors & "The rank, #r#, must be numeric and greater than zero.<br>">
			<cfelseif c is "">
				<cfset errors = errors & "The code for #a# cannot be blank.<br>">
			<cfelseif not isNumeric(c)>
				<cfset errors = errors & "The code, #c#, must be numeric.<br>">
			</cfif>
		</cfif>
		<cfset counter = counter + 1>
	</cfloop>
	<cfif len(form.answer_new)>
		<cfif not len(form.rank_new) or not isNumeric(form.rank_new) or form.rank_new lte 0>
			<cfset errors = errors & "Your rank for the new answer must be numeric and greater than one.<br>">
		<cfelseif not len(form.code_new) or not isNumeric(form.code_new)>
			<cfset errors = errors & "Your code for the new answer must be numeric.<br>">
		<cfelse>
			<cfset answers[arrayLen(answers)+1] = structNew()>
			<cfset answers[arrayLen(answers)].answer = form.answer_new>
			<cfset answers[arrayLen(answers)].rank = form.rank_new>
			<cfset answers[arrayLen(answers)].code = form.code_new>
			<cfset form.answer_new = "">
			<cfset form.rank_new = "">
			<cfset form.code_new = "">
		</cfif>
	</cfif>
	<cfif len(form.answer_new2)>
		<cfif not len(form.rank_new2) or not isNumeric(form.rank_new2) or form.rank_new2 lte 0>
			<cfset errors = errors & "Your rank for the new answer must be numeric and greater than one.<br>">
		<cfelseif not len(form.code_new2) or not isNumeric(form.code_new2)>
			<cfset errors = errors & "Your code for the new answer must be numeric.<br>">
		<cfelse>
			<cfset answers[arrayLen(answers)+1] = structNew()>
			<cfset answers[arrayLen(answers)].answer = form.answer_new2>
			<cfset answers[arrayLen(answers)].rank = form.rank_new2>
			<cfset answers[arrayLen(answers)].code = form.code_new2>
			<cfset form.answer_new2 = "">
			<cfset form.rank_new2 = "">
			<cfset form.code_new2 = "">
		</cfif>
	</cfif>

	<cfif arrayLen(answers) lt 2>
		<cfset errors = errors & "You must have at least two answers.<br>">
	</cfif>
	
	<cfif not len(errors)>
		<cftry>
			<cfif not isDefined("attributes.question")>
				<cfset qid = application.question.addQuestion(question=form.question,rank=form.rank,required=form.required,surveyidfk=attributes.surveyidfk,questiontypeidfk=attributes.questionType.id,header=form.header,answers=answers)>
			<cfelse>
				<cfset application.question.updateQuestion(id=attributes.question.id,question=form.question,rank=form.rank,required=form.required,surveyidfk=attributes.surveyidfk,questiontypeidfk=attributes.questiontype.id,header=form.header,answers=answers)>
				<cfset qid = attributes.question.id>
			</cfif>

			<cfinclude template="../nextquestionlogic.cfm">

			<cfset msg = "Your question has been saved.">
			
			<!--- If we simply 'save' then we go back to the survey questions --->
			<cfif isDefined("form.save")>
				<cflocation url="questions.cfm?surveyidfk=#attributes.surveyidfk#&msg=#urlEncodedFormat(msg)#" addToken="false">
			<cfelseif isDefined("form.saveaddmore")>
				<!--- form.saveaddmore will bring you back to this form to add more questions  --->
				<cflocation url="questions_edit.cfm?surveyidfk=#attributes.surveyidfk#&id=#qid#" addToken="false">
			</cfif>
			
			<cfcatch>
				<cfset errors = cfcatch.message>
			</cfcatch>
		</cftry>

	</cfif>
	
</cfif>

<cfoutput>

<cfif attributes.yesno>
	<p>
	Please use the form below to edit the Yes/No question. You only need to enter the question and the rank.
	</p>
<cfelse>
	<p>
	Please use the form below to edit the Specify question. You only need to enter the question and the rank.
	</p>
</cfif>

<p>
<cfif isDefined("errors")><ul><b>#errors#</b></ul></cfif>
<form action="#cgi.script_name#?#attributes.queryString#" method="post">
<table cellspacing=0 cellpadding=5 class="adminEditTable" width="100%">
	<tr valign="top">
		<td width="200"><b>Section Header:</b></td>
		<td><input type="text" name="header" value="#form.header#" size="50"></td>
	</tr>
	<tr valign="top">
		<td><b>(*) Question:</b></td>
		<td><input type="text" name="question" value="#form.question#" size="50"></td>
	</tr>
	<tr valign="top">
		<td><b>(*) Rank:</b></td>
		<td><input type="text" name="rank" value="#form.rank#" size="2"></td>
	</tr>
	<tr valign="top">
		<td><b>(*) Required:</b></td>
		<td>
			<input type="radio" name="required" value="true" <cfif form.required>checked</cfif>>Yes<br>	
			<input type="radio" name="required" value="false" <cfif not form.required>checked</cfif>>No<br>
		</td>
	</tr>
	<!--- Answers --->
	<cfloop index="x" from="1" to="#arrayLen(answers)#">
		<cfif structKeyExists(answers[x],"id")>
			<input type="hidden" name="answerid#x#" value="#answers[x].id#">
		</cfif>
		<tr>
			<td><b>Answer #x#:</b></td>
			<td><input type="text" name="answer#x#" value="#answers[x].answer#" size="50"></td>
		</tr>
		<tr valign="top">
			<td><b>Rank #x#:</b></td>
			<td><input type="text" name="rank#x#" value="#answers[x].rank#" size="2"></td>
		</tr>
		<tr valign="top">
			<td><b>Code #x#:</b></td>
			<td><input type="text" name="code#x#" value="#answers[x].code#" size="2"> <cfif structKeyExists(answers[x],"id")><input type="submit" name="delete" value="Delete Answer #x#" onClick="return confirm('This change cannot be undone. Are you sure?')"></cfif></td>
		</tr>
	</cfloop>
	<tr>
		<td><b>New Answer:</b></td>
		<td><input type="text" name="answer_new" value="#form.answer_new#" size="50"></td>
	</tr>
	<tr valign="top">
		<td><b>New Rank:</b></td>
		<td><input type="text" name="rank_new" value="#form.rank_new#" size="2"></td>
	</tr>
	<tr valign="top">
		<td><b>New Code:</b></td>
		<td><input type="text" name="code_new" value="#form.code_new#" size="2"></td>
	</tr>
	<tr>
		<td><b>New Answer:</b></td>
		<td><input type="text" name="answer_new2" value="#form.answer_new2#" size="50"></td>
	</tr>
	<tr valign="top">
		<td><b>New Rank:</b></td>
		<td><input type="text" name="rank_new2" value="#form.rank_new2#" size="2"></td>
	</tr>
	<tr valign="top">
		<td><b>New Code:</b></td>
		<td><input type="text" name="code_new2" value="#form.code_new2#" size="2"></td>
	</tr>
	<cfinclude template="../nextquestion.cfm">
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="submit" name="save" value="Save">
			<input type="submit" name="saveaddmore" value="Save and add more answers">
			<input type="submit" name="cancel" value="Cancel">
		</td>
	</tr>
</table>
</form>
</p>

</cfoutput>

<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">