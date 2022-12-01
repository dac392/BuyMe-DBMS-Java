<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<% 

	String userid = (String)session.getAttribute("user");	
	boolean isadmin = (Boolean)session.getAttribute("user-isadmin");
	if (userid == null || isadmin == false) {
		response.sendRedirect("Login.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Admin</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<h1>Administrator Page</h1>
	<h2>Set User Rank</h2>
	<form method="post" action="EditUserPermissions.jsp">
			<label for="username">Target Username:</label>
			<input type="text" id="username" name="username" /><br/>
			
			<label for="isstaff">New rank:</label>
			<select id="isstaff" name="isstaff" >
				<option value="true">Customer Representative</option>
				<option value="false">Regular User</option>
			</select><br/>
			
			<input type="submit" value="Submit" />
	</form>

</body>
</html>