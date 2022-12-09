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
      <title>BuyMe | Customer Support</title>
      <link rel="stylesheet" href="css/global.css">
      <link rel="stylesheet" href="css/form-styles.css">
   </head>
   <body>
   <%@ include file="Components/Header.jsp" %>
   <% 
  		Object header_isstaff = session.getAttribute("user-isstaff");
  		if (header_isstaff != null && ((Boolean)header_isstaff).booleanValue()){ 
  			
		    //Get the database connection
			Database db = new Database();	
			Connection con = db.getConnection();		
		
			//Create a SQL statement
			Statement stmt = con.createStatement();
		
			String str = "SELECT * FROM SupportRequests n ORDER BY -n.posttime";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
		
	<%while(result.next()){//Yeah, this needs CSS%>
		<%= result.getString("username") %><br>
		<%= result.getString("description") %><br>
		<form action="SubmitSupportRequest.jsp" method="POST" id=<%= "\"supportform"+result.getInt("srid")+"\"" %>>
	       	<textarea name=<%= "\"supportresponse"+result.getInt("srid")+"\"" %> form=<%= "\"supportform"+result.getInt("srid")+"\"" %> ></textarea>
	       	<input type="hidden" id=<%= "\"hidden"+result.getInt("srid")+"\"" %> name="type" value="response"/>
	       	<input type="hidden" name="srid" value=<%= "\""+result.getInt("srid")+"\"" %>/>
	       	<input type="submit" value="Submit"/>
	
	     </form>
		<br>
	<% } %>
     
    <% } else { %>
	    <form action="SubmitSupportRequest.jsp" method="POST" id="supportform">
	     	<fieldset>
		     	<legend><h1>Ask Support</h1></legend>
		       	<textarea name="supportrequest" form="supportform" ></textarea>
		       	<input type="hidden" id="hidden" name="type" value="ticket"/>
		       	<input type="submit" value="Submit"/>
	     	</fieldset>
	
	     </form>
    <% } %>
   </body>
</html>