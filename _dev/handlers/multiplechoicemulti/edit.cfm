<cfsetting enablecfoutputonly=true>
<!---
	Name         : handlers/multiplechoicemulti/edit.cfm
	Author       : Raymond Camden 
	Created      : September 17, 2004
	Last Updated : September 17, 2004
	History      : 
	Purpose		 : Supports Multiple Choice
--->

<!--- Multichoice multi is just a modified version --->
<cfmodule template="../multiplechoice/edit.cfm" attributeCollection="#attributes#" multi="true" />

<cfsetting enablecfoutputonly=false>

<cfexit method="exittag">