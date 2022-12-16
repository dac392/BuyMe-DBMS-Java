<%
   if ((session.getAttribute("user") == null)) {
%>
	<header>
		<h1><a class="header-title" href="index.jsp">BuyMe</a></h1>
	     <nav class="navbar">
	     	<ul class="navbar-nav">
	     		<li class="nav-item"><a class="nav-link" href="Login.jsp">Log in</a></li>
	     		<li class="nav-item active"><a class="nav-link" href="Signup.jsp">Sign up</a></li>
	     		<li class="nav-item active"><a class="nav-link" href="ShowEndUsers.jsp">Debug</a></li>
	     	</ul>
	     </nav>
	</header>
<% } else { %>
	<header>
		<h1><a class="header-title" href="index.jsp">BuyMe</a></h1>
	     <nav class="navbar">
	     	<ul class="navbar-nav">
	     	<% 
	     		Object header_isadmin = session.getAttribute("user-isadmin");
	     		if (header_isadmin != null && ((Boolean)header_isadmin).booleanValue()){ %>
	     		<li class="nav-item active"><a class="nav-link" href="AdminPage.jsp">Admin</a></li>
	     	<% } %>
	     		<li class="nav-item active"><a class="nav-link" href="CustomerSupport.jsp">Customer Support</a></li>
	     		<li class="nav-item active"><a class="nav-link" href="ProductUpload.jsp">Sell Item</a></li>
	     		<li class="nav-item active"><a class="nav-link" href="ManageAlerts.jsp">Alerts</a></li>
	     		<li class="nav-item active"><a class="nav-link" href="ShowNotifications.jsp">Notifications</a></li>
	     		<li class="nav-item active"><a class="nav-link" href="Logout.jsp">Log out</a></li>
	     		<li class="nav-item active"><a class="nav-link" href="ShowEndUsers.jsp">Debug</a></li>
	     		<li class="nav-item"><p><strong><%=session.getAttribute("user-name")%></strong></p></li>
	     	</ul>
	     </nav>
	</header>
<% } %>