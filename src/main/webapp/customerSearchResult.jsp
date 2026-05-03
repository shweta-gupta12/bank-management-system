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
<title>Customer Details</title>
<style>
body{margin:0;font-family:Arial;background:#eef4ff;}
.header{background:#0f3d91;color:white;padding:18px;text-align:center;font-size:28px;}
.card{
	width:450px;
	margin:70px auto;
	background:white;
	padding:35px;
	border-radius:15px;
	box-shadow:0 0 15px rgba(0,0,0,0.2);
}
p{font-size:18px;margin:15px 0;}
h2{text-align:center;color:#0f3d91;}
.center{text-align:center;margin-top:20px;}
a{text-decoration:none;background:#0f3d91;color:white;padding:10px 20px;border-radius:6px;}
</style>
</head>
<body>

<div class="header">CUSTOMER ACCOUNT DETAILS</div>

<div class="card">
<h2>Search Result</h2>

<p><b>Name:</b> <%=request.getAttribute("name") %></p>
<p><b>Email:</b> <%=request.getAttribute("email") %></p>
<p><b>Phone:</b> <%=request.getAttribute("phone") %></p>
<p><b>Account Number:</b> <%=request.getAttribute("account_number") %></p>
<p><b>Account Type:</b> <%=request.getAttribute("account_type") %></p>
<p><b>Available Balance:</b> ₹ <%=request.getAttribute("balance") %></p>

<div class="center">
<a href="adminDashboard.jsp">Back To Dashboard</a>
</div>
</div>

</body>
</html>