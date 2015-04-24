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

<tags:layout templatename="default" title="">
	
<cfoutput>

  <div class="content" style="height:1000px">
  	<p>Administrative permission is required to access this page.</p>
  </div>
</cfoutput>

</tags:layout>

<cfsetting enablecfoutputonly=false>