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

		<cfif isDefined("url.surveyidfk")>
			<cfset form.surveyidfk = url.surveyidfk>
		</cfif>
		<cfparam name="form.surveyidfk" default="">
		
		<legend>SURVEY OPTIONS / Questions</legend>
		
		<div class="row-fluid">
		
			<!--- handle deletions --->
			<cfif isDefined("form.mark") and len(form.mark)>
				<cfloop index="id" list="#form.mark#">
					<cfset application.question.deleteQuestion(id)>
				</cfloop>
				<cfoutput>
				<p>
				<b>Questions(s) deleted.</b>
				</p>
				</cfoutput>
			</cfif>
			
			<!--- get surveys --->
			<cfif not session.user.isAdmin>
				<cfset surveys = application.survey.getSurveys(useridfk=session.user.id)>
			<cfelse>
				<cfset surveys = application.survey.getSurveys()>
			</cfif>
		
			<cfoutput>
			<script>
			function checkSubmit() {
				if(document.surveys.surveyidfk.selectedIndex != 0) document.surveys.submit();
			}
			</script>
			<p>
			<form action="#cgi.script_name#" method="get" name="surveys">
			Select a Survey <select class="span6" name="surveyidfk" onChange="checkSubmit()">
			<option value="">---</option>
			<cfloop query="surveys">
				<option value="#id#" <cfif id is form.surveyidfk>selected</cfif>>#name#</option>
			</cfloop>
			</select>
			</form>
			</p>
			</cfoutput>
			
			<cfif form.surveyidfk neq "">
				<cfset questions = application.question.getQuestions(form.surveyidfk)>		
		
				<tags:datatable data="#questions#" list="question,questiontype,rank" editlink="questions_edit.cfm" linkcol="question" label="Question" queryString="surveyidfk=#form.surveyidfk#">
					<tags:datacol colname="question" label="Question" width="400" />	
					<tags:datacol colname="questiontype" label="Question Type" width="280" />	
					<tags:datacol colname="required" label="Req." width="30" format="YesNo"/>
					<tags:datacol colname="rank" label="Rank" width="40" />
				</tags:datatable>
				
			</cfif>	
		
		</div>
		<!-- / Content here -->
		
		<!-- Page footer
			================================================== -->
		<cfinclude template="./includes/footer.cfm" >
		<!-- / Page footer -->
	</section>
</body>
</html>
</cfoutput>