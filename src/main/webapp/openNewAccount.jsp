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
<title>Open New Account</title>

<style>
body{margin:0;font-family:Arial;background:#eef4ff;}
.header{background:#0f3d91;color:white;padding:18px;text-align:center;font-size:28px;}
.container{
	width:400px;
	margin:70px auto;
	background:white;
	padding:35px;
	border-radius:15px;
	box-shadow:0 0 15px rgba(0,0,0,0.2);
	text-align:center;
}
input,select{
	width:90%;
	padding:12px;
	margin:12px;
	border:1px solid #bbb;
	border-radius:6px;
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

<div class="header">OPEN NEW BANK ACCOUNT</div>

<div class="container">
<form action="OpenNewAccountServlet" method="post">
<select name="account_type" required>
<option value="">Select Account Type</option>
<option value="Saving">Saving</option>
<option value="Current">Current</option>
<option value="Salary">Salary</option>
</select>

<input type="number" name="initial_balance" placeholder="Enter Initial Deposit" required>

<button type="submit">Create Account</button>
</form>

<br>
<a href="dashboard.jsp">Back To Dashboard</a>
</div>

</body>
</html>