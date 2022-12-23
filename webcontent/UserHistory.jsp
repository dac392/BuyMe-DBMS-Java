<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<% 	String user = (String)request.getParameter("user");	
	if (user == null) {
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
   <head>
      <title>BuyMe | <%= user%>'s History</title>
      <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/thumbnails.css">
   </head>
   <body>
   <%@ include file="Components/Header.jsp" %>
   
   	<h1><%= user%>'s History</h1>	
  	<% 
		    //Get the database connection
			Database db = new Database();	
			Connection con = db.getConnection();		
		
			//Create a SQL statement
			Statement stmt = con.createStatement();
		
			String str = "SELECT * FROM Sellsproduct a WHERE a.username = \""+user
					+"\" OR EXISTS(SELECT * FROM Bids b WHERE b.aid = a.aid AND b.username = \""+user
					+"\") ORDER BY a.posttime DESC";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
		<div class="content-container">
		
		<%while(result.next()){//Yeah, this needs CSS%>
			<%
				String title = result.getString("auctionname");
			%>
			<div class="card" onclick="location.href='ProductListing.jsp?aid='+<%= result.getInt("aid")%>+'';">
			  <img src=<%= result.getString("link")+"image1.png"%> alt="Product" style="width:100%">
			  <div class="container">
			  	<h4 id="title"><%= title.toUpperCase()%></h4>
			    <h4><b>$<%= result.getString("amount")%></b></h4>
			    <p><%= result.getString("deadline")%></p>
			  </div>
			</div> 
		<%} %>
		</div>
		<%con.close(); %>
   </body>
</html>