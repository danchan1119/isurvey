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
		
		<legend>SURVEY OPTIONS / Surveys</legend>
		
		<div class="row-fluid">

			<!--- handle deletions --->
			<cfif isDefined("form.mark") and len(form.mark)>
				<cfloop index="id" list="#form.mark#">
					<cfset application.survey.deleteSurvey(id)>
				</cfloop>
				<cfoutput>
				<p>
				<b>Survey(s) deleted.</b>
				</p>
				</cfoutput>
			</cfif>
			
			<!--- get surveys --->
			<cfif not session.user.isAdmin>
				<cfset surveys = application.survey.getSurveys(useridfk=session.user.id)>
			<cfelse>
				<cfset surveys = application.survey.getSurveys()>
			</cfif>
			
			<cfset queryAddColumn(surveys, "questions", arrayNew(1))>
			<cfloop query="surveys">
				<cfset querySetCell(surveys, "questions", "<a href='questions.cfm?surveyidfk=#id#'>Questions</a>", currentRow)>
			</cfloop>
			
			<tags:datatable data="#surveys#" list="name,description,active" editlink="surveys_edit.cfm" linkcol="name" label="Survey"
							deleteMsg="Warning - this will delete the survey including all related questions and responses.">
				<tags:datacol colname="name" label="Name" width="200" />	
				<tags:datacol colname="description" label="Description" width="400" />	
				<cfif session.user.isAdmin>
					<tags:datacol colname="username" label="User" width="100" />	
				</cfif>
				<tags:datacol colname="active" label="Active" width="50" format="YesNo" />	
				<tags:datacol colname="totalresults" label="Results" width="50"  />	
				<tags:datacol colname="questions" label="Questions" width="50"  />	
		
			</tags:datatable>
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