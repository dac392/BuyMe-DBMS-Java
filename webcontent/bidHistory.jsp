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
	    ResultSet rs = st.executeQuery("SELECT * FROM BidHistory b WHERE b.aid="+aid+
	    		" ORDER BY b.offer DESC, b.date DESC");
	    
	    String userid = (String)session.getAttribute("user");	
		Boolean isstaff = (Boolean)session.getAttribute("user-isstaff");
	%>
		<table>
		<tr>
			<td>username</td>
			<td>offer</td>
			<td>date</td>
			<% 
			if (isstaff != null && isstaff.booleanValue() == true) {
				out.println("<td></td>");
			}%>
		</tr>
		
		<%while(rs.next()){%>
			<tr>
				<td><a href='UserHistory.jsp?user=<%= rs.getString("username")%>'><%= rs.getString("username") %></a></td>
				<td>$<%= rs.getString("offer") %></td>
				<td><%= rs.getString("date") %></td>
				<% 
				if (isstaff != null && isstaff.booleanValue() == true) {
					out.println("<td><a href='RemoveUserFromAuction.jsp?aid="+rs.getInt("aid")+
					"&user="+rs.getString("username")+"'>Delete</a></td>");
				}%>
			</tr>
			
		<%
		}
		%>
	</table>
</body>
</html>