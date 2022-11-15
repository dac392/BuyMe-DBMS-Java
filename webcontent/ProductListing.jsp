<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="com.buyme.*"%>
<%@ page import ="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>BuyMe | Product Listing</title>
	<link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/listing.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	
	<%
		String person = session.getAttribute("user").toString();
		Database db = new Database();	
		Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    System.out.println(person);
	    ResultSet rs = st.executeQuery("SELECT * FROM Sellsproduct s WHERE s.aid=(SELECT max(s.aid) FROM Sellsproduct s where username ='" +person+"');");
	%>
		
		<% if(rs.next()){%>
			<div class="listing-container">
				<fieldset>
					<legend><%= rs.getString("specifications")+" "+rs.getString("subcategory")+" #"+rs.getString("aid")%></legend>
					<p id="src1" class="ignore source"><%= rs.getString("link")%>image1.png</p>
					<p id="src2" class="ignore source"><%= rs.getString("link")%>image3.png</p>
					<p id="src3" class="ignore source"><%= rs.getString("link")%>image2.png</p>
					<div class="slider">
						<div class="slide">
							<input type="radio" class="ignore" name="slide" id="img1" checked>
							<input type="radio" class="ignore" name="slide" id="img2">
							<input type="radio" class="ignore" name="slide" id="img3">
							<img src=<%= rs.getString("link")+"image1.png"%> id="frame"alt="image01">
						</div>
						<div class="navigation-manual">
				            <label for="img1" class="manual"></label>
				            <label for="img2" class="manual"></label>
				            <label for="img3" class="manual"></label>
				        </div>
					</div>
					
					<div class="info">
						<p><strong>$<%= Double.parseDouble(rs.getString("amount")) %></strong></p>
						<p>Category: <%= rs.getString("category") %></p>
						<p>Seller: <%= rs.getString("username") %></p>
						<br>
						<hr>
						<br>
						<p>Closing date: <%= rs.getString("deadline") %></p>
					</div>
				</fieldset>
			</div>
		<% } %>
		<script type="text/javascript" src="Scripts/slider.js"></script>
</body>
</html>