package com.qspider.bank_management_system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.qspider.bank_management_system.util.JdbcConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DepositServletController")
public class DepositServletController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		
		try {
			
			Connection con=JdbcConnection.getJdbcConnection(); 
			
			//step-1 get session
			HttpSession session=req.getSession(false);
			
			if(session==null || session.getAttribute("user_id")==null) {
				resp.sendRedirect("login.jsp");
				return;
			}
			int user_id=(int) session.getAttribute("user_id");
			System.out.println("Deposit user id: "+ user_id);
			
			//step-2 get amount
			double amount=Double.parseDouble(req.getParameter("amount"));
			
			if(amount<=0) {
				out.println("<script>alert('Invalid amount..'); window.location='deposit.jsp' ; </script>");
				
				return;
			}
			
			//step-3 get account id from db
			String query1="select account_id from accounts where user_id=?";
			PreparedStatement ps1=con.prepareStatement(query1);
			
			ps1.setInt(1, user_id);
			
			ResultSet rs=ps1.executeQuery();
			
			int account_id=0;
			
			if(rs.next()) {
				account_id=rs.getInt("account_id");
				System.out.println("Account id :"+ account_id);
			}else {
				out.println("Account not found");
				return;
			}
			
			//step-4 Deposit money
			String query2="update accounts set balance = balance + ? where account_id=?";
			PreparedStatement ps2=con.prepareStatement(query2);
			ps2.setDouble(1, amount);
			ps2.setInt(2, account_id);
			
			int a=ps2.executeUpdate();
			
			//step-5 save transaction
			//when money is deposited, it will record the transaction
			String referenceNo="TXN" + System.currentTimeMillis();
			String query3="insert into transactions(account_id,type,amount,reference_no) values(?,?,?,?)";
			PreparedStatement ps3=con.prepareStatement(query3);
			ps3.setInt(1, account_id);
			ps3.setString(2, "Deposit");
			ps3.setDouble(3, amount);
			ps3.setNString(4, referenceNo);
			
			ps3.executeUpdate();
			
			//step-6 response
			if(a>0) {
				out.println("<script>alert('Money Deposited Successfully...'); window.location='dashboard.jsp' ; </script>");
				
			}
			else {
				out.println("<script>alert(' Deposit Failed...'); window.location='deposit.jsp' ; </script>");
				
			}
		} 
		catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

}
