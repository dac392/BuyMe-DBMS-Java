<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="com.buyme.*"%>
<%@ page import ="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Login Details</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<%
    	String userid = request.getParameter("username");   
    	String pwd = request.getParameter("password");
    	Database db = new Database();	
		Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    
	    ResultSet rs = st.executeQuery("select * from enduser where username='" + userid + "' and password='" + pwd + "'");
	    
	    if (rs.next()) {
	        session.setAttribute("user", userid);
	        session.setAttribute("user-name", rs.getString("name"));
	        session.setAttribute("user-isstaff", rs.getBoolean("isstaff"));
	        session.setAttribute("user-isadmin", rs.getBoolean("isadministrative"));
	        out.println("welcome " + userid);
	        out.println("<a href='Logout.jsp'>Log out</a>");
 	        response.sendRedirect("Success.jsp");
	    } else {
	        /* out.println("Invalid password <a href='Login.jsp'>try again</a>"); */
	    	response.sendRedirect("Success.jsp");
	    }
	%>

</body>
</html>