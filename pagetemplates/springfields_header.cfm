<cfsetting enablecfoutputonly=true>
<!---
	Name         : default_header.cfm
	Author       : Daniel Chan
	Created      : February 17, 2013
	Last Updated : 
	History      : 
	Purpose		 : 
--->

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>#attributes.title#</title>
	<link href="/isurvey/css/main.css" type="text/css" rel="stylesheet"/>
</head>

<body>
	<div class="outerwrapper">
    	<div class="innerwrapper">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="shadow-left">&nbsp;</td>
				<td class="center">
				  <div id="logo"><img src="/isurvey/image/logo.jpg" width="312" height="36" alt="logo" /> </div>
					  <!---<div class="title">#attributes.title#</div>--->
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
					      <tr>
					        <td><img src="/isurvey/image/featured-inside-02.jpg" width="960" height="94" alt="banner" /></td>
					    </tr>
					  </table>

</cfoutput>

<cfsetting enablecfoutputonly=true>

