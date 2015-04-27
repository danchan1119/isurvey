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
	<script src="../includes/jquery.json-2.2.min.js" type="text/javascript"></script>
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

		<cfif not isDefined("url.surveyidfk")>
			<cflocation url="questions.cfm" addToken="false">
		</cfif>
		<cfif isDefined("form.cancel")>
			<cflocation url="questions.cfm?surveyidfk=#url.surveyidfk#" addToken="false">
		</cfif>
		
		<!--- get question if not new --->
		<cfif url.id neq 0>
			<cfset question = application.question.getQuestion(url.id)>
			<cfset form.questionType = question.questionTypeIDFK>
		</cfif>
		
		
		<!--- get question types --->
		<cfset qts = application.questiontype.getQuestionTypes()>
		<!--- get all questions for survey --->
		<cfset questions = application.question.getQuestions(url.surveyidfk)>
		
		<legend>SURVEY OPTIONS / Questions / Edit</legend>
		
		<div class="row-fluid">		
		<cfif isDefined("url.questionType")>
			<cfset form.questionType = url.questionType>
		</cfif>
		<cfif not isDefined("form.questionType")>
		
			<cfoutput>
			<p>
			<form action="questions_edit.cfm?#cgi.query_string#" method="post">
			Please select a question type: 
			<select name="questionType">
			<cfloop query="qts">
			<option value="#id#">#name#</option>
			</cfloop>
			</select>
			<br>
			<input type="submit" value="Submit"> <input type="submit" name="cancel" value="Cancel">
			</form>
			</p>
			</cfoutput>
			
		<cfelse>
		
			<cfset qt = application.questionType.getQuestionType(form.questionType)>
			
			<cfset qs = cgi.query_string>
			<cfif not findNoCase("questionType",qs)>
				<cfset qs = qs & "&questionType=#form.questionType#">
			</cfif>
			
			<cfset extra = structNew()>
			<cfif url.id is not 0>
				<!--- pass the question in --->
				<cfset extra.question = question>
			</cfif>
			
			<cfset top = application.survey.getTopRank(surveyidfk)>
			
			<!--- fire edit handler for qt --->
			<cfoutput><div id="formwatcher"></cfoutput>
			
			<cfmodule template="../handlers/#qt.handlerRoot#/edit.cfm" 
				queryString="#qs#" 
				surveyidfk="#surveyidfk#" 
				topRank="#top#"
				questionType="#qt#"
				attributeCollection="#extra#"
				questions="#questions#"
					  
				 />
			<cfoutput></div></cfoutput>
			
			<!--- live preview box --->
			<cfoutput>
			<script>
			$(document).ready(function() {
				function doPreview(){
					//gather all the form fields
					var fields = $("##formwatcher input").serializeArray();
					var data = $.toJSON(fields);
					$.post("preview.cfm", {data:data,questiontype:'#qt.id#'}, function(res) {
						$("##livepreviewbox").html(res);
					});		
				}
				$("##formwatcher input").change(doPreview);
				doPreview();
			});
			</script>
			<style>
			##livepreview {
				width: 90%;
				//height: 200px;
				margin:10px;
				padding: 5px;
				border-style:solid;
				border-width: thin;
		    }
			
			##livepreview h2 {
				margin-top:0px;
			}
			</style>
			<div id="livepreview">
				<h2>Live Preview</h2>
				<div id="livepreviewbox"></div>
			</div>
			</cfoutput>
			
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