<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
   <head>
      <title>BuyMe | Support </title>
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

			
			if (type.equals("ticket")){
				String ticket = request.getParameter("supportrequest");
				
				String insert = "INSERT INTO SupportRequests(username, description, posttime)"+ "VALUES (?, ?, ?)";
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);
		
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, userid);
				ps.setString(2, request.getParameter("supportrequest"));
				
				Calendar calendar = Calendar.getInstance();
			    Timestamp timeStampObj = new java.sql.Timestamp(calendar.getTime().getTime());
			    ps.setTimestamp(3, timeStampObj);
			    
				ps.executeUpdate();
				
				out.println("Success");
				
				con.close();
				
			} else if (type.equals("update-user-info")){
				String username = request.getParameter("old-username");
				String value = request.getParameter("value");
				String new_data = request.getParameter("new-value");
				
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM Enduser e WHERE e.username = \'"+username+"\'";
				
				Object header_isadmin = session.getAttribute("user-isadmin");
	     		if (header_isadmin != null && !((Boolean)header_isadmin).booleanValue()){
					str = str.concat(" and e.isstaff = false");
				}

				System.out.println(str);
				
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (!result.next()){
					con.close();
					
					out.println("Action Denied");
				} else if (value != null && value.equals("delete")){
					String update = "DELETE FROM Enduser e WHERE e.username = ?;";
					
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(update);
			
					//Add parameters of the query.
					ps.setString(1, username);
					ps.executeUpdate();
					
					out.println("Success");
				} else {
				
					String update = "UPDATE Enduser e SET e."+value+" = ? WHERE e.username = ?;";
					
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(update);
			
					//Add parameters of the query.
					ps.setString(1, new_data);
					ps.setString(2, username);
					ps.executeUpdate();
					
					out.println("Success");
				}
				
				con.close();
				
			} else if (type.equals("response")){
				int srid = Integer.parseInt(request.getParameter("srid"));
				String reply = request.getParameter("supportresponse"+srid);
				
				Statement stmt = con.createStatement();
				
				String str = "SELECT * FROM SupportRequests n WHERE srid = "+srid+";";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				result.next();
				String username = result.getString("username");

				String desc = result.getString("description");
				
				String update = "DELETE FROM SupportRequests r WHERE r.srid = ?";
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(update);
		
				//Add parameters of the query.
				ps.setInt(1, srid);
				ps.executeUpdate();
				
				Utility.sendNotif(username, "You asked,<br>"+desc+"<br><br>"+request.getParameter("supportresponse"+srid)+"\n\t -Support", con);
				
				con.close();
				
				out.println("Success");
			} else {
				response.sendRedirect("index.jsp");
			}
		} 
		%>
   		

   </body>
</html>

