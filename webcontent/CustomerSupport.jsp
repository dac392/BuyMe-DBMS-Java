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
   
   	<h1>Customer Support</h1>
   <% 
  		Object header_isstaff = session.getAttribute("user-isstaff");
  		if (header_isstaff != null && ((Boolean)header_isstaff).booleanValue()){ 
  	%>		
		<h2>Edit User Info</h2>
			<script>
		    	function updateForm(value){
		    		if (value !== "delete"){
		    			document.getElementById("u-newval").style.display = 'block';
		    		} else {
		    			document.getElementById("u-newval").style.display = 'none';
		    		}
		    		
		    	}
		    </script>
			<form action="SubmitSupportRequest.jsp" method="POST" id="userinfoform">
				<label for="old-username">User to Edit</label>
     			<input type="text" id="old-username" name="old-username"/>
     			
     			<br/>
     			<label for="value">Value to Update</label><br>
     			<select id="value" name="value" onchange="updateForm(this.value)">
		           <option value="username">User Name</option>
		           <option value="name">Name</option> 
		           <option value="email">Email</option> 
		           <option value="password">Password</option> 
		           <option value="delete">Delete Account</option>
		        </select> <br/>
		        <div id="u-newval" style="display:block">
     			<label for="new-value">New value</label>
     			<input type="text" id="new-value" name="new-value"/> <br/>
     			</div>
		
				
		       	<input type="hidden" id="hidden-u" name="type" value="update-user-info"/>
				<input type="submit" value="Submit"/>
			</form>
		
		<h2>Customer Tickets</h2>
  	<% 
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