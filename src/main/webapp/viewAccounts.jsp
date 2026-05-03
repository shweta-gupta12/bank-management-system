<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.qspider.bank_management_system.util.JdbcConnection"%>
<%@page import="java.sql.Connection"%>
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
<title>All Bank Accounts</title>
<style>
body{
	font-family:Arial;
	background:#eef2ff;
	padding:30px;
}
h2{
	text-align:center;
	color:darkblue;
}
table{
	width:90%;
	margin:auto;
	border-collapse:collapse;
	background:white;
	box-shadow:0 0 10px gray;
}
th,td{
	border:1px solid #ddd;
	padding:12px;
	text-align:center;
}
th{
	background:darkblue;
	color:white;
}
tr:hover{
	background:#f1f1f1;
}
a{
	text-decoration:none;
	background:green;
	color:white;
	padding:10px 20px;
	border-radius:5px;
}
.back{
	text-align:center;
	margin-top:20px;
}
</style>
</head>
<body>

<h2>All Customer Bank Accounts</h2>

<table>
<tr>
	<th>Account Number</th>
	<th>User ID</th>
	<th>Account Type</th>
	<th>Balance</th>
</tr>

<%
Connection con = JdbcConnection.getJdbcConnection();

PreparedStatement ps = con.prepareStatement("select * from accounts order by account_id desc");
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
	<td><%=rs.getLong("account_number")%></td>
	<td><%=rs.getInt("user_id")%></td>
	<td><%=rs.getString("account_type")%></td>
	<td>₹ <%=rs.getDouble("balance")%></td>
</tr>

<%
}
%>

</table>

<div class="back">
<br><br>
<a href="adminDashboard.jsp">Back To Admin Dashboard</a>
</div>

</body>
</html>