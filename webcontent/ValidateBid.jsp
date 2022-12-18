<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Validate</title>
</head>
<body>
	<%
		LocalDateTime dt = LocalDateTime.now();
		String[] arr = dt.toString().split("T");
		arr[1] = arr[1].substring(0,8);
		
		String date = arr[0]+" "+arr[1];
		String user = session.getAttribute("user").toString();
		String floor = request.getParameter("floor"); 
		String ceiling = request.getParameter("ceiling"); 
		String option = request.getParameter("type"); 
		String aid = request.getParameter("aid");
		
		if (aid == null){
			response.sendRedirect("index.jsp");
		}
		if (option == null){
			response.sendRedirect("makeBid.jsp?aid="+aid);
		}
		
 		
		if(ceiling.isBlank()){
			if(!option.equals("auto")){
				ceiling=floor;
			}
		}
			
		
 		//Get the database connection
		Database db = new Database();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
	
		//check auction
		String str = "SELECT * FROM Sellsproduct a WHERE a.aid = "+aid+" AND a.amount + a.bidincrement <= "+ceiling;
			
		//Run the query against the database.
		System.out.println(str);
		ResultSet result = stmt.executeQuery(str);
		if (!result.next()){
			out.println("Bid Invalid: Try bidding higher<br/>");	
			out.println("<a href='makeBid.jsp?aid="+aid+"'>return</a>");	
			return;
		}
		
		
		//Make an insert statement for the Users table:
		String insert = "INSERT INTO Bids(aid, username, floor, ceiling, type, date)"+ "VALUES (?,?,?,?,?,?);";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		
		ps.setString(1, aid);
		ps.setString(2, user);
		ps.setString(3, floor);
		ps.setString(4, ceiling);
		ps.setString(5, option);
		ps.setString(6, date);

		ps.executeUpdate();
		
		insert = "INSERT INTO Bidhistory(aid, username, offer, date)"+ "VALUES (?,?,?,?);";
		ps = con.prepareStatement(insert);
		
		ps.setString(1, aid);
		ps.setString(2, user);
		ps.setString(3, floor);
		ps.setString(4, date);
		
		ps.executeUpdate();
		
		
		insert = "UPDATE Sellsproduct a SET a.amount = ? WHERE a.aid = ?;";
		ps = con.prepareStatement(insert);
		
		ps.setFloat(1, Float.parseFloat(floor));
		ps.setInt(2, Integer.parseInt(aid));
		
		ps.executeUpdate();
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		response.sendRedirect("ProductListing.jsp?aid="+aid);
		
		
	%>

</body>
</html>