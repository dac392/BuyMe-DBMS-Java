<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>BuyMe | Search</title>
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/thumbnails.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	<%@ include file="Components/Search.jsp" %>
	<br>
	<%
		String search = request.getParameter("search");
		String search_sort = request.getParameter("search-sort");
		String search_sort_dir = request.getParameter("search-sort-order");
		
		String recency = request.getParameter("recency"); //yes I know this is jank
		
		if (search == null){
			search = "";
		}
		if (search_sort == null){
			search_sort = "id";
		}
		if (search_sort_dir == null){
			search_sort_dir = "desc";
		}

		
		Database db = new Database();	
		Connection con = db.getConnection();
		Statement st = con.createStatement();
		
		String ordering = " ORDER BY s.aid ";
		
		if (search_sort.equals("deadline")){
			ordering = " ORDER BY s.deadline ";
		} else if (search_sort.equals("price")) {
			ordering = " ORDER BY s.amount ";
		}
		if (!search_sort_dir.equals("asc")){
			ordering += " DESC ";
		}
		
		String[] queryparams = Utility.searchQuery(search);
		
		if (recency != null && recency.equals("lastmonth")){
			if (queryparams[1].length() == 0){
				queryparams[1] += " WHERE ";
			} else {
				queryparams[1] += " AND ";
			}
			
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.MONTH, -1);
		    Timestamp timeStampObj = new java.sql.Timestamp(calendar.getTime().getTime());
		    
			
		    queryparams[1] += "s.posttime > \'" + timeStampObj.toString()+"\'";
		}
		if (queryparams[0].equals("error")){
			con.close();
			return;
		}

		String querry = "SELECT * FROM "+queryparams[0]+queryparams[1]+ordering;
		
		System.out.println(querry);
		
		ResultSet rs = st.executeQuery(querry);
		
	%>
		
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
	<% con.close(); %>
</body>
</html>