<cfsetting enablecfoutputonly=true>
<!---
	Name         : index.cfm
	Author       : Daniel Chan
	Created      : August 01, 2012
	Last Updated : 
	History      : 
	Purpose		 : 
--->
<cfimport taglib="../tags/" prefix="tags">

<tags:layout templatename="admin" title="Welcome to the Soundings Administrator">

<cfoutput>
	<div class="content">
		<p>
		Welcome to iSurvey #application.settings.version#. This administrator allows you to edit all aspects of ORC online surveys. Please select an option from the top menu to begin.
		</p>
		
		<p>
		Please send any bug reports to <a href="mailto:Daniel.Chan@ORCInternational.com.hk">Daniel Chan</a>.
		</p>
	</div>
</cfoutput>

</tags:layout>

<cfsetting enablecfoutputonly=false>