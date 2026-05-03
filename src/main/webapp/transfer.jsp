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
<title>Transfer Money</title>
<style>
body{margin:0;font-family:Arial;background:#eef4ff;}
.header{background:#0f3d91;color:white;padding:18px;text-align:center;font-size:28px;}
.container{
	width:420px;
	margin:60px auto;
	background:white;
	padding:35px;
	border-radius:15px;
	box-shadow:0 0 15px rgba(0,0,0,0.2);
	text-align:center;
}
input{
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
}
a{text-decoration:none;color:#0f3d91;}
</style>
</head>
<body>

<div class="header">TRANSFER MONEY</div>

<div class="container">
<form action="TransferServlet" method="post">
<input type="number" name="receiver_account" placeholder="Enter Receiver Account Number" required>
<input type="number" name="amount" placeholder="Enter Transfer Amount" required>
<button type="submit">Transfer Now</button>
</form>
<br>
<a href="dashboard.jsp">Back To Dashboard</a>
</div>

</body>
</html>