<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Bid</title>
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/form-styles.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<%
		String aid = request.getParameter("aid");
	%>
	<form method="post" action=<%= "ValidateBid.jsp?aid="+aid%> >
		<fieldset>
			<legend><h1>Bid</h1></legend>
			<label for="type">Bid Type:</label><br>
			<select id="type" name="type">
			  <option hidden>Select category</option>
			  <option value="static">Bid once</option>
			  <option value="auto">Bid automatically</option>
			</select> 
			
			<label for="floor">Initial Bid:</label>
			<input type="text" id="floor" name="floor">
			
			<div id="ceil">
				<label for="ceiling">Maximum Bid:</label>
				<input type="text" id="ceiling" name="ceiling">
			</div>
			
			<input type="submit" id="submit" value="Submit">
		</fieldset>
	</form>
	<script type="text/javascript" src="Scripts/bid-validation.js"></script>
</body>
</html>