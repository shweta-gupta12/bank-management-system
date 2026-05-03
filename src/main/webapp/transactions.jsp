<%@page import="com.qspider.bank_management_system.util.JdbcConnection"%>
<%@ page import="java.sql.*" %>

<%
HttpSession hs = request.getSession(false);

if(hs==null || hs.getAttribute("user_id")==null){
	response.sendRedirect("login.jsp");
	return;
}

int user_id = (int) hs.getAttribute("user_id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transaction History</title>

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
h2{
	text-align:center;
	color:#0f3d91;
	margin-top:30px;
}
table{
	width:92%;
	margin:30px auto;
	border-collapse:collapse;
	background:white;
	box-shadow:0 0 12px rgba(0,0,0,0.2);
}
th,td{
	border:1px solid #ddd;
	padding:12px;
	text-align:center;
}
th{
	background:#0f3d91;
	color:white;
}
tr:hover{
	background:#f1f5ff;
}
.back{
	text-align:center;
	margin:20px;
}
a{
	text-decoration:none;
	background:#0f3d91;
	color:white;
	padding:10px 20px;
	border-radius:6px;
}
</style>
</head>
<body>

<div class="header">CUSTOMER TRANSACTION HISTORY</div>

<h2>All Banking Transactions</h2>

<table>
<tr>
<th>Transaction ID</th>
<th>Account ID</th>
<th>Reference No</th>
<th>Type</th>
<th>Amount</th>
<th>Date</th>
</tr>

<%
Connection con = JdbcConnection.getJdbcConnection();

PreparedStatement ps1 = con.prepareStatement("select account_id from accounts where user_id=?");
ps1.setInt(1, user_id);
ResultSet rs1 = ps1.executeQuery();

int accountId = 0;
if(rs1.next()){
	accountId = rs1.getInt("account_id");
}

PreparedStatement ps = con.prepareStatement("select * from transactions where account_id=? order by transaction_id desc");
ps.setInt(1, accountId);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("transaction_id")%></td>
<td><%=rs.getInt("account_id")%></td>
<td><%=rs.getString("reference_no")%></td>
<td><%=rs.getString("type")%></td>
<td>₹ <%=rs.getDouble("amount")%></td>
<td><%=rs.getString("date")%></td>
</tr>

<%
}
%>

</table>

<div class="back">
<a href="dashboard.jsp">Back To Dashboard</a>
</div>

</body>
</html>