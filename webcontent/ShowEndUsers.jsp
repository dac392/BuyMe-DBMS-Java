<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<% 
	try {
		//Get the database connection
		Database db = new Database();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String str = "SELECT * FROM Enduser";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
	%>
	<table>
		<tr>
			<td>username</td>
			<td>name</td>
			<td>email</td>
			<td>password</td>
			<td>rank</td>
		</tr>
		
		<%while(result.next()){%>
			<tr>
				<td><%= result.getString("username") %></td>
				<td><%= result.getString("name") %></td>
				<td><%= result.getString("email") %></td>
				<td><%= result.getString("password") %></td>
				<td>
				<% 
				String rank;
				if (result.getBoolean("isadministrative")){
					rank = "Admin";
				} else if (result.getBoolean("isstaff")){
					rank = "Customer Rep";
				} else {
					rank = "Regular User";
				}
				%>
				<%= rank %></td>
			</tr>
			
		<%
		}
		} catch (Exception e) {
			out.print(e);
		}
		%>
	</table>

</body>
</html>