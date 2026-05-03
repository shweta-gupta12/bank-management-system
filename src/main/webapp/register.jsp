<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration-Form</title>

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
.container{
    width:420px;
    margin:50px auto;
    background:white;
    padding:35px;
    border-radius:15px;
    box-shadow:0 0 15px rgba(0,0,0,0.2);
    text-align:center;
}
input{
    width:90%;
    padding:12px;
    margin:10px;
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
    font-size:17px;
}
a{ text-decoration:none; color:#0f3d91; }
</style>
</head>
<body>
<div class="header">SBI BANK USER REGISTRATION</div>
<div class="container">
<h2>Create Customer Profile</h2>
<form action="RegisterServletController" method="post">
<input type="text" name="name" placeholder="Enter Full Name" required>
<input type="email" name="email" placeholder="Enter Email" required>
<input type="password" name="password" placeholder="Enter Password" required>
<input type="text" name="phone" placeholder="Enter Phone Number" required>
<button type="submit">Register</button>
</form>
<br>
<a href="login.jsp">Already Registered? Login</a><br><br>
<a href="index.jsp">Back To Home</a>
</div>
</body>
</html>