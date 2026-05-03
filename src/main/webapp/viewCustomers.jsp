<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.qspider.bank_management_system.util.JdbcConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- View All Customers from Database -->
    
    <%
      HttpSession hs=request.getSession(false);
      
      if(hs==null || hs.getAttribute("admin")==null){
    	  response.sendRedirect("adminLogin.jsp");
    	  return;
      }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Customers</title>
<style>
body{margin:0;font-family:Arial;background:#eef4ff;}
.header{background:#0f3d91;color:white;padding:18px;text-align:center;font-size:28px;}
table{
	width:94%;
	margin:30px auto;
	border-collapse:collapse;
	background:white;
	box-shadow:0 0 12px rgba(0,0,0,0.2);
}
th,td{border:1px solid #ddd;padding:12px;text-align:center;}
th{background:#0f3d91;color:white;}
.back{text-align:center;margin:20px;}
a{text-decoration:none;background:#0f3d91;color:white;padding:10px 20px;border-radius:6px;}
</style>
</head>
<body>

<div class="header">ALL REGISTERED CUSTOMERS</div>

<table>
<tr>
<th>User ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
</tr>

<%
Connection con = JdbcConnection.getJdbcConnection();
PreparedStatement ps = con.prepareStatement("select * from users");
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>
<tr>
<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("phone")%></td>
</tr>
<% } %>

</table>

<div class="back">
<a href="adminDashboard.jsp">Back To Dashboard</a>
</div>
</body>
</html>