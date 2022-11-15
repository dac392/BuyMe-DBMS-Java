<%@ page import ="java.io.*,java.util.*,java.sql.*"%>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "");
	Statement st = con.createStatement();
	String querry = "SELECT * FROM Sellsproduct ORDER BY aid DESC LIMIT 10;";
	ResultSet rs = st.executeQuery(querry);

%>

<div class="component-container">
	<h2>Hot New Items</h2>
	<div class="content-container">
		<% while(rs.next()){ %>
		
			<div class="card">
			  <img src=<%= rs.getString("link")+"image1.png"%> alt="Product" style="width:100%">
			  <div class="container">
			    <h4><b>$<%= rs.getString("amount")%></b></h4>
			    <p><%= rs.getString("deadline")%></p>
			  </div>
			</div> 
		<% } %>
	</div>
</div>