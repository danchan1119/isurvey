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

		<cfif isDefined("form.cancel")>
			<cflocation url="index.cfm" addToken="false">
		</cfif>
		
		<cfif isDefined("form.save")>
			<cfset errors = "">
			<!---
			<cfif hash(form.oldpassword) is not application.settings.password>
				<cfset errors = errors & "The old password did not match.<br>">
			</cfif>
			--->
			<cfif not len(form.newpassword) or form.newpassword neq form.newpassword2>
				<cfset errors = errors & "Your new password was blank or did not match the confirmation.<br>">
			</cfif>
			<cfif not len(errors)>
				<cftry>
					<cfset application.user.updatePassword(session.user.username,form.oldpassword,form.newpassword)>
					<cfset msg = "Your password has been updated.">
					<cfcatch>
						<cfset errors = cfcatch.message>
					</cfcatch>
				</cftry>
			</cfif>	
		</cfif>
		
		<legend>PROFILE</legend>
		
		<div class="row-fluid">		
			<div class="span3 offset1">
				<img class="img-rounded img-polaroid" width="50%" alt="Avatar" src="../assets/images/avatar.png">
				<p>
					<b>Username:</b>
					#session.user.username#
				</p>
			</div>
			
			<div class="span6">
		
		<p>Use the form below to update your password. You must enter the old password first.</p>
		
		<cfif isDefined("errors")><ul><b>#errors#</b></ul></cfif>
		<cfif isDefined("msg")>
			<p><b>#msg#</b></p>
		<cfelse>
		<form action="#cgi.script_name#" method="post">
		<table cellspacing=0 cellpadding=5 class="adminEditTable" width="500">
			<tr valign="top">
				<td width="200"><b>(*) Old Password:</b></td>
				<td><input type="password" name="oldpassword" value="" size="50"></td>
			</tr>
			<tr valign="top">
				<td><b>(*) New Password:</b></td>
				<td><input type="password" name="newpassword" value="" size="50"></td>
			</tr>
			<tr valign="top">
				<td nowrap="true"><b>(*) Confirm Password:</b></td>
				<td><input type="password" name="newpassword2" value="" size="50"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="submit" name="save" value="Save"> <input type="submit" name="cancel" value="Cancel"></td>
			</tr>
		</table>
		</form>
		</p>
		</cfif>
			</div>
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