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
		
		<cfif isDefined("form.cancel") or not isDefined("url.id")>
			<cflocation url="users.cfm" addToken="false">
		</cfif>
		
		<cfif isDefined("form.save")>
			<cfset form = request.udf.cleanStruct(form)>
			<cfset errors = "">
			<cfif not len(form.username)>
				<cfset errors = errors & "You must specify a username.<br>">
			</cfif>
			<cfif url.id is 0 and not len(form.password)>
				<cfset errors = errors & "You must specify a password for a new user.<br>">
			</cfif>
				
			<cfif not len(errors)>
		
				<cfset data = structNew()>
				<cfset data.username = form.username>
				<cfif len(trim(form.password))>
					<cfset data.password = form.password>
				</cfif>
				<cfset data.isAdmin = form.isAdmin>
				
				<cftry>	
					<cfif url.id neq 0>
						<cfset user = application.user.getUser(url.id)>
						<cfset data.id = user.id>
						<cfset data.originalusername = user.username>
						<cfset application.user.updateUser(argumentCollection=data)>
					<cfelse>
						<cfset application.user.addUser(argumentCollection=data)>		
					</cfif>
					<cfset msg = "User, #form.username#, has been updated.">
					<cflocation url="users.cfm?msg=#urlEncodedFormat(msg)#" addToken="false">
					<cfcatch>
						<cfset errors = cfcatch.message><cfdump var="#cfcatch#">
					</cfcatch>
				</cftry>
						
			</cfif>
		</cfif>
		
		<!--- get user if not new --->
		<cfif url.id neq 0>
			<cfset user = application.user.getUser(url.id)>
			<cfparam name="form.username" default="#user.username#">
			<cfif not isBoolean(user.isAdmin) or not user.isAdmin>
				<cfparam name="form.isadmin" default="false">
			<cfelse>
				<cfparam name="form.isadmin" default="true">
			</cfif>
		<cfelse>
			<cfparam name="form.username" default="">
			<cfparam name="form.isadmin" default="false">
		</cfif>
		
		<legend>USERS / Edit</legend>
		
		<div class="row-fluid">	
		
		<cfoutput>
		<p>
		Please use the form below to enter details about the user. All required fields are marked (*). 
		Because passwords are hashed in the database, you cannot set the current password. If you enter
		a new password it will overwrite the old one.
		</p>
		
		<p>
		Admin users are allowed to edit other users and work with question types. If you are working
		with a user that should only create surveys, be sure to set Admin to false.
		</p>
		
		<p>
		<cfif isDefined("errors")><ul><b>#errors#</b></ul></cfif>
		<form action="#cgi.script_name#?#cgi.query_string#" method="post" autocomplete="off">
		<table cellspacing=0 cellpadding=5 class="adminEditTable" width="100%">
			<tr valign="top">
				<td width="200"><b>(*) Username:</b></td>
				<td><input type="text" name="username" value="#form.username#" size="50"></td>
			</tr>
			<tr valign="top">
				<td width="200"><b>(*) Admin:</b></td>
				<td>
				<input type="radio" name="isadmin" value="1" <cfif form.isAdmin>checked</cfif>>Yes<br />
				<input type="radio" name="isadmin" value="0" <cfif not form.isAdmin>checked</cfif>>No<br />
				
				</td>
			</tr>
			<tr valign="top">
				<td width="200"><b>New Password:</b></td>
				<td><input type="password" name="password" value="" size="50"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="submit" name="save" value="Save">
				<input type="submit" name="cancel" value="Cancel"></td>
			</tr>
		</table>
		</form>
		</p>
		</cfoutput>
		
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