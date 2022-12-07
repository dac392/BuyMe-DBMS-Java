<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		//Get parameters from the HTML form
		String person = session.getAttribute("user").toString();
		String auctionname = request.getParameter("auction-name");
		float minimum = Float.parseFloat(request.getParameter("min-price")); 
		float amount = Float.parseFloat(request.getParameter("amount"));
		float increment = Float.parseFloat(request.getParameter("bid-increment"));
		String date = request.getParameter("end-date");
		String category = request.getParameter("category");
		String sub = request.getParameter("sub-category");
		String size = request.getParameter("size");
		String color = request.getParameter("color");
		
		//Get the database connection
		Database db = new Database();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Make an insert statement for the Users table:
		/* System.out.println("`%"+sub+"/"+color+"%';"); */
 		String querry = "SELECT link FROM Assets WHERE link LIKE \"%"+sub+"/"+color+"%\";";
 		ResultSet result = stmt.executeQuery(querry);
		String link = "";
		if(result.next()){
			link = result.getString("link");
		}else{
			link = "Assets/"+sub+"/default/";
		}

		
		
		
		
		//Make an insert statement for the Users table:
		String insert = "INSERT INTO Sellsproduct(aid, isopen, auctionname, username, minimumprice, amount, bidincrement, deadline, category, subcategory, size, color, link)"+ "VALUES (null,true,?,?,?,?,?,?,?,?,?,?,?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		
		ps.setString(1, auctionname);
		ps.setString(2, person);
		ps.setString(3, minimum+"");
		ps.setString(4, amount+"");
		ps.setString(5, increment+"");
		ps.setString(6, date);
		ps.setString(7, category);
		ps.setString(8, sub);
		ps.setString(9, size);
		ps.setString(10, color);
		ps.setString(11, link);
		
		
		ps.executeUpdate();
		

	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM Sellsproduct s WHERE s.aid=(SELECT max(s.aid) FROM Sellsproduct s where username ='" +person+"');");
	    int newAid = -1;
	    if (rs.next()){
	    	newAid = rs.getInt("aid");
	    }
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("insert succeeded");
		if (newAid != -1){
			response.sendRedirect("ProductListing.jsp?aid="+newAid);
		} else {
			response.sendRedirect("ProductUpload.jsp");
		}
	%>
	
	
</body>
</html>