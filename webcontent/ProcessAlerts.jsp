<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
   <head>
      <title>BuyMe | Alerts </title>
      <link rel="stylesheet" href="css/global.css">
   </head>
   <body>
   		<%@ include file="Components/Header.jsp" %>
   		
		<%
		String userid = (String)session.getAttribute("user");	
		if (userid == null) {
			response.sendRedirect("index.jsp");
		} else { 
			Database db = new Database();	
			Connection con = db.getConnection();
			
			String type = request.getParameter("type");

			
			if (type.equals("make-alert")){
				String insert = "INSERT INTO Alerts(username, searchquery, prevcheck)"+ "VALUES (?, ?, ?)";
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);
		
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, userid);
				ps.setString(2, request.getParameter("new-alert"));
				
				Calendar calendar = Calendar.getInstance();
			    Timestamp timeStampObj = new java.sql.Timestamp(calendar.getTime().getTime());
			    ps.setTimestamp(3, timeStampObj);
			    
				ps.executeUpdate();
				
				out.println("Success");
				
				con.close();
				
			} else if (type.equals("delete-alert")){
				int alid = Integer.parseInt(request.getParameter("alid"));
				
				Statement stmt = con.createStatement();
				
				String update = "DELETE FROM Alerts a WHERE a.alid = ?";
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(update);
		
				//Add parameters of the query.
				ps.setInt(1, alid);
				ps.executeUpdate();
			
				con.close();
				
				out.println("Success");
			} else {
				response.sendRedirect("index.jsp");
			}
		} 
		%>
   		

   </body>
</html>

