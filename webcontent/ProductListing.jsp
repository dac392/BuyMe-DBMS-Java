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
		if (request.getParameter("aid") == null){
			response.sendRedirect("index.jsp");
		}
	
		String aid = request.getParameter("aid").toString();
		Database db = new Database();	
		Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM Sellsproduct s WHERE s.aid="+aid+";");
	%>
		
		<% if(rs.next()){
			String username = rs.getString("username");
			String auctionname = rs.getString("auctionname");
			String link = rs.getString("link");
			String amount = rs.getString("amount");
			String category = rs.getString("category");
			String deadline = rs.getString("deadline");
			String color = rs.getString("color");
			
			String subcategory = "Object";
			String size = "N/A";
			ResultSet subset;
			
			String similarSearch = "";
			
			
			switch (category){
			case "tops":
				subset = st.executeQuery("SELECT * FROM Tops t WHERE t.aid="+aid+";");
				subset.next();
				subcategory = subset.getString("subcategory");
				int sizenum = subset.getInt("size");
				size = Utility.numToTopSize(sizenum);
				
				similarSearch += subcategory+" ";
				if (sizenum < 2)
					similarSearch += "size<="+Utility.numToTopSize(sizenum+1);
				if (sizenum > -2)
					similarSearch += 
					" size>="+Utility.numToTopSize(sizenum-1);
					
				break;
			case "bottoms":
				subset = st.executeQuery("SELECT * FROM Bottoms b WHERE b.aid="+aid+";");
				subset.next();
				subcategory = subset.getString("subcategory");
				
				int size1 = subset.getInt("size1");
				int size2 = subset.getInt("size2");
				
				size = size1+"X"+size2;
				
				similarSearch += subcategory+" "+
						"size<="+(size1+1)+"X"+(size2+1)+
						" size>="+(size1-1)+"X"+(size2-1);
				
				break;
			case "shoes":
				subset = st.executeQuery("SELECT * FROM Shoes s WHERE s.aid="+aid+";");
				subset.next();
				subcategory = subset.getString("subcategory");
				
				int msize = subset.getInt("msize");
				
				size = "M"+msize+"/W"+(msize+2);
				
				similarSearch += subcategory+" "+
						"size<=M"+(msize+1)+"/W"+(msize+3)+
						" size>=M"+(msize-1)+"/W"+(msize+1);
				
				break;
			}
		
		%>
			<div class="listing-container">
				<fieldset>
					<legend><%= auctionname%></legend>
 					<p id="src1" class="ignore source"><%= link%>image1.png</p>
					<p id="src2" class="ignore source"><%= link%>image3.png</p>
					<p id="src3" class="ignore source"><%= link%>image2.png</p>
 					<div class="slider">
						<div class="slide">
							<input type="radio" class="ignore" name="slide" id="img1" checked>
							<input type="radio" class="ignore" name="slide" id="img2">
							<input type="radio" class="ignore" name="slide" id="img3">	
							<img src=<%= link+"image1.png"%> id="frame" alt="product image">
						</div>
						<div class="navigation-manual">
				            <label for="img1" class="manual"></label>
				            <label for="img2" class="manual"></label>
				            <label for="img3" class="manual"></label>
				        </div>
					</div>
					
					<div class="info">
						<p><small><%= color+" "+subcategory%></small></p>
						<p><strong>$<%= Double.parseDouble(amount) %></strong></p>
						<p>Category: <%= category.toUpperCase() %></p>
						<p>Seller: <%= username %></p>
						<br>
						<hr>
						<br>
						<p>Closing time: <%= deadline %></p>
						<p>Size: <%= size %></p>
						<p>Color: <%= color %></p>
						
						<% if(session.getAttribute("user")==null || 
								!username.equals(session.getAttribute("user").toString())){ %>
							<a href=<%= "makeBid.jsp?aid="+aid%> class="button">Bid</a>
							<a href=<%= "bidHistory.jsp?aid="+aid%> class="button">Bid History</a>
						<% } %>
							<a href=<%= "\"searchResults.jsp?search="+similarSearch+"&recency=lastmonth\""%> class="button">View Similar</a>
						
					</div>
				</fieldset>
			</div>
		<% } %>
		<script type="text/javascript" src="Scripts/slider.js"></script>
</body>
</html>