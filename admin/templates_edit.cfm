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
			<cflocation url="templates.cfm" addToken="false">
		</cfif>
		
		<!--- get template if not new --->
		<cfif url.id neq "0">
			<cfif not session.user.isAdmin>
				<cfset t = application.template.getTemplate(url.id,session.user.id)>
			<cfelse>
				<cfset t = application.template.getTemplate(url.id)>
			</cfif>
			<cfparam name="form.name" default="#t.name#">
			<cfparam name="form.header" default="#t.header#">
			<cfparam name="form.footer" default="#t.footer#">
		<cfelse>
			<cfparam name="form.name" default="">
			<cfparam name="form.header" default="">
			<cfparam name="form.footer" default="">
		</cfif>
		<cfif isDefined("form.save")>
			<cfset errors = "">
			<cfif not len(form.name)>
				<cfset errors = errors & "You must specify a name.<br>">
			</cfif>
			<!--- I don't care about header or footer, they can leave blank if they want... --->
			
			<cfif not len(errors)>
		
				<cfif url.id neq 0>
					<cfset application.template.updateTemplate(url.id, form.name, form.header, form.footer, t.useridfk)>
				<cfelse>
					<cfset application.template.addTemplate(form.name, form.header, form.footer, session.user.id)>
				</cfif>
						
				<cfset msg = "Template, #form.name#, has been updated.">
				<cflocation url="templates.cfm?msg=#urlEncodedFormat(msg)#">
			</cfif>
		</cfif>
		
		<legend>SURVEY OPTIONS / Templates / Edit</legend>
		
		<div class="row-fluid">
		
		<cfoutput>
		<p>
		Please use the form below to enter details about the template. All required fields are marked (*). Templates
		allow you to apply your own header and footer to a survey. Please see the documentation for CSS items used by
		questions.
		</p>
		
		<p>
		<cfif isDefined("errors")><ul><b>#errors#</b></ul></cfif>
		<form action="#cgi.script_name#?#cgi.query_string#" method="post">
		<table width="100%" cellspacing=0 cellpadding=5 class="adminEditTable">
			<tr valign="top">
				<td align="right"><b>(*) Name:</b></td>
				<td><input class="span6" type="text" name="name" value="#form.name#" size="50"></td>
			</tr>
			<tr valign="top">
				<td align="right"><b>Header:</b></td>
				<td><textarea class="span6" name="header" rows=6 cols=35 wrap="soft">#form.header#</textarea></td>
			</tr>
			<tr valign="top">
				<td align="right"><b>Footer:</b></td>
				<td><textarea class="span6" name="footer" rows=6 cols=35 wrap="soft">#form.footer#</textarea></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="submit" name="save" value="Save"> <input type="submit" name="cancel" value="Cancel"></td>
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