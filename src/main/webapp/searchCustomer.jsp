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
<title>Search Customer</title>
<style>
body{margin:0;font-family:Arial;background:#eef4ff;}
.header{background:#0f3d91;color:white;padding:18px;text-align:center;font-size:28px;}
.container{
	width:400px;
	margin:100px auto;
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

<div class="header">SEARCH CUSTOMER ACCOUNT</div>

<div class="container">
<form action="SearchCustomerServlet" method="post">
<input type="number" name="account_number" placeholder="Enter Account Number" required>
<button type="submit">Search Customer</button>
</form>
<br>
<a href="adminDashboard.jsp">Back To Dashboard</a>
</div>

</body>
</html>