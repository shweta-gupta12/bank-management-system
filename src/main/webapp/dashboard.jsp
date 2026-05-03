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

<%
String userName = (String) hs.getAttribute("user_name");
int userId = (int) hs.getAttribute("user_id");

Connection con = JdbcConnection.getJdbcConnection();
PreparedStatement ps = con.prepareStatement("select * from accounts where user_id=? limit 1");
ps.setInt(1, userId);

ResultSet rs = ps.executeQuery();

long accNo = 0;
String accType = "";

if(rs.next()){
	accNo = rs.getLong("account_number");
	accType = rs.getString("account_type");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<div style="background:white;
     padding:25px;
     border-radius:16px;
     box-shadow:0 0 12px rgba(0,0,0,0.15);
     margin-bottom:25px;
     text-align:center;">
     
	<h2 style="color:#0f3d91;">Welcome, <%=userName %></h2>
	<p style="font-size:18px;"><b>Account Number:</b> <%=accNo %></p>
	<p style="font-size:18px;"><b>Account Type:</b> <%=accType %></p>
</div>
<title>User Dashboard</title>

<style>
body{
	margin:0;
	font-family:Arial,sans-serif;
	background:#eef4ff;
}

.header{
	background:#0f3d91;
	color:white;
	padding:20px;
	text-align:center;
	font-size:30px;
	font-weight:bold;
}

.dashboard-container{
	width:850px;
	margin:40px auto;
}

.title{
	text-align:center;
	color:#0f3d91;
	font-size:28px;
	margin-bottom:30px;
	font-weight:bold;
}

.grid{
	display:grid;
	grid-template-columns:repeat(2,1fr);
	gap:25px;
}

.card{
	background:white;
	padding:35px;
	text-align:center;
	border-radius:16px;
	box-shadow:0 0 12px rgba(0,0,0,0.15);
	transition:0.3s;
}

.card:hover{
	transform:translateY(-5px);
	box-shadow:0 0 18px rgba(0,0,0,0.25);
}

.card a{
	text-decoration:none;
	color:#0f3d91;
	font-size:22px;
	font-weight:bold;
	display:block;
}

.icon{
	font-size:40px;
	margin-bottom:15px;
}
</style>
</head>
<body>

<div class="header">SBI BANK CUSTOMER PORTAL</div>

<div class="dashboard-container">

<div class="title">Welcome To Secure Banking Dashboard</div>

<div class="grid">

	<div class="card">
		<div class="icon">🏦</div>
		<a href="openNewAccount.jsp">Open New Account</a>
	</div>

	<div class="card">
		<div class="icon">💰</div>
		<a href="deposit.jsp">Deposit Money</a>
	</div>

	<div class="card">
		<div class="icon">💸</div>
		<a href="withdraw.jsp">Withdraw Money</a>
	</div>

	<div class="card">
		<div class="icon">🔄</div>
		<a href="transfer.jsp">Transfer Money</a>
	</div>

	<div class="card">
		<div class="icon">📜</div>
		<a href="transactions.jsp">Transaction History</a>
	</div>

	<div class="card">
		<div class="icon">🏧</div>
		<a href="balance.jsp">Check Balance</a>
	</div>

	<div class="card" style="grid-column:span 2;">
		<div class="icon">🚪</div>
		<a href="LogoutServlet">Logout</a>
	</div>

</div>
</div>

</body>
</html>