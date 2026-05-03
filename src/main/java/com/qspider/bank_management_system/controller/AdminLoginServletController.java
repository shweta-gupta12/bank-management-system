package com.qspider.bank_management_system.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServletController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html");
		PrintWriter out= resp.getWriter();
		
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		
		if(email.equals("admin@sbibank.com") && password.equals("admin123")) {
			HttpSession session=req.getSession();
			
			session.setAttribute("admin", "ADMIN");
			
			out.println("<script>alert('Admin Login Successful'); window.location='adminDashboard.jsp';</script>");
		}
		else {
			out.println("<script>alert('Invalid Admin Credentials'); window.location='adminLogin.jsp';</script>");
		}
	}

}
