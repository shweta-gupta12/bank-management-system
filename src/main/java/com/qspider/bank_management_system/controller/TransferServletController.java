package com.qspider.bank_management_system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.qspider.bank_management_system.util.JdbcConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/TransferServlet")
public class TransferServletController extends HttpServlet {
	
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
			
			//step-2 input
			String receiver=req.getParameter("receiver_account");
			if(receiver==null || receiver.isEmpty()) {
				out.println("<script>alert('Receiver Account number is null. Please Enter...'); window.location='transfer.jsp' ; </script>");
				
				return;
			}
			long receiverAccNo= Long.parseLong(receiver);
			double amount=Double.parseDouble(req.getParameter("amount"));
			
			if(amount<=0) {
				out.println("<script>alert('Invalid amount...please enter valid amount'); window.location='transfer.jsp' ; </script>");
				
				return;
			}
			
			//step-3 sender Account
			String query="select account_id, balance from accounts where user_id=?";
			PreparedStatement ps1=con.prepareStatement(query);
			
			ps1.setInt(1, user_id);
			ResultSet rs1=ps1.executeQuery();
			
			int senderAccId=0;
			double senderBalance=0;
			
			if(rs1.next()) {
				senderAccId=rs1.getInt("account_id");
				senderBalance=rs1.getDouble("balance");
			}else {
				out.println("<script>alert('Sender account not found...'); window.location='dashboard.jsp' ; </script>");
				
				return;
			}
			
			//step-4 Receiver account
			String query2="select account_id from accounts where account_number=?";
			PreparedStatement ps2=con.prepareStatement(query2);
			ps2.setLong(1, receiverAccNo);
			
			ResultSet rs2=ps2.executeQuery();
			
			int receiverAccId=0;
			
			if(rs2.next()) {
				receiverAccId=rs2.getInt("account_id");
			}else {
				out.println("<script>alert('receiver account not found...'); window.location='dashboard.jsp' ; </script>");
				
				return;
			}
			
			//prevent self transfer
			if(senderAccId==receiverAccId) {
				out.println("<script>alert('Can not transfer to same account...'); window.location='transfer.jsp' ; </script>");
				
				return;
			}
			
			//step-5 Balance check
			if(senderBalance < amount) {
				out.println("<script>alert('Insufficient Balance'); window.location='dashboard.jsp' ; </script>");
				
				return;
			}
			
			//step-6 Transaction
			con.setAutoCommit(false);
			
			//deduct
			String query3="update accounts set balance = balance-? where account_id=?";
			PreparedStatement ps3=con.prepareStatement(query3);
			ps3.setDouble(1, amount);
			ps3.setInt(2, senderAccId);
			int a=ps3.executeUpdate();
			
			//add
			String query4="update accounts set balance = balance + ? where account_id=?";
			PreparedStatement ps4=con.prepareStatement(query4);
			ps4.setDouble(1, amount);
			ps4.setInt(2, receiverAccId);
			
			int b= ps4.executeUpdate();
			
			//reference
			String ref = "TXN" + System.currentTimeMillis();
			
			//sender transaction (Debit)
			String query5="Insert into transactions(account_id, type, amount, reference_no) values(?,?,?,?)";
			PreparedStatement ps5=con.prepareStatement(query5);
			ps5.setInt(1, senderAccId);
			ps5.setString(2, "Transfer-Debit");
			ps5.setDouble(3, amount);
			ps5.setString(4, ref);
			
			int c=ps5.executeUpdate();
			
			//receiver transaction
			String query6="Insert into transactions(account_id, type, amount, reference_no) values(?,?,?,?)";
			PreparedStatement ps6=con.prepareStatement(query6);
			ps6.setInt(1, receiverAccId);
			ps6.setString(2, "Transfer-Credit");
			ps6.setDouble(3, amount);
			ps6.setString(4, ref);
			
			int d=ps6.executeUpdate();
			
			con.commit();
			
			out.println("<script>alert('Transfer Successful'); window.location='dashboard.jsp' ; </script>");
			
		}
		catch (Exception e) {
			e.printStackTrace(); 
		}
	}

}
