package com.qspider.bank_management_system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.qspider.bank_management_system.util.JdbcConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OpenNewAccountServlet")
public class OpenNewAccountServletController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		try {
			HttpSession session=req.getSession(false);
			
			if(session==null || session.getAttribute("user_id")==null) {
				resp.sendRedirect("login.jsp");
				return;
			}
			
			int user_id=(int) session.getAttribute("user_id");
			
			String accountType=req.getParameter("account_type");
			
			double balance=Double.parseDouble(req.getParameter("initial_balance"));
			
			if(balance < 0) {
				out.println("<script>alert('Invalid Initial Deposit'); window.location=openNewAccount.jsp';</script>");
				return;
			}
			
			Connection con=JdbcConnection.getJdbcConnection();
			
			//check if this user already has account then reject creation
			String checkQuery="select * from accounts where user_id=?";
			PreparedStatement check=con.prepareStatement(checkQuery);
			check.setInt(1, user_id);
			
			ResultSet rs=check.executeQuery();
			
			if(rs.next()) {
				out.println("<script>alert('Account Already Exists For This User'); window.location='dashboard.jsp';</script>");
				return;
			}
			
			//generate 10 digit account number
			long accountNumber=1000000000L + (long)(Math.random()*9000000000L);
			
			
			
			String query="insert into accounts(user_id, balance, account_type, account_number) values(?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, user_id);
			ps.setDouble(2, balance);
			ps.setString(3, accountType);
			ps.setLong(4, accountNumber);
			
			int a=ps.executeUpdate();
			
			if(a>0) {
				out.println("<script>alert('New Account Created Successfully'); window.location='dashboard.jsp;'</script>");
			}else {
				out.println("<script>alert('Account Creation Failed'); window.location='dashboard.jsp;'</script>");
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
			
		}
	}

}
