<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<% 
	
	String userid = (String)session.getAttribute("user");	
	Boolean isadmin = (Boolean)session.getAttribute("user-isadmin");
	if (userid == null || isadmin == null || isadmin.booleanValue() == false) {
		response.sendRedirect("Login.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Admin</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<h1>Administrator Page</h1>
	<h2>Set User Rank</h2>
	<form method="post" action="EditUserPermissions.jsp">
			<label for="username">Target Username:</label>
			<input type="text" id="username" name="username" /><br/>
			
			<label for="isstaff">New rank:</label>
			<select id="isstaff" name="isstaff" >
				<option value="true">Customer Representative</option>
				<option value="false">Regular User</option>
			</select><br/>
			
			<input type="submit" value="Submit" />
	</form>
	<h2>Analytics</h2>
	<table>
	<%
	Database db = new Database();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT sum(s.amount) AS total, avg(s.amount) AS avg FROM Sellsproduct s WHERE s.isopen = FALSE AND s.amount > s.initial AND s.amount >= s.minimumprice");
    if(rs.next()){
    	out.println("<tr><td>Total Earnings: $"+rs.getFloat("total")+"</td>");
    	out.println("<td>Average Earnings Per Sell: $"+rs.getFloat("avg")+"</td></tr>");
    }
    
    rs = st.executeQuery("SELECT sum(s.amount) AS total, avg(s.amount) AS avg FROM Sellsproduct s WHERE s.isopen = FALSE AND s.amount >= s.minimumprice AND s.amount > s.initial AND s.category = \'tops\'");
    if(rs.next()){
    	out.println("<tr><td>Total Earnings For Tops: $"+rs.getFloat("total")+"</td>");
    	out.println("<td>Average Earnings Per Tops: $"+rs.getFloat("avg")+"</td></tr>");
    }
    
    rs = st.executeQuery("SELECT sum(s.amount) AS total, avg(s.amount) AS avg FROM Sellsproduct s WHERE s.isopen = FALSE AND s.amount >= s.minimumprice AND s.amount > s.initial AND s.category = \'bottoms\'");
    if(rs.next()){
    	out.println("<tr><td>Total Earnings For Bottoms: $"+rs.getFloat("total")+"</td>");
    	out.println("<td>Average Earnings Per Bottoms: $"+rs.getFloat("avg")+"</td></tr>");
    }
    
    rs = st.executeQuery("SELECT sum(s.amount) AS total, avg(s.amount) AS avg FROM Sellsproduct s WHERE s.isopen = FALSE AND s.amount >= s.minimumprice AND s.amount > s.initial AND s.category = \'shoes\'");
    if(rs.next()){
    	out.println("<tr><td>Total Earnings For Shoes: $"+rs.getFloat("total")+"</td>");
    	out.println("<td>Average Earnings Per Shoes: $"+rs.getFloat("avg")+"</td></tr>");
    }
	%>
	</table><br/>
	
	<form method="get" action="AdminPage.jsp" id="analytics-condition-form" class="search-bar">
		<label for="condition">Filter Condition:</label>
		<input type="text" id="condition" name="condition" <%
			String al_condition = request.getParameter("condition");
			if (al_condition != null){
				out.print("value=\""+al_condition+"\"");
			}
		%>>
		<input type="submit" value="Submit">
	</form>
	<table>
	<% 
	if (al_condition != null){
		String[] conds = Utility.searchQuery(al_condition);
		
		String query = "SELECT sum(s.amount) AS total, avg(s.amount) AS avg FROM "+conds[0]+conds[1];
		if (!conds[0].equals("error")){
			
			if (conds[1].length() == 0){
				query += " WHERE ";
			} else {
				query += " AND ";
			}
			query += " s.isopen = FALSE AND s.amount >= s.minimumprice AND s.amount > s.initial AND s.category = \'shoes\'";
			
			rs = st.executeQuery(query);
			
		    if(rs.next()){
		    	out.println("<tr><td>Total Earnings: $"+rs.getFloat("total")+"</td>");
		    	out.println("<td>Average Earnings: $"+rs.getFloat("avg")+"</td></tr>");
		    }
		}
    }
	%>
	</table>
	<h3>Best Selling Items</h3>
	<%
	rs = st.executeQuery("SELECT * FROM Sellsproduct s WHERE s.isopen = FALSE AND s.amount >= s.minimumprice AND s.amount > s.initial ORDER BY s.amount DESC LIMIT 20");
    while(rs.next()){
    	out.println("<a href=ProductListing.jsp?aid="+rs.getInt("aid")+">"+rs.getString("auctionname")+"</a>: $"+rs.getFloat("amount")+"<br/>");
    }
    %>
    
	<h3>Best Buyers</h3>
	<%
	rs = st.executeQuery("SELECT e.username AS uname, sum(b.floor) AS spendings "+
						"FROM Enduser e JOIN Bids b USING(username) JOIN Sellsproduct s USING(aid) "+
						"WHERE s.isopen = FALSE AND s.amount >= s.minimumprice AND s.amount > s.initial AND b.floor = s.amount "+
						"GROUP BY uname");
    while(rs.next()){
    	out.println("<a href=UserHistory.jsp?user="+rs.getString("uname")+">"+rs.getString("uname")+"</a>: $"+
    rs.getString("spendings")+" spent<br>");
    }
    %>

</body>
</html>