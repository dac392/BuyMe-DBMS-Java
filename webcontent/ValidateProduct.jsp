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
		String person, auctionname, date, category, color;
		float minimum, amount, increment;
		
		try {
			person = session.getAttribute("user").toString();
			auctionname = request.getParameter("auction-name");
			minimum = Float.parseFloat(request.getParameter("min-price")); 
			amount = Float.parseFloat(request.getParameter("amount"));
			increment = Float.parseFloat(request.getParameter("bid-increment"));
			date = request.getParameter("end-date");
			category = request.getParameter("category");
			color = request.getParameter("color").toLowerCase();
		
		} catch (Exception e){
			response.sendRedirect("ProductUpload.jsp");
			return;
		}
		
		float size1 = 0, size2 = 0; 
		String sub = null;//default, I guess
		
		try {
			switch (category){
			case "tops":
				sub = request.getParameter("t-sub-category");
				size1 = (float)Utility.topSizeToNum(request.getParameter("t-size"));
				break;
			case "bottoms":
				sub = request.getParameter("b-sub-category");
				size1 = Float.parseFloat(request.getParameter("b-size-1"));
				size2 = Float.parseFloat(request.getParameter("b-size-2"));
				break;
			case "shoes":
				sub = request.getParameter("s-sub-category");
				size1 = Float.parseFloat(request.getParameter("s-size"));
				break;
			default:
			}
		
		} catch (Exception e){
			response.sendRedirect("ProductUpload.jsp");
			return;
		}
		
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
		String insert = "INSERT INTO Sellsproduct(aid, isopen, auctionname, username, minimumprice, amount, bidincrement, deadline, category, color, link)"+ "VALUES (null,true,?,?,?,?,?,?,?,?,?)";
		
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
		ps.setString(8, color);
		ps.setString(9, link);
		
		ps.executeUpdate();
		
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM Sellsproduct s WHERE s.aid=(SELECT max(s.aid) FROM Sellsproduct s where username ='" +person+"');");
	    int newAid = -1;
	    if (rs.next()){
	    	newAid = rs.getInt("aid");
	    }
	    
		if (newAid == -1){
			response.sendRedirect("ProductUpload.jsp");
		}
		
	    
	    //Store subcategory data
	    switch (category){
	    case "tops":
	    	insert = "INSERT INTO Tops(aid, subcategory, size)"+ "VALUES (?,?,?)";
	    	ps = con.prepareStatement(insert);
	    	
	    	ps.setString(1, newAid+"");
			ps.setString(2, sub);
			ps.setString(3, size1+"");
			
			ps.executeUpdate();
			break;
	    case "bottoms":
	    	insert = "INSERT INTO Bottoms(aid, subcategory, size1, size2)"+ "VALUES (?,?,?,?)";
	    	ps = con.prepareStatement(insert);
	    	
	    	ps.setString(1, newAid+"");
			ps.setString(2, sub);
			ps.setString(3, size1+"");
			ps.setString(4, size2+"");
			
			ps.executeUpdate();
			break;
	    case "shoes":
	    	insert = "INSERT INTO Shoes(aid, subcategory, msize)"+ "VALUES (?,?,?)";
	    	ps = con.prepareStatement(insert);
	    	
	    	ps.setString(1, newAid+"");
			ps.setString(2, sub);
			ps.setString(3, size1+"");
			
			ps.executeUpdate();
			break;
		default:
	    }
	    
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("insert succeeded");
		
		response.sendRedirect("ProductListing.jsp?aid="+newAid);
	%>
	
	
</body>
</html>