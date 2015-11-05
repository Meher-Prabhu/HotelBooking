<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.Account" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add your hotel</title>
<% if(session.getAttribute("currentUser") == null) {
	response.sendRedirect("Homepage.jsp");
}  
else {
	Account user = (Account) session.getAttribute("currentUser");
	if(user.get_type().equalsIgnoreCase("user") || user.get_type().equalsIgnoreCase("admin")) {
	response.sendRedirect("Homepage.jsp");
} else {
	%>
</head>
<body>
<h1>Add your hotel details</h1>
<form name = "hotelAdd" action = "Hotelchanges" method = "Post">
Hotel name*: <input type = "text" name = "name"> <br>
Area of hotel*: <input type = "text" name = "area"> <br>
City*: <input type = "text" name = "city"> <br>
Phone number*: <input type = "number" name = "phone"> <br>
Max booking period*: <input type = "number" name = "period"> <br>
<input type = "submit" value = "Add">
</form>
<% } } %>
</body>
</html>