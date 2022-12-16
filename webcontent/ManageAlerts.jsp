<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<% 	String userid = (String)session.getAttribute("user");	
	if (userid == null) {
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
   <head>
      <title>BuyMe | Alerts</title>
      <link rel="stylesheet" href="css/global.css">
      <link rel="stylesheet" href="css/form-styles.css">
   </head>
   <body>
   <%@ include file="Components/Header.jsp" %>
   
   	<h1>Alerts</h1>	
		<h2>Make Alert</h2>
			<form action="ProcessAlerts.jsp" method="POST" id="userinfoform">
				<label for="new-alert">Insert Search Query</label>
     			<input type="text" id="new-alert" name="new-alert"/>
		       	<input type="hidden" id="hidden-u" name="type" value="make-alert"/>
				<input type="submit" value="Submit"/>
			</form>
		
		<h2>Current Alerts</h2>
  	<% 
		    //Get the database connection
			Database db = new Database();	
			Connection con = db.getConnection();		
		
			//Create a SQL statement
			Statement stmt = con.createStatement();
		
			String str = "SELECT * FROM Alerts a ORDER BY -a.alid";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
		
	<%while(result.next()){//Yeah, this needs CSS%>
		<%= result.getString("searchquery") %><br>
		<form action="ProcessAlerts.jsp" method="POST" id=<%= "\"supportform"+result.getInt("alid")+"\"" %>>
	       	<input type="hidden" id=<%= "\"hidden"+result.getInt("alid")+"\"" %> name="type" value="delete-alert"/>
	       	<input type="hidden" name="alid" value=<%= "\""+result.getInt("alid")+"\"" %>/>
	       	<input type="submit" value="Delete"/>
	
	     </form>
		<br>
	<%} %>
   </body>
</html>