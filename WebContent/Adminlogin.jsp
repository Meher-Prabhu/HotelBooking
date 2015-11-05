<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.Account" %>
<%@ page import="database.Hotel" %>
<%@ page import="database.Admin" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<% String user = ((Account) session.getAttribute("currentUser")).get_name(); %>
Welcome <% out.write(user); %>|<a href = "Logout.jsp">Logout</a> <br>
<% List<Hotel> hotels = Admin.appHotels(); 
   List<Account> accounts = Admin.appAccounts(); %>
Hotel requests:<br>
<table border = '1' align = 'center'>
<tr><th>Hotel Name</th><th>Area</th><th>City</th><th>Mail ID</th><th>Approve</th></tr>
<% for(int i = 0; i < hotels.size(); i++) { %>
<% Hotel hotel = hotels.get(i); 
	int id = hotel.get_id(); %>
<tr><td><% out.write(hotel.get_name()); %></td><td><% out.write(hotel.get_area()); %></td>
	<td><% out.write(hotel.get_city()); %></td>
	<td><% out.write(hotel.get_mail_id()); %></td><td>
	<form action = "Admin" method = "Post">
	<input type = "hidden" name = "id" value = "<% out.write(String.valueOf(id)); %>">
	<input type = "hidden" name = "formName" value = "hotelApproval">
	<input type = "submit" value = "Approve Hotel">
	</form>
	</td></tr>
<% } %>
</table><br>
Hotel account requests:<br>
<table border = '1' align = 'center'>
<tr><th>Mail ID</th><th>Name</th><th>Approve</th></tr>
<% for(int i = 0; i < accounts.size(); i++) { %>
<% Account account = accounts.get(i); %>
<tr><td><% out.write(account.get_mail_id()); %></td><td><% out.write(account.get_name()); %></td>
	<td><form action = "Admin" method = "Post">
	<input type = "hidden" name = "id" value = "<% out.write(account.get_mail_id()); %>">
	<input type = "hidden" name = "formName" value = "accountApproval">
	<input type = "submit" value = "Approve Account">
	</form>
	</td></tr>
<% } %>
</table><br>
<% } } %>
</body>
</html>