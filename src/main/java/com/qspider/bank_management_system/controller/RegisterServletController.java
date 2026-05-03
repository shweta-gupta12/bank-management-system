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

@WebServlet("/RegisterServletController")
public class RegisterServletController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();

		// step-1 get form data
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String phone = req.getParameter("phone");

		// step-2 validations
		if(name==null || name.trim().isEmpty() ||
		   email==null || email.trim().isEmpty() ||
		   password==null || password.trim().isEmpty() ||
		   phone==null || !phone.matches("\\d{10,12}")) {

			out.println("<script>alert('Please Enter Valid Details'); window.location='register.jsp';</script>");
			return;
		}

		// step-3 set data in dto
		User user = new User();
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setPhone(phone);

		// step-4 save only user
		UserDao dao = new UserDao();
		int a = dao.saveUserDao(user);

		// step-5 response
		if(a != 0) {
			System.out.println("User Registered Successfully...");
			out.println("<script>alert('Registration Successful. Now Login'); window.location='login.jsp';</script>");
		}
		else {
			System.out.println("Registration Failed...");
			out.println("<script>alert('Registration Failed'); window.location='register.jsp';</script>");
		}
	}
}
