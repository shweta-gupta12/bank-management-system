<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBI Bank Management System</title>
<style>
body{
    margin:0;
    font-family:Arial,sans-serif;
    background:linear-gradient(to right,#dbeafe,#eff6ff);
}
.header{
    background:#0f3d91;
    color:white;
    padding:20px;
    text-align:center;
    font-size:32px;
    font-weight:bold;
}
.container{
    width:420px;
    margin:90px auto;
    background:white;
    padding:40px;
    border-radius:18px;
    box-shadow:0 0 18px rgba(0,0,0,0.2);
    text-align:center;
}
h2{ color:#0f3d91; margin-bottom:30px; }
a{
    display:block;
    margin:15px 0;
    padding:14px;
    background:#0f3d91;
    color:white;
    text-decoration:none;
    border-radius:8px;
    font-size:18px;
}
a:hover{ background:#082b68; }
</style>
</head>
<body>

<div class="header">SBI BANK</div>
<div class="container">
<h2>Welcome To Secure Banking Portal</h2>
<a href="register.jsp">User Registration</a>
<a href="login.jsp">User Login</a>
<a href="adminLogin.jsp">Admin Login</a>
</div>

</body>
</html>