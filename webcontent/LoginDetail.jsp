<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Login Details</title>
</head>
<body>

	<%
    	String userid = request.getParameter("username");   
    	String pwd = request.getParameter("password");
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "");
	    Statement st = con.createStatement();
	    
	    ResultSet rs = st.executeQuery("select * from enduser where username='" + userid + "' and password='" + pwd + "'");
	    if (rs.next()) {
	        session.setAttribute("user", userid);
	        out.println("welcome " + userid);
	        out.println("<a href='Logout.jsp'>Log out</a>");
 	        response.sendRedirect("Success.jsp");
	    } else {
	        out.println("Invalid password <a href='Login.jsp'>try again</a>");
	    }
	%>

</body>
</html>