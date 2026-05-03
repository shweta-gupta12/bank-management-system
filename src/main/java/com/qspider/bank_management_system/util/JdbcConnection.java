package com.qspider.bank_management_system.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.cj.jdbc.Driver;

public class JdbcConnection {
	
	public static Connection getJdbcConnection() {
		
		try {
			//step-1 load and register driver
			Driver driver=new Driver();
			DriverManager.registerDriver(driver);
			
			//step-2 create connection
			String url="jdbc:mysql://Localhost:3306/bankdb";
			String username="root";
			String password="root";
			return DriverManager.getConnection(url, username, password);
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			return null;
		}
	}

}
