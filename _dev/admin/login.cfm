<cfsetting enablecfoutputonly=true>
<!---
	Name         : login.cfm
	Author       : Daniel Chan
	Created      : February 17, 2013
	Last Updated : 
	History      : 
	Purpose		 : 
--->
<cfimport taglib="../tags/" prefix="tags">

<tags:layout templatename="default" title="iSurvey Admin Login">
	
<cfoutput>

  <div class="content">
    	<form action="#cgi.script_name#?#cgi.query_string#" method="post" name="login">	
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>Username:</td>
                <td><input type="text" name="username" value=""></td>
              </tr>
              <tr>
                <td>Password:</td>
                <td>
                	<input type="password" name="password" value="">
                </td>
              </tr>
              <tr>
              	<td>&nbsp;</td>
              	<td><a href="##">Password Assistance</a>
                	<br /><br />
                </td>
              </tr>
              <tr>
              	<td>&nbsp;</td>
                <td><input type="submit" name="logon" value="Login"></td>
              </tr>
            </table>
        </form>
  </div>
		  
<script>
document.login.username.focus();
</script>
</cfoutput>

</tags:layout>

<cfsetting enablecfoutputonly=false>