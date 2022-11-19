package com.buyme;

import java.sql.*;
import java.util.*;

public class Notifs{
	
	private Notifs() {}
	
	public static void send(String username, String description, Connection con) {
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
	
}