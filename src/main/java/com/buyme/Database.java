package com.buyme;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;

public class Database {
	
	public Database(){
		
	}

	public Connection getConnection(){
		//Create a connection string
		String connectionUrl = "jdbc:mysql://localhost:3306/BuyMe";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", "password");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
	
	
	
	public static void main(String[] args) {
		Database dao = new Database();
		Connection connection = dao.getConnection();
		
		System.out.println(connection);		
		dao.closeConnection(connection);
	}
	

}
