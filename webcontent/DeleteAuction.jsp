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

	String userid = (String)session.getAttribute("user");	
	Boolean isstaff = (Boolean)session.getAttribute("user-isstaff");
	if (userid == null || isstaff == null || isstaff.booleanValue() == false) {
		response.sendRedirect("Login.jsp");
	}

	try {

			//Get the database connection
			Database db = new Database();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Get parameters
			String aid_str = request.getParameter("aid").toString();
			int aid = Integer.parseInt(aid_str);

			//Make an insert statement for the Users table:
			String update = "DELETE FROM Sellsproduct a WHERE a.aid = ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);
	
			//Add parameters of the query.
			ps.setInt(1, aid);
			ps.executeUpdate();
			
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			%> Success!<br>
			<a href="index.jsp">Return</a>
			 <%
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("deletion failed");
		}
	%>
</body>
</html>