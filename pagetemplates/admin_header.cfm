<cfsetting enablecfoutputonly=false>
<!---
	Name         : admin_header.cfm
	Author       : Raymond Camden 
	Created      : September 6, 2004
	Last Updated : April 10, 2006
	History      : work w/o mapping (rkc 3/10/06)
				 : minor html mod (rkc 4/10/06)
	Purpose		 : 
--->

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="../css/main.css" type="text/css" rel="stylesheet"/>
<link href="../SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<script src="../includes/jquery-1.5.2.min.js" type="text/javascript"></script>
<script src="../includes/jquery.json-2.2.min.js" type="text/javascript"></script>
<script src="../SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});
</script>
<cfif attributes.loadspry>
	<script src="../includes/SpryData.js"></script>
	<script src="../includes/xpath.js"></script>		
</cfif>
</head>

<body>
<div class="outerwrapper">
    	<div class="innerwrapper">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="shadow-left">&nbsp;</td>
                
                <!-- content -->
                <td class="center">
               	  <div id="logo"><img src="../image/logo.jpg" width="312" height="36" alt="logo" /> </div>
                  <div class="title">iSurvey Administration Panel</div>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><img src="../image/featured-inside-02.jpg" width="960" height="94" alt="banner" /></td>
                      </tr>
                      <tr>
                      	<td>
                       	  <ul id="MenuBar1" class="MenuBarHorizontal">
                              <li><a class="MenuBarItemSubmenu" href="##">Survey Options</a>
                                <ul>
                                  <li><a href="./surveys.cfm">Surveys</a></li>
                                  <li><a href="./questions.cfm">Questions</a></li>
                                  <li><a href="./questiontypes.cfm">Question Types</a></li>
                                  <li><a href="./templates.cfm">Templates</a></li>
                                </ul>
                              </li>
                              <li><a href="##" class="MenuBarItemSubmenu">Security Options</a>
                                <ul>
                                  <li><a href="./password.cfm">Set Password</a></li>
                                  <li><a href="users.cfm">Users</a></li>
                                </ul>
                            </li>
                              <li><a class="MenuBarItemSubmenu" href="##">Stats</a>
                                <ul>
                                  <li><a href="./stats.cfm">Reporting</a></li>
                                </ul>
                              </li>
                              <li><a href="./index.cfm?logout=1">Links</a></li>
                            </ul>
                        </td>
                      </tr>
                  </table>
</cfoutput>

<cfsetting enablecfoutputonly=true>

