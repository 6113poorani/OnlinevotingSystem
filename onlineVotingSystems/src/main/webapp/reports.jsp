<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
<td>Candidate Name</td>
<td>Party Name</td>
<td>Taluk Name</td>
<td>Ward No</td>
<td>Total Votes</td>
</tr>
<tr>
<%@ page import="admin.Excel"  %>
<%@ page import="java.util.*"  %>
<%
response.setContentType("application/vmd.ms-excel");
response.setHeader("Content-Disposition","inline;filename=report.xls");
ArrayList<Excel> excels=(ArrayList<Excel>) session.getAttribute("exl");
	for(Excel ex:excels){%>
		<td><%= ex.getCandidate_Name() %></td>
		<td><%= ex.getParty_Name() %></td>
		<td><%= ex.getTaluk_Name() %></td>
		<td><%= ex.getWard_No() %></td>  
		<td><%= ex. getTotal_votes() %></td>
		
		</tr>
	
<% }%>
</table>

</body>
</html>