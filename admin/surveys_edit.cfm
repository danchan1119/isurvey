<cfoutput>
<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js"><!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>
		#application.applicationname#
	</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width">
	
	<script src="../assets/javascripts/1.3.0/adminflare-demo-init.min.js" type="text/javascript"></script>

	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,300,600,700" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		// Include Bootstrap stylesheet 
		document.write('<link href="../assets/css/' + DEMO_VERSION + '/' + DEMO_CURRENT_THEME + '/bootstrap.min.css" media="all" rel="stylesheet" type="text/css" id="bootstrap-css">');
		// Include AdminFlare stylesheet 
		document.write('<link href="../assets/css/' + DEMO_VERSION + '/' + DEMO_CURRENT_THEME + '/adminflare.min.css" media="all" rel="stylesheet" type="text/css" id="adminflare-css">');
	</script>
	
	<script src="../assets/javascripts/1.3.0/modernizr-jquery.min.js" type="text/javascript"></script>
	<!---<script src="../assets/javascripts/1.3.0/adminflare-demo.min.js" type="text/javascript"></script>--->
	<script src="../assets/javascripts/1.3.0/bootstrap.min.js" type="text/javascript"></script>
	<script src="../assets/javascripts/1.3.0/adminflare.min.js" type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">demoSetBodyLayout();</script>
	<!-- Main navigation bar
		================================================== -->
	<cfinclude template="./includes/navbar.cfm" >
	<!-- / Main navigation bar -->
	
	<!-- Left navigation panel
		================================================== -->
	<cfinclude template="./includes/left-panel.cfm" >
	<!-- / Left navigation panel -->
	
	<!-- Page content
		================================================== -->
	<section class="container">

		<!-- Content here
			================================================== -->
		<cfimport taglib="../tags/" prefix="tags">

<cfif isDefined("form.cancel") or not isDefined("url.id")>
	<cflocation url="surveys.cfm" addToken="false">
</cfif>

<cfif isDefined("form.save")>
	<cfset form = request.udf.cleanStruct(form,"thankyoumsg")>
	<cfset errors = "">
	<cfif not len(form.name)>
		<cfset errors = errors & "You must specify a name.<br>">
	</cfif>
	<cfif not len(form.description)>
		<cfset errors = errors & "You must specify a description.<br>">
	</cfif>
	<cfif len(form.dateBegin) and not isDate(form.dateBegin)>
		<cfset errors = errors & "If you specify a survey starting date, it must be a valid date.<br>">
		<cfset form.dateBegin = "">
	</cfif>
	<cfif len(form.dateEnd) and not isDate(form.dateEnd)>
		<cfset errors = errors & "If you specify a survey ending date, it must be a valid date.<br>">
		<cfset form.dateEnd = "">
	</cfif>
	<cfif len(form.dateBegin) and isDate(form.dateBegin) and len(form.dateEnd) and isDate(form.dateEnd)
	      and dateCompare(form.dateBegin,form.dateEnd,"s") gte 0>
		<cfset errors = errors & "If you specify a survey starting and ending date, the start date must be before the ending date.<br>">
	</cfif>
	<cfif len(form.resultMailTo)>
		<cfloop index="e" list="#form.resultMailTo#">
			<cfif not isValid("email", e)>
				<cfset errors = errors & "The value to send results to must be a valid email address or a list of valid email addresses. #e# is not valid.<br>">
			</cfif>
		</cfloop>
	</cfif>
	<cfif len(form.questionsperpage) and (
			not isNumeric(form.questionsperpage)
				or
			form.questionsperpage lte 0
		)>
		<cfset errors = errors & "The value for questions per page must be numeric and positive.<br/>">
	</cfif> 
	<cfif form.active>
		<cfif url.id eq 0>
			<cfset errors = errors & "A new survey cannot be active. You must first add questions.<br>">
		<cfelse>
			<!--- get questions --->
			<cfset q = application.question.getQuestions(url.id)>
			<cfif q.recordCount is 0>
				<cfset errors = errors & "This survey cannot be marked active until questions are added.<br>">
			</cfif>
		</cfif>
	</cfif>
	
	<!--- Nuke the old list --->	
	<cfif isDefined("form.nukeEL")>
		<cfset application.survey.resetEmailList(url.id)>
	</cfif>
		
	<cfif not len(errors)>

		<cfset data = structNew()>
		<cfset data.name = form.name>
		<cfset data.description = form.description>
		<cfset data.active = form.active>
		<cfif isDate(form.dateBegin)>
			<cfset data.dateBegin = form.dateBegin>
		</cfif>
		<cfif isDate(form.dateEnd)>
			<cfset data.dateEnd = form.dateEnd>
		</cfif>
		<cfset data.resultMailTo = form.resultMailTo>
		<cfset data.surveyPassword = form.surveyPassword>
		<cfset data.thankYouMsg = form.thankYouMsg>
		
		<cfset data.templateidfk = form.templateidfk>
		<cfset data.allowembed = form.allowembed>
		<cfset data.showinpubliclist = form.showinpubliclist>
		<cfif form.questionsperpage neq "">
			<cfset data.questionsperpage = form.questionsperpage>
		</cfif>
			
		<cfif url.id neq 0>
			<cfset data.id = url.id>
			<cfset application.survey.updateSurvey(argumentCollection=data)>
		<cfelse>
			<cfset data.useridfk = session.user.id>
			<cfset url.id = application.survey.addSurvey(argumentCollection=data)>		
		</cfif>
		
		<cfif len(trim(form.emailList))>
			<cfset emails = arrayNew(1)>
			<cffile action="UPLOAD" filefield="form.emailList" destination="#expandPath("./uploads")#" nameconflict="MAKEUNIQUE">
			<cfset theFile = cffile.serverDirectory & "/" & cffile.serverFile>
			<cffile action="read" file="#theFile#" variable="buffer">
			<!--- attempt to read the buffer --->
			<cfloop index="line" list="#buffer#" delimiters="#chr(10)#">
				<cfif len(trim(line)) and request.udf.isEmail(trim(line))>
					<cfset arrayAppend(emails, trim(line))>
				</cfif>
			</cfloop>
			<cfset application.survey.resetEmailList(url.id)>
			<cfif arrayLen(emails)>
				<cfset application.survey.addEmailList(url.id,emails)>
			</cfif>
			<!--- cleanup --->
			<cffile action="delete" file="#theFile#">
		</cfif>
				
		<cfset msg = "Survey, #form.name#, has been updated.">
		<cflocation url="surveys.cfm?msg=#urlEncodedFormat(msg)#">
	</cfif>
</cfif>

<cfif isDefined("form.dupe") and url.id neq 0>
	<cfset application.survey.duplicateSurvey(url.id)>
	<cfset msg = "Survey, #form.name#, has been duplicated.">
	<cflocation url="surveys.cfm?msg=#urlEncodedFormat(msg)#">
</cfif>

<cfif isDefined("form.clear") and url.id neq 0>
	<cfset application.survey.clearResults(url.id)>
	<cfset msg = "Survey, #form.name#, has had its results cleared.">
	<cflocation url="surveys.cfm?msg=#urlEncodedFormat(msg)#">
</cfif>

<!--- get survey if not new --->
<cfif url.id neq 0>
	<cfif not session.user.isAdmin>
		<cfset survey = application.survey.getSurvey(url.id, session.user.id)>
	<cfelse>
		<cfset survey = application.survey.getSurvey(url.id)>
	</cfif>
	<!--- get the templates based on the survey owner, which may not be me if I'm a admin --->
	<cfset templates = application.template.getTemplates(survey.useridfk)>
	<cfset emailList = application.survey.getEmailList(url.id)>
	<cfparam name="form.name" default="#survey.name#">
	<cfparam name="form.description" default="#survey.description#">
	<cfparam name="form.active" default="#survey.active#">
	<cfparam name="form.dateBegin" default="#survey.dateBegin#">
	<cfparam name="form.dateEnd" default="#survey.dateEnd#">
	<cfparam name="form.resultMailTo" default="#survey.resultMailTo#">
	<cfparam name="form.surveyPassword" default="#survey.surveyPassword#">
	<cfparam name="form.thankYouMsg" default="#survey.thankYouMsg#">
	<cfparam name="form.templateidfk" default="#survey.templateidfk#">
	<cfparam name="form.allowembed" default="#survey.allowembed#">
	<cfparam name="form.showinpubliclist" default="#survey.showinpubliclist#">
	<cfparam name="form.questionsperpage" default="#survey.questionsperpage#">
<cfelse>
	<cfparam name="form.name" default="">
	<cfparam name="form.description" default="">
	<cfparam name="form.active" default="false">
	<cfparam name="form.dateBegin" default="">
	<cfparam name="form.dateEnd" default="">
	<cfparam name="form.resultMailTo" default="">
	<cfparam name="form.surveyPassword" default="">
	<cfparam name="form.thankYouMsg" default="">
	<cfparam name="form.templateidfk" default="">
	<cfparam name="form.allowembed" default="">
	<cfparam name="form.showinpubliclist" default="">
	<cfparam name="form.questionsperpage" default="">
	<cfset templates = application.template.getTemplates(session.user.id)>
</cfif>

<!---<tags:layout templatename="admin" title="Survey Editor">--->

<cfoutput>
<script>
function viewEmailList() {
	window.open("viewemaillist.cfm?id=#url.id#","viewEmailList","width=500,height=600");
}
</script>

<legend>SURVEY OPTIONS / Surveys / Edit</legend>

<p>
Please use the form below to enter details about the survey. All required fields are marked (*). The values
for date survey begins and ends allows you to restrict by date when surveys can be answered. If a survey password
is set, then it must be provided before the user can take the survey.
</p>

<cfif structKeyExists(variables, "survey") and survey.active>
	<!--- create a link to index.cfm --->
	<cfset rootURL = cgi.script_name>
	<cfset rootURL = listDeleteAt(rootURL, listLen(rootURL, "/"), "/")>
	<!--- pop out one more --->
	<cfset rootURL = listDeleteAt(rootURL, listLen(rootURL, "/"), "/")>
	<!--- now add root server --->
	<cfset rootServer = cgi.server_name>
	<cfif cgi.server_port neq 80>
		<cfset rootServer = rootServer & ":#cgi.server_port#">
	</cfif>
	<cfset rootURL = "http://" & rootServer & rootURL>
	<cfif right(rootURL,1) is not "/">
		<cfset rootURL = rootURL & "/">
	</cfif>
	
<div class="alert alert-info">
	Users can take your survey by visiting this URL:<br /> #rootURL#survey.cfm?id=#survey.id#<br />
	<cfif survey.allowEmbed>
	<br />
	This survey can be embedded in other sites using this HTML:<br/>
	&lt;iframe src="#rootURL#survey.cfm?id=#survey.id#&embed=true" style="border: 1px solid black; width:500px; height: 500px;"&gt;<br/>
	&lt;/iframe&gt;
	</cfif>
</div>
</cfif>

<p>
<cfif isDefined("errors")><ul><b>#errors#</b></ul></cfif>
<form action="#cgi.script_name#?#cgi.query_string#" method="post" enctype="multipart/form-data">
<table cellspacing=0 cellpadding=5 class="adminEditTable" width="100%">
	<tr valign="top">
		<td width="200"><b>(*) Name:</b></td>
		<td><input class="span6" type="text" name="name" value="#form.name#" size="50"></td>
	</tr>
	<cfif session.user.isAdmin and structKeyExists(variables, "survey")>
	<tr valign="top">
		<td width="200"><b>User:</b></td>
		<td>#survey.username#</td>
	</tr>
	</cfif>
	<tr valign="top">
		<td><b>(*) Description:</b></td>
		<td><textarea class="span6" name="description" rows=6 cols=35 wrap="soft">#form.description#</textarea></td>
	</tr>
	<tr valign="top">
		<td><b>Template:</b></td>
		<td>
		<select name="templateidfk">
		<option value="" <cfif form.templateidfk is "">selected</cfif>>No Template</option>
		<cfloop query="templates">
		<option value="#id#" <cfif form.templateidfk is id>selected</cfif>>#name#</option>
		</cfloop>
		</select>
		</td>
	</tr>	
	<tr valign="top">
		<td><b>Message Displayed at End:</b></td>
		<td><textarea class="span6" name="thankyoumsg" rows=6 cols=35 wrap="soft">#form.thankyoumsg#</textarea></td>
	</tr>

	<cfif url.id eq 0>
		<input type="hidden" name="active" value="0">
	<cfelse>
	<tr valign="top">
		<td><b>(*) Active:</b></td>
		<td><select name="active">
		<option value="1" <cfif form.active>selected</cfif>>Yes</option>
		<option value="0" <cfif not form.active>selected</cfif>>No</option>
		</select></td>
	</tr>
	</cfif>
	<tr valign="top">
		<td><b>(*) Allow Embedding:</b></td>
		<td><select name="allowembed">
		<option value="1" <cfif isBoolean(form.allowembed) and form.allowembed>selected</cfif>>Yes</option>
		<option value="0" <cfif not isBoolean(form.allowembed) or not form.allowembed>selected</cfif>>No</option>
		</select></td>
	</tr>
	<tr valign="top">
		<td><b>(*) Show in Public List:</b></td>
		<td><select name="showinpubliclist">
		<option value="1" <cfif isBoolean(form.showinpubliclist) and form.showinpubliclist>selected</cfif>>Yes</option>
		<option value="0" <cfif not isBoolean(form.showinpubliclist) or not form.showinpubliclist>selected</cfif>>No</option>
		</select></td>
	</tr>
	<tr valign="top">
		<td><b>Questions Per Page:</b></td>
		<td><input type="text" name="questionsperpage" value="#form.questionsperpage#"><br/>
		If blank, defaults to #application.settings.perpage#. <b>Notice:</b> If your survey
		makes use of <i>any</i> post-question conditionals, you must set this value to 1 or
		the survey will not work correctly.
		</td>
	</tr>
	<tr valign="top">
		<td><b>Date Survey Begins:</b></td>
		<td><input type="text" name="dateBegin" value="#dateFormat(form.dateBegin)# #timeFormat(form.dateBegin)#" size="50"></td>
	</tr>
	<tr valign="top">
		<td><b>Date Survey Ends:</b></td>
		<td><input type="text" name="dateEnd" value="#dateFormat(form.dateEnd)# #timeFormat(form.dateEnd)#" size="50"></td>
	</tr>	
	<tr valign="top">
		<td><b>Mail Results To:</b></td>
		<td><input type="text" name="resultMailTo" value="#form.resultMailTo#" size="50" maxlength="255"></td>
	</tr>
	<tr valign="top">
		<td><b>Survey Password:</b></td>
		<td><input type="text" name="surveyPassword" value="#form.surveyPassword#" size="50"></td>
	</tr>
	<tr>
		<td colspan="2">
		<b>Email Restriction List:</b><br>
		Along with using a survey password, a survey can be restricted to a set of email addresses. In order to do this,
		you must create a text file of addresses (one per line) and upload it using the field below. This operation will overwrite any
		existing list of email addresses.
		<cfif url.id neq 0>
			This survey currently <b><cfif not emailList.recordCount>does not<cfelse>has</cfif></b> a restricted email list. <cfif emailList.recordCount>You can view this list <a href="javaScript:viewEmailList()">here</a>.</cfif>
		</cfif>
		<br><br>
		<input type="file" name="emailList">
		<br>
		<input type="checkbox" name="nukeEL"> Remove Current Email List		
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" name="save" value="Save">
		<cfif url.id neq 0> 
		<input type="submit" name="dupe" value="Duplicate"> 
		<input type="submit" name="clear" value="Clear Results"> 
		</cfif> 
		<input type="submit" name="cancel" value="Cancel"></td>
	</tr>
</table>
</form>
</p>
</cfoutput>

<!---</tags:layout>--->
		<!-- / Content here -->
		
		<!-- Page footer
			================================================== -->
		<cfinclude template="./includes/footer.cfm" >
		<!-- / Page footer -->
	</section>
</body>
</html>
</cfoutput>