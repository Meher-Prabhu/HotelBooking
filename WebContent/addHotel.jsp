<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.Account" %>
<jsp:include page="header.jsp"></jsp:include>
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
<nav class = "navbar navbar-default">
<div class = "container-fluid">
<div class = "navbar-header">
<a class = "navbar-brand" href = "Homepage.jsp"> Hotel Booking </a>
</div>
<div>
<ul class = "nav navbar-nav navbar-right">
<li> <a href = "#"> Welcome <% out.write(((Account) session.getAttribute("currentUser")).get_name()); %> </a> </li>
<li> <a href = "Logout.jsp">Logout   </a> </li>
</ul>
</div>
</div>
</nav>
<div class = "container">
<h1>Add your hotel details</h1>
<form name = "hotelAdd" action = "Hotelchanges" method = "Post" role = "form">
Hotel name*: <input type = "text" name = "name" class = "form-control"> <br>
Area of hotel*: <input type = "text" name = "area" class = "form-control"> <br>
City*: <input type = "text" name = "city" class = "form-control"> <br>
Phone number*: <input type = "number" name = "phone" class = "form-control"> <br>
Max booking period*: <input type = "number" name = "period" class = "form-control"> <br>
<input type = "submit" value = "Add" class = "btn btn-success">
</form>
<% } } %>
</div>
</body>
</html>