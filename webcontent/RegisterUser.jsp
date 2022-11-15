<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

			//Get the database connection
			Database db = new Database();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Get parameters from the HTML form at the index.jsp
			String userName = request.getParameter("name");
			String userUsername = request.getParameter("username");
			String userEmail = request.getParameter("email");
			String userPassword = request.getParameter("password");

			//Make an insert statement for the Users table:
			String insert = "INSERT INTO Enduser(name, username, email, password, isstaff, isadministrative)"+ "VALUES (?, ?, ?, ?, null, null)";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, userName);
			ps.setString(2, userUsername);
			ps.setString(3, userEmail);
			ps.setString(4, userPassword);
			ps.executeUpdate();
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			out.print("insert succeeded");
			
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed");
		}
	%>
</body>
</html>