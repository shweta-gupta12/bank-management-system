package com.qspider.bank_management_system.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.qspider.bank_management_system.dto.User;
import com.qspider.bank_management_system.util.JdbcConnection;

public class UserDao {
	
	Connection con=JdbcConnection.getJdbcConnection();
	
	PreparedStatement ps;
	
	Statement statement;
	
	public int saveUserDao(User user) {

		try {
			String insertQuery = "insert into users(name,email,password,phone) values(?,?,?,?)";
			ps = con.prepareStatement(insertQuery);

			// set data
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getPhone());

			// execute only user insert
			int a = ps.executeUpdate();

			return a;
		}
		catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public User getUserByEmailAndPassword(String email, String password) {
		
		try {
			String query="select * from users where email=? and password=?";
			PreparedStatement ps=con.prepareStatement(query);
			
			ps.setString(1, email);
			ps.setString(2, password);
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()) {
				String dbEmail=rs.getString("email");
				String dbPass=rs.getString("password");
				
				User user=new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(dbEmail);
				user.setPassword(dbPass);
				
				return user;
			}
			return null;
		}
		catch (SQLException e) {
			
			e.printStackTrace();
			return null;
		}
		finally {
			try {
				if(ps!=null)
					ps.close();
				if(con!=null)
					con.close();
					
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

}
