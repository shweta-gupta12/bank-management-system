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
<title>Admin Dashboard</title>

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
	width:900px;
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
	font-size:21px;
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

<div class="header">SBI BANK ADMIN PORTAL</div>

<div class="dashboard-container">

<div class="title">Welcome To Bank Management Dashboard</div>

<div class="grid">

	<div class="card">
		<div class="icon">👥</div>
		<a href="viewCustomers.jsp">View All Customers</a>
	</div>

	<div class="card">
		<div class="icon">📜</div>
		<a href="viewAllTransactions.jsp">View All Transactions</a>
	</div>

	<div class="card">
		<div class="icon">🏦</div>
		<a href="totalBankBalance.jsp">Total Bank Balance</a>
	</div>

	<div class="card">
		<div class="icon">🔍</div>
		<a href="searchCustomer.jsp">Search Customer</a>
	</div>

	<div class="card" style="grid-column:span 2;">
		<div class="icon">🚪</div>
		<a href="AdminLogoutServlet">Logout</a>
	</div>

</div>
</div>

</body>
</html>