<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Signup</title>
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/form-styles.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<form method="post" action="RegisterUser.jsp">
		<fieldset>
			<legend><h1>Sign Up</h1></legend>
			
			<label for="name">Name:</label>
			<input type="text" id="name" name="name" /><br/>
			
			<label for="username">User name:</label>
			<input type="text" id="username" name="username" /><br/>
			
			<label for="email">Email:</label>
			<input type="email" id="email" name="email" /><br/>
			
			<label for="password">Password:</label>
			<input type="password" id="password" name="password" /><br/>
			
			<input type="submit" value="Submit" />
		</fieldset>
	</form>
</body>
</html>