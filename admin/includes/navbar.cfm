<header class="navbar navbar-fixed-top" id="main-navbar">
		<div class="navbar-inner">
			<div class="container">
				<a class="logo" href="./index.cfm"><img alt="logo" src="../assets/images/orc-logo.png"></a>

				<a class="btn nav-button collapsed" data-toggle="collapse" data-target=".nav-collapse">
					<span class="icon-reorder"></span>
				</a>

				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="<cfif findNoCase('/index',cgi.script_name)>active</cfif>"><a href="./index.cfm">Home</a></li>
						<li class="dropdown <cfif findNoCase('/ticket',cgi.script_name)>active</cfif>">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Survey Options <i class=" icon-caret-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="./surveys.cfm">Surveys</a></li>
								<li><a href="./questions.cfm">Questions</a></li>
								<li><a href="./questiontypes.cfm">Question Types</a></li>
								<li><a href="./templates.cfm">Templates</a></li>
							</ul>
						</li>
                        <!---<li class="<cfif findNoCase('/logs',cgi.script_name)>active</cfif>"><a href="#">Logs<span class="badge badge-important"><span class="icon-lock"></span></span></a></li>
						<li class="<cfif findNoCase('/faqs',cgi.script_name)>active</cfif>"><a href="#">FAQs<span class="badge badge-important"><span class="icon-lock"></span></span></a></li>
						<li class="divider-vertical"></li>--->
					</ul>
					<!---<form class="navbar-search pull-left" action="" _lpchecked="1">
						<input type="text" class="search-query" placeholder="Search" style="width: 120px">
					</form>--->
					<ul class="nav pull-right">
						<!---<li>
							<ul class="messages">
								<li>
									<a href="#"><i class="icon-warning-sign"></i> 2<span class=" responsive-text"> alerts</span></a>
								</li>
								<li>
									<a href="#"><i class="icon-envelope"></i> 25<span class=" responsive-text"> new messages</span></a>
								</li>
							</ul>
						</li>
						<li class="separator"></li>--->
						<li class="dropdown">
							<a href="#" class="dropdown-toggle usermenu" data-toggle="dropdown">
								<cfoutput><img alt="Avatar" src="../assets/images/avatar.png"></cfoutput>
								<span>&nbsp;&nbsp;<cfoutput>#session.user.username#</cfoutput></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="./profile.cfm">Profile</a></li>
								<CFIF session.user.isadmin eq 1>
									<li><a href="./users.cfm">Users</a></li>
								</CFIF>
								<!---<li>
									<a href="#">Settings</a>
								</li>--->
								<li class="divider"></li>
								<li>
									<a href="./index.cfm?logout">Sign Out</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</header>