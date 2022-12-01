<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

	String userid = (String)session.getAttribute("user");	
	if (userid != null) {
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
   <head>
      <title>BuyMe | Log In</title>
      <link rel="stylesheet" href="css/global.css">
      <link rel="stylesheet" href="css/form-styles.css">
   </head>
   <body>
   <%@ include file="Components/Header.jsp" %>
   
     <form action="LoginDetail.jsp" method="POST">
     	<fieldset>
	     	<legend><h1>Log In</h1></legend>
	     	<label for="username">User Name:</label>
	       	<input type="text" id="username" name="username"/> <br/>
	       	
	       	<label for="password">Password:</label>
	       	<input type="password" id="password" name="password"/> <br/>
	       	
	       	<input type="submit" value="Submit"/>
     	</fieldset>

     </form>
   </body>
</html>