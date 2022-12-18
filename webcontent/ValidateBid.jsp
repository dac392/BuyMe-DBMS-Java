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
		String str = "SELECT * FROM Sellsproduct a WHERE a.aid = "+aid+
						" AND a.isopen = true AND a.amount + a.bidincrement <= "+ceiling;
			
		//Run the query against the database.
		System.out.println(str);
		ResultSet result = stmt.executeQuery(str);
		if (!result.next()){
			out.println("Bid Invalid: Try bidding higher<br/>");	
			out.println("<a href='makeBid.jsp?aid="+aid+"'>return</a>");	
			return;
		}
		
		float increment = result.getFloat("bidincrement");//to be used for autobids
		
		result = stmt.executeQuery("SELECT * FROM Bids b WHERE b.aid = "+aid+" AND b.username = '"+user+"'");
		boolean update_bid = result.next();
		
		PreparedStatement ps;
		
		if (update_bid){
			String insert = "UPDATE Bids b SET b.floor = ?, b.ceiling = ?, b.type = ?, b.date = ? WHERE "+
							" b.aid = "+aid+" AND b.username = '"+user+"'";
			
			ps = con.prepareStatement(insert);
			
			ps.setString(1, floor);
			ps.setString(2, ceiling);
			ps.setString(3, option);
			ps.setString(4, date);
			
			ps.executeUpdate();
		} else {
			//Make an insert statement for the Users table:
			String insert = "INSERT INTO Bids(aid, username, floor, ceiling, type, date)"+ "VALUES (?,?,?,?,?,?);";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ps = con.prepareStatement(insert);
			
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			
			ps.setString(1, aid);
			ps.setString(2, user);
			ps.setString(3, floor);
			ps.setString(4, ceiling);
			ps.setString(5, option);
			ps.setString(6, date);
	

			ps.executeUpdate();
		}
		
		//get prev leader
		str = "SELECT b.username AS user, b.offer AS bid FROM Bidhistory b WHERE b.aid = "+aid+
			" ORDER BY offer LIMIT 1";
		result = stmt.executeQuery(str);
		String prev_leader = "";
		if (result.next()){
			prev_leader = result.getString("user");
		}
		
		//Add actual bid log
		
		String insert = "INSERT INTO Bidhistory(aid, username, offer, date)"+ "VALUES (?,?,?,?);";
		ps = con.prepareStatement(insert);
		
		ps.setString(1, aid);
		ps.setString(2, user);
		ps.setString(3, floor);
		ps.setString(4, date);
		
		try{
			ps.executeUpdate();
		} catch(Exception e){}
		
		//auto updates
		
		float final_amount = Float.parseFloat(floor);
		String final_user = user;
		
		boolean loopflag = false;
		do{

			System.out.println("loop");
			loopflag = false;
			String activeAutoBidQuery = "SELECT * FROM Bids b WHERE b.type='auto' AND b.floor < b.ceiling AND b.aid = "+aid+"";
			result = stmt.executeQuery(activeAutoBidQuery);
			while (result.next()){
				if (final_user.equals(result.getString("username"))){
					continue;
				}
				System.out.println(result.getString("username"));
				
				loopflag = true;
				
				boolean isOutbid = true;
				if (final_amount + increment < result.getFloat("ceiling")){
					isOutbid = false;
					insert = "INSERT INTO Bidhistory(aid, username, offer, date)"+ " VALUES (?,?,?,?);";
					ps = con.prepareStatement(insert);
					
					ps.setString(1, aid);
					ps.setString(2, result.getString("username"));
					ps.setString(3, final_amount + increment+"");
					ps.setString(4, date);
					
					System.out.println(ps);
					
					ps.executeUpdate();
					final_user = result.getString("username");
					final_amount += increment;
					
				}
				String update = "UPDATE Bids b SET b.floor = ? WHERE b.aid = ? AND b.username = ?";
				ps = con.prepareStatement(update);
				if (isOutbid){
					ps.setString(1, result.getFloat("ceiling")+"");
				} else {
					ps.setString(1, final_amount+"");
				}
				ps.setString(2, aid);
				ps.setString(3, result.getString("username"));
				
				System.out.println(ps);
				
				ps.executeUpdate();
				
			}
			
			
		} while (loopflag);
		
		//FINAL: update Auction itself
		
		insert = "UPDATE Sellsproduct a SET a.amount = ? WHERE a.aid = ?;";
		ps = con.prepareStatement(insert);
		
		ps.setFloat(1, final_amount);
		ps.setInt(2, Integer.parseInt(aid));
		
		ps.executeUpdate();
		
		//Notify All others
		if (!prev_leader.equals(user)){
			str = "SELECT b.username AS user, max(b.offer) AS bid FROM Bidhistory b WHERE b.aid = "+aid+
				" GROUP BY user";
			result = stmt.executeQuery(str);
			while (result.next()){
				if (result.getDouble("bid") < final_amount){
					Utility.sendNotif(result.getString("user"),
							"You have been outbid by "+final_user+"in an auction! Check the auction <a href='ProductListing.jsp?aid="+
							aid+"'>here.</a>"
							, con);
				}
			}
		}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		response.sendRedirect("ProductListing.jsp?aid="+aid);
		
		
	%>

</body>
</html>