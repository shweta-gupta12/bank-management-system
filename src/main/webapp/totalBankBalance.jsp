<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.qspider.bank_management_system.util.JdbcConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
HttpSession hs = request.getSession(false);

if(hs==null || hs.getAttribute("admin")==null){
	response.sendRedirect("adminLogin.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Total Bank Balance</title>
<style>
body{margin:0;font-family:Arial;background:#eef4ff;}
.header{background:#0f3d91;color:white;padding:18px;text-align:center;font-size:28px;}
.card{
	width:450px;
	margin:100px auto;
	background:white;
	padding:35px;
	border-radius:15px;
	box-shadow:0 0 15px rgba(0,0,0,0.2);
	text-align:center;
}
.amount{font-size:35px;color:green;font-weight:bold;margin:25px;}
a{text-decoration:none;background:#0f3d91;color:white;padding:10px 20px;border-radius:6px;}
</style>
</head>
<body>

<div class="header">TOTAL BANK BALANCE SUMMARY</div>

<div class="card">
<%
Connection con = JdbcConnection.getJdbcConnection();
PreparedStatement ps = con.prepareStatement("select sum(balance) as total_balance from accounts");
ResultSet rs = ps.executeQuery();

double total=0;
if(rs.next()){ total=rs.getDouble("total_balance"); }
%>

<h2>Total Customer Holdings</h2>
<div class="amount">₹ <%=total%></div>
<a href="adminDashboard.jsp">Back To Dashboard</a>
</div>

</body>
</html>