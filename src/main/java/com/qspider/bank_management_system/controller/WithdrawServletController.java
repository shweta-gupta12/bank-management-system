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

@WebServlet("/WithdrawServletController")
public class WithdrawServletController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		Connection con=JdbcConnection.getJdbcConnection();
		
		try {
			//step-1 get session
			HttpSession session=req.getSession(false);
			
			if(session==null || session.getAttribute("user_id")==null) {
				resp.sendRedirect("login.jsp");
				System.out.println("something went wrong.....");
				return;
			}
			int user_id=(int)session.getAttribute("user_id");
			
			//step-2 get amount
			double amount=Double.parseDouble(req.getParameter("amount"));
			if(amount<=0) {
//				out.println("<script>alert('Insufficient amount...'); window.location='withdraw.jsp' ; </script>");
				
				out.println("Insufficient Amount.....");
				return;
			}
			
			//step-3 get account id
			String query="select account_id, balance from accounts where user_id=?";
			PreparedStatement ps1=con.prepareStatement(query);
			ps1.setInt(1, user_id);
			
			ResultSet rs=ps1.executeQuery();
			
			int account_id=0;
			double balance=0;
			
			if(rs.next()) {
				account_id=rs.getInt("account_id");
				balance=rs.getDouble("balance");
			}else {
				out.println("Account not found");
				
				return;
			}
			
			//step-4 check sufficient balance
			if(balance<amount) {
				out.println("Insufficient Amount.....");
				return;
			}
			
			//step-5 update balance
			String query1="update accounts set balance=balance-? where account_id=?";
			PreparedStatement ps2=con.prepareStatement(query1);
			ps2.setDouble(1, amount);
			ps2.setInt(2, account_id);
			
			int a=ps2.executeUpdate();
			
			//step-6 genetare reference number
			String referenceNo="TXN" + System.currentTimeMillis();
			
			//step-7 insert transaction
			String query2="insert into transactions(account_id,type,amount,reference_no) values(?,?,?,?)";
			PreparedStatement ps3=con.prepareStatement(query2);
			ps3.setInt(1, account_id);
			ps3.setString(2, "Withdraw");
			ps3.setDouble(3, amount);
			ps3.setString(4, referenceNo);
			
			ps3.executeUpdate();
			
			//step-8 response
			
			if(a>0) {
				//pop up message
				out.println("<script>alert('Withdrawal Successfull...'); window.location='dashboard.jsp' ; </script>");
				
//				out.println("Withdrawal Successfully...");
//				RequestDispatcher rd=req.getRequestDispatcher("/dashboard.jsp");
//				rd.include(req, resp);
			}
			else {
				    out.println("<script>alert('Withdraw Failed...'); window.location='withdraw.jsp' ; </script>");
				    
//					out.println("Withdraw Failed...");
//					RequestDispatcher rd=req.getRequestDispatcher("/withdraw.jsp");
//					rd.include(req, resp);
				}
			
		} 
		catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

}
