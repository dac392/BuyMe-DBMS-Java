<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
   <head>
      <title>BuyMe | Log In</title>
      <link rel="stylesheet" href="css/global.css">
   </head>
   <body>
   		<%@ include file="Components/Header.jsp" %>
   		
			<%
			    if ((session.getAttribute("user") == null)) {
			%>
				<div class="status-container">
					<div class="information">
						<h1>Oh No!</h1>
						<p>Your account could not be verified.</p>
						<div class="options">
							<a class="button" href="Login.jsp">Login</a>
							<a class="button" href="Signup.jsp">Signup</a>
						</div>
					</div>
				</div>
			<% } else { %>
				<div class="status-container">
					<div class="information">
						<h1>Welcome!</h1>
						<p>You are logged in as <strong><%=session.getAttribute("user")%></strong></p>
						<div class="options">
							<a class="button" href='Logout.jsp'>Log out</a>
							<a class="button" href="index.jsp">Home</a>
						</div>
						
					</div>
				</div>
			<%
			    }
			%>
   		

   </body>
</html>

