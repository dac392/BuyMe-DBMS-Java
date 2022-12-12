<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import ="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | History</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<%
		String aid = request.getParameter("aid").toString();
		Database db = new Database();	
		Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM Bids b WHERE b.aid="+aid+";");
	%>
		<table>
		<tr>
			<td>aid</td>
			<td>username</td>
			<td>floor</td>
			<td>ceiling</td>
			<td>type</td>
			<td>date</td>
		</tr>
		
		<%while(rs.next()){%>
			<tr>
				<td><%= rs.getString("aid") %></td>
				<td><%= rs.getString("username") %></td>
				<td><%= rs.getString("floor") %></td>
				<td><%= rs.getString("ceiling") %></td>
				<td><%= rs.getString("type") %></td>
				<td><%= rs.getString("date") %></td>
				<td>
			</tr>
			
		<%
		}
		%>
	</table>
</body>
</html>