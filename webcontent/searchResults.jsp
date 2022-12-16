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
		if (search == null){
			search = "";
		}
		if (search_sort == null){
			search_sort = "id";
		}
		if (search_sort_dir == null){
			search_sort_dir = "desc";
		}
		
		ArrayList<String> termlist = new ArrayList<String>();
		for (int i = 0; i < search.length(); i++){
			if (!Character.isWhitespace(search.charAt(i))){
				String term = "";
				while (i < search.length() && !Character.isWhitespace(search.charAt(i))){
					term = term.concat(Character.toString(search.charAt(i)));
					i++;
				}
				termlist.add(term);
			}
		}
	
		System.out.println(termlist);

		
		Database db = new Database();	
		Connection con = db.getConnection();
		Statement st = con.createStatement();
		
		String table = "Sellsproduct s";
		String conditions = "";
		String ordering = " ORDER BY s.aid ";
		
		if (search_sort.equals("deadline")){
			ordering = " ORDER BY s.deadline ";
		} else if (search_sort.equals("price")) {
			ordering = " ORDER BY s.amount ";
		}
		if (!search_sort_dir.equals("asc")){
			ordering += " DESC ";
		}
		
		//I am fully aware that this page is basically security breach bait. 
		//Since this is a school project, I don't care.
		for (int i = 0; i < termlist.size(); i++){
			String s = termlist.get(i).toLowerCase();
			
			String cmp = "=";
			String property = "";
								//	*		*			*		*				*		*			*
			String properties[] = {"color", "price", "seller", "isopen", "category", "subcategory", "size" };
			for (int j = 0; j < properties.length; j++){
				if (s.length() >= properties[j].length()+2 &&
						s.substring(0,properties[j].length()).equals(properties[j])){
					char localChar = s.charAt(properties[j].length());
					if (localChar != '=' && localChar != '>' && localChar != '<'){
						continue;
					}
					int cmp_size = 1;
					
					if (localChar != '=' && s.charAt(properties[j].length()+1) == '='){
						cmp_size++;
					}
					
					property = properties[j];
					cmp = s.substring(properties[j].length(),properties[j].length()+cmp_size);
					s = s.substring(properties[j].length()+cmp_size);
					System.out.println(property+"|"+s);
					break;
				}
			}
				
			if (property.equals("seller")){
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				conditions += "s.username = \""+s+"\"";
				
			}
			
			if (property.equals("price")){
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				conditions += "s.amount "+cmp+" \""+s+"\"";
				
			}
			
			if (s.equals("black") ||
					s.equals("brown") ||
					s.equals("grey") ||
					s.equals("green") ||
					s.equals("blue")){
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				conditions += "s.color = \""+s+"\"";
				
			}
			
			if (s.equals("open") ||
					s.equals("closed")){
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				
				if (s.equals("open")){
					conditions += "s.isopen = 1";
				} else {
					conditions += "s.isopen = 0";
				}
				
			}
			
			
			if (s.equals("tops")){
				if (table.equals("Sellsproduct s")){
					table = "Sellsproduct s JOIN Tops t USING(aid)";
				} else if (!table.equals("Sellsproduct s JOIN Tops t USING(aid)")) {
					table = "error";
					break;
				}
			}
			
			if (s.equals("hoodie") ||
					s.equals("crewneck") ||
					s.equals("zipup") ||
					s.equals("fleece")){
				if (table.equals("Sellsproduct s")){
					table = "Sellsproduct s JOIN Tops t USING(aid)";
				} else if (!table.equals("Sellsproduct s JOIN Tops t USING(aid)")) {
					table = "error";
					break;
				}
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				conditions += "t.subcategory = \""+s+"\"";
				
			}
			
			if (Utility.topSizeToNum(s) != -3){
				if (table.equals("Sellsproduct s")){
					table = "Sellsproduct s JOIN Tops t USING(aid)";
				} else if (!table.equals("Sellsproduct s JOIN Tops t USING(aid)")) {
					table = "error";
					break;
				}
			}
				
			if (s.equals("bottoms")){
				if (table.equals("Sellsproduct s")){
					table = "Sellsproduct s JOIN Bottoms b USING(aid)";
				} else if (!table.equals("Sellsproduct s JOIN Bottoms b USING(aid)")) {
					table = "error";
					break;
				}
			}
			
			if (s.equals("jeans") ||
					s.equals("sweatpants")){
				if (table.equals("Sellsproduct s")){
					table = "Sellsproduct s JOIN Bottoms b USING(aid)";
				} else if (!table.equals("Sellsproduct s JOIN Bottoms b USING(aid)")) {
					table = "error";
					break;
				}
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				conditions += "b.subcategory = \""+s+"\"";
				
			}	
			
			if (s.contains("x")){
				int size1, size2;
				int xIndex = s.indexOf("x");
				try{
					size1 = Integer.parseInt(s.substring(0, xIndex));
					size2 = Integer.parseInt(s.substring(xIndex+1));
					
					if (table.equals("Sellsproduct s")){
						table = "Sellsproduct s JOIN Bottoms b USING(aid)";
					} else if (!table.equals("Sellsproduct s JOIN Bottoms b USING(aid)")) {
						table = "error";
						break;
					}
					
					if (conditions.length() == 0){
						conditions += " WHERE ";
					} else {
						conditions += " AND ";
					}
					conditions += "b.size1 "+cmp+" "+size1+" AND b.size2 "+cmp+" "+size2;
				} catch (Exception e){
					
				}
			}
			
			if (s.equals("shoes")){
				if (table.equals("Sellsproduct s")){
					table = "Sellsproduct s JOIN Shoes sh USING(aid)";
				} else if (!table.equals("Sellsproduct s JOIN Shoes sh USING(aid)")) {
					table = "error";
					break;
				}
			}
			
			if (s.equals("boots") ||
					s.equals("sneakers") ||
					s.equals("slides")){
				if (table.equals("Sellsproduct s")){
					table = "Sellsproduct s JOIN Shoes sh USING(aid)";
				} else if (!table.equals("Sellsproduct s JOIN Shoes sh USING(aid)")) {
					table = "error";
					break;
				}
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				conditions += "sh.subcategory = \""+s+"\"";
				
			}
			
			if (s.charAt(0) == 'm' || s.charAt(0) == 'w'){
				int msize;
				int xIndex;
				try{
					if (s.charAt(0) == 'm' && s.contains("/w")){
						xIndex = s.indexOf("/w");
					} else {
						xIndex = s.length();
					}
					msize = Integer.parseInt(s.substring(1, xIndex));
					if (s.charAt(0) == 'w'){
						msize -= 2;
					}
					if (s.contains("/w")){
						int wsize = Integer.parseInt(s.substring(xIndex+2, s.length()));
						if (wsize - msize != 2){
							throw new Exception();
						}
					}
					
					if (table.equals("Sellsproduct s")){
						table = "Sellsproduct s JOIN Shoes sh USING(aid)";
					} else if (!table.equals("Sellsproduct s JOIN Shoes sh USING(aid)")) {
						table = "error";
						break;
					}
					
					if (conditions.length() == 0){
						conditions += " WHERE ";
					} else {
						conditions += " AND ";
					}
					conditions += "sh.msize "+cmp+" "+msize;
				} catch (Exception e){
					
				}
			}
			
			
			
		}
		if (table.equals("error")){
			con.close();
			return;
		}

		String querry = "SELECT * FROM "+table+conditions+ordering;
		
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