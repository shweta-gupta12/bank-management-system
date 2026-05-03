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
<title>Balance Details</title>

<style>
body{
	margin:0;
	font-family:Arial;
	background:#eef4ff;
}
.header{
	background:#0f3d91;
	color:white;
	padding:18px;
	text-align:center;
	font-size:28px;
}
.card{
	width:450px;
	margin:70px auto;
	background:white;
	padding:35px;
	border-radius:15px;
	box-shadow:0 0 15px rgba(0,0,0,0.2);
}
h2{
	text-align:center;
	color:#0f3d91;
	margin-bottom:25px;
}
p{
	font-size:18px;
	margin:15px 0;
}
a{
	text-decoration:none;
	background:#0f3d91;
	color:white;
	padding:10px 20px;
	border-radius:6px;
}
.center{text-align:center;margin-top:25px;}
</style>
</head>
<body>

<div class="header">ACCOUNT BALANCE DETAILS</div>

<div class="card">
<h2>Customer Account Information</h2>

<p><b>Name:</b> <%=request.getAttribute("name") %></p>
<p><b>Account Number:</b> <%=request.getAttribute("account_number") %></p>
<p><b>Account Type:</b> <%=request.getAttribute("account_type") %></p>
<p><b>Available Balance:</b> ₹ <%=request.getAttribute("balance") %></p>

<div class="center">
<a href="dashboard.jsp">Back To Dashboard</a>
</div>
</div>

</body>
</html>