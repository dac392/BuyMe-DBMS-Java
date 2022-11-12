<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
   <head>
      <title>BuyMe | Log In</title>
   </head>
   <body>
		<%
		    if ((session.getAttribute("user") == null)) {
		%>
		You are not logged in<br/>
		<a href="Login.jsp">Please Login</a>
		<%} else {
		%>
		Welcome <%=session.getAttribute("user")%>  <!-- //this will display the username that is stored in the session. -->
		<a href='Logout.jsp'>Log out</a>
		<%
		    }
		%>
   </body>
</html>

