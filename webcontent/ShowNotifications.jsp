<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<% 

	String userid = (String)session.getAttribute("user");	
	if (userid == null) {
		response.sendRedirect("Login.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Notifications</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<h1>Notifications</h1>
	<% 
	try {
		//Get the database connection
		Database db = new Database();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();

		System.out.println(userid);
		String str = "SELECT * FROM Notifications n WHERE n.username = \'"+userid+"\'";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
	%>
		
	<%while(result.next()){//Yeah, this needs CSS%>
		<%= result.getString("description") %><br>
		<%= result.getString("posttime") %><br>
		<br>
		
	<%
	}
	} catch (Exception e) {
		out.print(e);
	}
	%>

</body>
</html>