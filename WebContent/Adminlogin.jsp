<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.Account" %>
<%@ page import="database.Hotel" %>
<%@ page import="database.Admin" %>
<%@ page import="java.util.*" %>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin login</title>
<% if(session.getAttribute("currentUser") == null) {
	response.sendRedirect("Homepage.jsp");
} else {
	Account login = (Account) session.getAttribute("currentUser");
	if(login.get_type().equalsIgnoreCase("hotel")) {
		response.sendRedirect("Hoteldetails.jsp");
	} else if(login.get_type().equalsIgnoreCase("user")) {
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
<li class = "active"> <a href = "Adminlogin.jsp"> Requests </a> 
<li> <a href = "userbookings.jsp"> Bookings </a> </li>
<li> <a href = "userprofile.jsp"> Edit Profile </a> </li>
<li> <a href = "Logout.jsp">Logout   </a> </li>
</ul>
</div>
</div>
</nav> 
</div>
</nav>
<% List<Hotel> hotels = Admin.appHotels(); 
   List<Account> accounts = Admin.appAccounts(); %>
<div class = "container">  
<h3> Hotel requests: </h3><br>
<table class = "table table-striped">
<tr><th>Hotel Name</th><th>Area</th><th>City</th><th>Mail ID</th><th>Approve</th><th>Reject</th></tr>
<% for(int i = 0; i < hotels.size(); i++) { %>
<% Hotel hotel = hotels.get(i); 
	int id = hotel.get_id(); %>
<tr><td><% out.write(hotel.get_name()); %></td><td><% out.write(hotel.get_area()); %></td>
	<td><% out.write(hotel.get_city()); %></td>
	<td><% out.write(hotel.get_mail_id()); %></td><td>
	<form action = "Admin" method = "Post">
	<input type = "hidden" name = "id" value = "<% out.write(String.valueOf(id)); %>">
	<input type = "hidden" name = "formName" value = "hotelApproval">
	<input type = "submit" class = "btn btn-success" value = "Approve Hotel">
	</form>
	</td><td>
	<form action = "Admin" method = "Post">
	<input type = "hidden" name = "id" value = "<% out.write(String.valueOf(id)); %>">
	<input type = "hidden" name = "formName" value = "hotelReject">
	<input type = "submit" class = "btn btn-danger" value = "Reject Hotel">
	</form>
	</td>
	</tr>
<% } %>
</table><br>
<h3> Hotel account requests:</h3><br>
<table class = "table table-striped">
<tr><th>Mail ID</th><th>Name</th><th>Approve</th><th>Reject</th></tr>
<% for(int i = 0; i < accounts.size(); i++) { %>
<% Account account = accounts.get(i); %>
<tr><td><% out.write(account.get_mail_id()); %></td><td><% out.write(account.get_name()); %></td>
	<td><form action = "Admin" method = "Post">
	<input type = "hidden" name = "id" value = "<% out.write(account.get_mail_id()); %>">
	<input type = "hidden" name = "formName" value = "accountApproval">
	<input type = "submit" class = "btn btn-success" value = "Approve Account">
	</form>
	</td>
	<td><form action = "Admin" method = "Post">
	<input type = "hidden" name = "id" value = "<% out.write(account.get_mail_id()); %>">
	<input type = "hidden" name = "formName" value = "accountReject">
	<input type = "submit" class = "btn btn-danger" value = "Reject Account">
	</form>
	</td>
	</tr>
<% } %>
</table><br>
<% } } %>
</div>
</body>
</html>