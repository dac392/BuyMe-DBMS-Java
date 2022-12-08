package com.buyme;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;

public class Utility{
	
	private Utility(){}

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
		switch(input) {
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
		return 0;
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
	
	
}