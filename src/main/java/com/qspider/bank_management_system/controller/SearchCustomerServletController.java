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

@WebServlet("/SearchCustomerServlet")
public class SearchCustomerServletController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		try {
			HttpSession hs=req.getSession(false);
			
			if(hs==null || hs.getAttribute("admin")==null) {
				resp.sendRedirect("adminLogin.jsp");
				return;
			}
			
			long accountNumber=Long.parseLong(req.getParameter("account_number"));
			
			Connection con=JdbcConnection.getJdbcConnection();
			String sql="select u.name, u.email, u.phone, a.account_number, a.account_type, a.balance "
					+ "from users u inner join accounts a on u.id=a.user_id where a.account_number=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setLong(1, accountNumber);
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()) {
				req.setAttribute("name", rs.getString("name"));
				req.setAttribute("email", rs.getString("email"));
				req.setAttribute("phone", rs.getString("phone"));
				req.setAttribute("account_number", rs.getLong("account_number"));
				req.setAttribute("account_type", rs.getString("account_type"));
				req.setAttribute("balance", rs.getDouble("balance"));
				
				RequestDispatcher rd=req.getRequestDispatcher("customerSearchResult.jsp");
				rd.forward(req, resp);
			}
			else {
				out.println("<script>alert('Customer Not found'); window.location='searchCustomer.jsp';</script>");
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
