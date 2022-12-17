package com.buyme;

import java.sql.*;
import java.util.*;

public class Utility{
	
	private Utility(){}

	public static String getCurrentTime() {
		
		return "";
	}
	
	public static void sendNotif(String username, String description, Connection con) {
		try {
			String insert = "INSERT INTO Notifications(username, description, posttime)"+ "VALUES (?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, username);
			ps.setString(2, description);
			
			Calendar calendar = Calendar.getInstance();
		    Timestamp timeStampObj = new java.sql.Timestamp(calendar.getTime().getTime());
		    
			ps.setTimestamp(3, timeStampObj);
			ps.executeUpdate();
			System.out.println("Notif Sent!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static int topSizeToNum(String input) {
		switch(input.toUpperCase()) {
		case "XS":
			return -2;
		case "S":
			return -1;
		case "M":
			return 0;
		case "L":
			return 1;
		case "XL":
			return 2;
		}
		return -3;
	}
	
	public static String numToTopSize(int input) {
		switch(input) {
		case -2:
			return "XS";
		case -1:
			return "S";
		case 0:
			return "M";
		case 1:
			return "L";
		case 2:
			return "XL";
		}
		return "?";
	}
	
	public static void checkAlerts(String username) throws SQLException  {
		String querry = "SELECT * FROM Alerts a WHERE a.username = '"+username+"'";
		
		Database db = new Database();	
		Connection con = db.getConnection();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(querry);
		
		ArrayList<String> queryQueue = new ArrayList<String>();
		
		while (rs.next()) {
			String[] conditions = searchQuery(rs.getString("searchquery"));
			if (conditions[0].equals("error")) {
				break;
			}
			
			String query = conditions[0]+conditions[1];
			if (conditions[1].length() == 0){
				query += " WHERE ";
			} else {
				query += " AND ";
			}
			query += "s.username <> '"+username+"'AND s.posttime > '"+rs.getString("prevcheck")+"'";
			queryQueue.add(query);
			
			String update = "UPDATE Alerts a SET a.prevcheck = ? WHERE a.alid = ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);
	
			//Add parameters of the query.
			Calendar calendar = Calendar.getInstance();
		    Timestamp timeStampObj = new java.sql.Timestamp(calendar.getTime().getTime());
		    ps.setTimestamp(1, timeStampObj);
		    
			ps.setInt(2, rs.getInt("alid"));
			
			System.out.println(ps);
			ps.executeUpdate();
			
		}
		ArrayList<Integer> seenBefore = new ArrayList<Integer>();
		for (String q : queryQueue) {
			querry = "SELECT * FROM "+q;
			rs = st.executeQuery(querry);
			while(rs.next()) {
				int id = rs.getInt("aid");
				if (seenBefore.contains(id)) {
					break;
				}
				sendNotif(username, "Alert! you may be interested in this <a href='ProductListing.jsp?aid="+
						id+"'>newly available item!</a>", con);
				seenBefore.add(id);
			}
		}
	}
	
	public static String[] searchQuery(String query) {
		
		
		ArrayList<String> termlist = new ArrayList<String>();
		for (int i = 0; i < query.length(); i++){
			if (!Character.isWhitespace(query.charAt(i))){
				String term = "";
				while (i < query.length() && !Character.isWhitespace(query.charAt(i))){
					term = term.concat(Character.toString(query.charAt(i)));
					i++;
				}
				termlist.add(term);
			}
		}
		
		String table = "Sellsproduct s";
		String conditions = "";
		
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
				
				if (conditions.length() == 0){
					conditions += " WHERE ";
				} else {
					conditions += " AND ";
				}
				conditions += "t.size "+cmp+" \""+Utility.topSizeToNum(s)+"\"";
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
		
		String[] out = {table,conditions};
		
		return out;
	}
	
	
}