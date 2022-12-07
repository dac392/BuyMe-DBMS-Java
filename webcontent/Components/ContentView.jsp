<%@ page import ="java.io.*,java.util.*,java.sql.*,com.buyme.*"%>

<%
	Database db = new Database();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String querry = "SELECT * FROM Sellsproduct ORDER BY aid DESC LIMIT 10;";
	ResultSet rs = st.executeQuery(querry);
%>

<div class="component-container">
	<h2>Hot New Items</h2>
	<div class="content-container">
		<% while(rs.next()){ %>
			<%
				String title = rs.getString("auctionname");
			%>
			<div class="card" onclick="location.href='ProductListing.jsp?aid='+<%= rs.getInt("aid")%>+'';">
			  <img src=<%= rs.getString("link")+"image1.png"%> alt="Product" style="width:100%">
			  <div class="container">
			  	<h4 id="title"><%= title.toUpperCase()%></h4>
			    <h4><b>$<%= rs.getString("amount")%></b></h4>
			    <p><%= rs.getString("deadline")%></p>
			  </div>
			</div> 
		<% } %>
	</div>
</div>