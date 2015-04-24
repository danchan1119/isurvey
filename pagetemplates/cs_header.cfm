<cfsetting enablecfoutputonly=true>
<!---
	Name         : cs_header.cfm
	Author       : Daniel Chan
	Created      : February 20, 2013
	Last Updated : 
	History      : 
	Purpose		 : 
--->

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
	<title>#attributes.title#</title>
	<link href="./css/main.css" type="text/css" rel="stylesheet"/>
	<link href="./css/survey.css" type="text/css" rel="stylesheet"/>
	
	<script src="./SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
	<link href="./SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
	
	<script src="./SpryAssets/SpryValidationTextarea.js" type="text/javascript"></script>
	<link href="./SpryAssets/SpryValidationTextarea.css" rel="stylesheet" type="text/css" />
	
	<script src="./SpryAssets/SpryTooltip.js" type="text/javascript"></script>
	<link href="./SpryAssets/SpryTooltip.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<div class="outerwrapper">
    	<div class="innerwrapper">
        	<table width="100%" height="1000px" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="shadow-left">&nbsp;</td>
				<td class="center">
				  <div id="logo"><img src="./image/cs/logo_cs.png" width="206" height="70" alt="logo" /> </div>
					  <div class="title">#attributes.title#</div>
					  <!---<table width="100%" border="0" cellspacing="0" cellpadding="0">
					      <tr>
					        <td><img src="./image/featured-inside-02.jpg" width="960" height="94" alt="banner" /></td>
					    </tr>
					  </table>--->

</cfoutput>

<cfsetting enablecfoutputonly=true>

