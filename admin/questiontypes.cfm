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

		<!--- Security Check --->
		<cfif not isBoolean(session.user.isAdmin) or not session.user.isAdmin>
			<cflocation url="index.cfm" addToken="false">
		</cfif>
		
		<legend>SURVEY OPTIONS / Question Types</legend>
		
		<div class="row-fluid">
		
			<!--- handle deletions --->
			<cfif isDefined("form.mark") and len(form.mark)>
				<cfloop index="id" list="#form.mark#">
					<cfset application.questionType.deleteQuestionType(id)>
				</cfloop>
				<cfoutput>
				<p>
				<b>QuestionType(s) deleted.</b>
				</p>
				</cfoutput>
			</cfif>
			
			<!--- get qts --->
			<cfset qts = application.questionType.getQuestionTypes()>
		
			
			<tags:datatable data="#qts#" list="name,handlerroot" editlink="questiontypes_edit.cfm" linkcol="name" label="QuestionType"
							deleteMsg="Warning - this will delete the questionType including all related questions.">
				<tags:datacol colname="name" label="Name" width="400" />	
				<tags:datacol colname="handlerroot" label="Handler Root" width="200" />	
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