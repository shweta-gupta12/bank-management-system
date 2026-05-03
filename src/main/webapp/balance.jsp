<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.qspider.bank_management_system.util.JdbcConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
HttpSession hs = request.getSession(false);

if(hs==null || hs.getAttribute("user_id")==null){
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Balance</title>
<style>
body{margin:0;font-family:Arial;background:#eef4ff;}
.header{background:#0f3d91;color:white;padding:18px;text-align:center;font-size:28px;}
.container{
	width:400px;
	margin:90px auto;
	background:white;
	padding:35px;
	border-radius:15px;
	box-shadow:0 0 15px rgba(0,0,0,0.2);
	text-align:center;
}
button{
	width:95%;
	padding:12px;
	background:#0f3d91;
	color:white;
	border:none;
	border-radius:6px;
	font-size:16px;
}
a{text-decoration:none;color:#0f3d91;}
</style>
</head>
<body>

<div class="header">CHECK ACCOUNT BALANCE</div>

<div class="container">
<form action="CheckBalanceServlet" method="get">
<button type="submit">View Available Balance</button>
</form>
<br>
<a href="dashboard.jsp">Back To Dashboard</a>
</div>

</body>
</html>