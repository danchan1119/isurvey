<cfcomponent output="false">

	<cfset this.name = "iSurvey">
	<cfset this.applicationTimeout = createTimeSpan(30,0,0,0)>
	<cfset this.clientManagement = false>
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(10,0,0,0)>
	<!---<cfset this.datasource = "soundings">--->
	
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfset application.started = now()>
		
		<cfset application.soundings = createObject("component","cfcs.soundings")>
		<cfset application.settings = application.soundings.getSettings()>
		<cfset application.survey = createObject("component","cfcs.survey").init(application.settings)>
		<cfset application.question = createObject("component","cfcs.question").init(application.settings)>
		<cfset application.questionType = createObject("component","cfcs.questiontype").init(application.settings)>
		<cfset application.template = createObject("component","cfcs.template").init(application.settings)>
		<cfset application.user = createObject("component","cfcs.user").init(application.settings)>
		<cfset application.utils = createObject("component","cfcs.utils")>
		<cfset application.toxml = createObject("component","cfcs.toxml")>
		
		<cfreturn true>
	</cffunction>

	<!--- Run when application stops --->
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
		
		<cfset var ended = dateDiff("n",arguments.applicationScope.ended,now())>
		<cflog file="#this.name#" text="App ended after #ended# minutes." >
		
	</cffunction>

	<!--- Fired when user requests a CFM that doesn't exist. --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string">
		<!--- Use a try block to catch errors. --->
	    <cftry>
	        <!--- Log all errors. --->
	        <cflog type="error" text="Missing template: #Arguments.targetPage#">
	        <!--- Redirect to error page. --->
	        <cflocation url="./error/404.cfm?page=#urlEncodedFormat(arguments.targetpage)#" addToken="false">
	        <cfreturn true />
	        <!--- If an error occurs, return false and the default error handler will run. --->
	        <cfcatch>
	            <cfreturn false />
	        </cfcatch>
	    </cftry>
	</cffunction>	
	
	<!--- Run before the request is processed --->
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		<!--- include UDFs --->
		<cfinclude template="includes/udf.cfm">
		
		<!--- handle security in the admin folder --->
		<cfif findNoCase("/admin",cgi.script_name)>
			
			<cfif isDefined("url.logout")>
				<cfset structDelete(session, "loggedin")>
			</cfif>
			
			<cfif not structKeyExists(session, "loggedin")>
			
				<!--- are we trying to logon? --->
				<cfif isDefined("form.username") and isDefined("form.password")>
					<cfif application.user.authenticate(form.username,form.password)>
						<cfset session.user = application.user.getUser(form.username)>
						<cfset session.loggedin = true>
						
						<cfset structDelete(session, "loginmsg")>
					<cfelse>
						<cfset session.loginmsg="The email or password you entered is incorrect."/>
					</cfif>
				</cfif>
				
			</cfif>
		
			<cfif not structKeyExists(session, "loggedin")>
				<cfinclude template="admin/login.cfm">
				<cfabort>
			</cfif>
			
		</cfif>

		<cfreturn true>
	</cffunction>

	<!--- Runs before request as well, after onRequestStart --->
	<!--- 
	WARNING!!!!! THE USE OF THIS METHOD WILL BREAK FLASH REMOTING, WEB SERVICES, AND AJAX CALLS. 
	DO NOT USE THIS METHOD UNLESS YOU KNOW THIS AND KNOW HOW TO WORK AROUND IT!
	EXAMPLE: http://www.coldfusionjedi.com/index.cfm?mode=entry&entry=ED9D4058-E661-02E9-E70A41706CD89724
	--->
	<cffunction name="onRequest" returnType="void">
		<cfargument name="thePage" type="string" required="true">
		<cfinclude template="#arguments.thePage#">
	</cffunction>

	<!--- Runs at end of request --->
	<cffunction name="onRequestEnd" returnType="void" output="false">
		<cfargument name="thePage" type="string" required="true">
	</cffunction>

	<!--- Runs on error --->
	<!---<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cflocation url="./error/404.cfm" addToken="false">
		<!---<cfdump var="#arguments#">---><cfabort>
	</cffunction>--->

	<!--- Runs when your session starts --->
	<cffunction name="onSessionStart" returnType="void" output="false">
		<cfset session.created = now()>
		<cfset session.surveys = structNew()>
	</cffunction>

	<!--- Runs when session ends --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
		
		<cfset var duration = dateDiff("s",arguments.sessionScope.created,now())>
		<cflog file="#this.name#" text="Session lasted for #duration# seconds." >
	</cffunction>
</cfcomponent>