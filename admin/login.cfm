﻿<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js"><!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>
		<cfoutput>#application.applicationname#</cfoutput> - Sign In
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
		// Include AdminFlare page stylesheet 
		document.write('<link href="../assets/css/' + DEMO_VERSION + '/pages.min.css" media="all" rel="stylesheet" type="text/css">');
	</script>
	
	<script src="../assets/javascripts/1.3.0/modernizr-jquery.min.js" type="text/javascript"></script>
	<!---<script src="assets/javascripts/1.3.0/adminflare-demo.min.js" type="text/javascript"></script>--->

	<!--[if lte IE 9]>
		<script src="../assets/javascripts/jquery.placeholder.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function () {
				$('input, textarea').placeholder();
			});
		</script>
	<![endif]-->
	
	<script type="text/javascript">
		$(document).ready(function() {
			/*
			$('#signin-container').submit(function() {
				document.location = '';
				return false;
			});
			*/

			var updateBoxPosition = function() {
				$('#signin-container').css({
					'margin-top': ($(window).height() - $('#signin-container').height()) / 2
				});
			};
			$(window).resize(updateBoxPosition);
			setTimeout(updateBoxPosition, 50);
		});
	</script>
</head>
<body class="signin-page">
	
	<!-- Page content
		================================================== -->
	<section id="signin-container">
		<a href="" title="ORC International" class="header">
			<span>Sign in to</span><br><br>
			<img src="../assets/images/ORC-Intl_WHITE-600-55mm.png" alt="ORC International"><br>
			<span class="pull-right"><strong>iSurvey</strong></span>
		</a>
		<cfoutput>
		<form action="#cgi.script_name#" method="post" accept-charset="utf-8" name="loginform">
			<fieldset>
				<div class="fields">
					<input type="text" name="username" placeholder="user@example.com" id="id_username" tabindex="1">

					<input type="password" name="password" placeholder="Password" id="id_password" tabindex="2">
				</div>
				<a href="mailto:Daniel.Chan@ORCInternational.com" title="" tabindex="3" class="forgot-password">Forgot?</a>
				
				<br>

				<button type="submit" class="btn btn-primary btn-block" tabindex="4">Sign In</button>
				<cfif isDefined("session.loginmsg")><div class="alert alert-error" role="alert" style="font-size:11px;">#session.loginmsg#</div></cfif>				
			</fieldset>
		</form>
		</cfoutput>
		<br>
		<!--<div class="social">
			<p>...or sign in with</p>

			<a href="" title="" tabindex="5" class="twitter">
				<i class="icon-twitter"></i>
			</a>

			<a href="" title="" tabindex="6" class="facebook">
				<i class="icon-facebook"></i>
			</a>

			<a href="" title="" tabindex="7" class="google">
				<i class="icon-google-plus"></i>
			</a>
		</div>-->
	</section>

	<script language="JavaScript" type="text/javascript">
		document.loginform.username.focus();
	</script>
	
</body>
</html>