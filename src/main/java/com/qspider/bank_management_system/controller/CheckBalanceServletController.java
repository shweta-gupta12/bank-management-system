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

@WebServlet("/CheckBalanceServlet")
public class CheckBalanceServletController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		try {
			Connection con=JdbcConnection.getJdbcConnection();
			
			//step-1 get session
			HttpSession session=req.getSession(false);
			
			if(session == null || session.getAttribute("user_id")==null) {
				resp.sendRedirect("login.jsp");
				return;
			}
			
			int user_id=(int) session.getAttribute("user_id");
			
			//step-2 Fetch balance
			String sql="select u.name, a.account_number, a.account_type, a.balance " + " from users u inner join accounts a on u.id=a.user_id where u.id=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, user_id);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()) {
				req.setAttribute("name", rs.getString("name"));
				req.setAttribute("account_number", rs.getLong("account_number"));
				req.setAttribute("account_type", rs.getString("account_type"));
				req.setAttribute("balance", rs.getDouble("balance"));
				
				RequestDispatcher rd=req.getRequestDispatcher("balanceResult.jsp");
				
				rd.forward(req, resp);
				
				
			}
			else {
				out.println("Account not found");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
