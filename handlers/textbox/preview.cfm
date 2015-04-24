<cfparam name="attributes.data">

<cfset question = {}>
<cfset question.header = attributes.data[1].value>
<cfset question.question = attributes.data[2].value>
<cfset question.required = attributes.data[4].value>

<cfmodule template="display.cfm"
	step="1" question="#question#" answer="" r_result="resultDoesntMatter" />

<cfexit method="exitTag">