<nav id="left-panel">
	<div id="left-panel-content">
		<ul>
			<li class="<cfif findNoCase('/index',cgi.script_name)>active</cfif>">
				<a href="./index.cfm"><span class="icon-home"></span>Home</a>
			</li>
			<li class="<cfif findNoCase('/surveys',cgi.script_name)>active</cfif>">
				<a href="./surveys.cfm"><span class="icon-edit"></span>Surveys</a>
			</li>
			<li class="<cfif findNoCase('/questions',cgi.script_name)>active</cfif>">
				<a href="./questions.cfm"><span class="icon-list-ol"></span>Questions</a>
			</li>
			<li class="<cfif findNoCase('/profile',cgi.script_name)>active</cfif>">
				<a href="./profile.cfm"><span class="icon-user"></span>Profile</a>
			</li>
			<!---<li>
				<a href="#"><span class="icon-list-alt"></span>Logs<span class="icon-lock" style="font-size:20px; color: #cd522c"></span></a>
			</li>
			<li class="lp-dropdown">
				<a href="#" class="lp-dropdown-toggle" id="pages-dropdown"><span class="icon-file-alt"></span>Pages</a>
				<ul class="lp-dropdown-menu simple" data-dropdown-owner="pages-dropdown">
					<li>
						<a tabindex="-1" href="index.html"><i class="icon-signin"></i>&nbsp;&nbsp;Sign In</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-signup.html"><i class="icon-check"></i>&nbsp;&nbsp;Sign Up</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-messages.html"><i class="icon-envelope-alt"></i>&nbsp;&nbsp;Messages</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-stream.html"><i class="icon-leaf"></i>&nbsp;&nbsp;Stream</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-pricing.html"><i class="icon-money"></i>&nbsp;&nbsp;Pricing</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-invoice.html"><i class="icon-pencil"></i>&nbsp;&nbsp;Invoice</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-map.html"><i class="icon-map-marker"></i>&nbsp;&nbsp;Full page map</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-error-404.html"><i class="icon-unlink"></i>&nbsp;&nbsp;Error 404</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-error-500.html"><i class="icon-bug"></i>&nbsp;&nbsp;Error 500</a>
					</li>
					<li>
						<a tabindex="-1" href="pages-blank.html"><i class="icon-bookmark-empty"></i>&nbsp;&nbsp;Blank page</a>
					</li>
				</ul>
			</li>--->
		</ul>
	</div>
	<div class="icon-caret-down"></div>
	<div class="icon-caret-up"></div>
</nav>