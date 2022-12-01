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
			String userName = request.getParameter("username");
			boolean userIsstaff = Boolean.valueOf((request.getParameter("isstaff")));

			//Make an insert statement for the Users table:
			String update = "UPDATE Enduser e SET e.isstaff = ? WHERE e.username = ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);
	
			//Add parameters of the query.
			ps.setBoolean(1, userIsstaff);
			ps.setString(2, userName);
			ps.executeUpdate();
			
			//Send Notification
			if (userIsstaff){
				Utility.sendNotif(userName, "Permissions Updated: You are now a Customer Representative.", con);
			} else {
				Utility.sendNotif(userName, "Permissions Updated: You are now a Regular User.", con);
			}
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			%> Success!<br>
			<a href="AdminPage.jsp">Return</a>
			 <%
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("update failed");
		}
	%>
</body>
</html>