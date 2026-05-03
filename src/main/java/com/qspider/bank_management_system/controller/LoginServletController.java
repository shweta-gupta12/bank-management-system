package com.qspider.bank_management_system.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.qspider.bank_management_system.dao.UserDao;
import com.qspider.bank_management_system.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServletController")
public class LoginServletController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		//fetch data from login page
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		
		
		User user=new UserDao().getUserByEmailAndPassword(email, password);
		
		if(user!=null) {
//			int userId=user.getId();
			HttpSession session=req.getSession();
			session.setAttribute("user_id", user.getId());
			session.setAttribute("user_name", user.getName());
			session.setAttribute("user_email", user.getEmail());
			
			System.out.println("Login user id:"+ user.getId() );
			
			out.println("<script>alert('Login successfull'); window.location='dashboard.jsp' ;</script>");
			
//			resp.sendRedirect("dashboard.jsp");
//			System.out.println("login successfull...");
		}
		else {
			out.println("<script>alert('Invalid email or password'); window.location='login.jsp' ;</script>");
//			out.println("Invalid email or password");
//			System.out.println("something went wrong....");
		}
		
	}

}
