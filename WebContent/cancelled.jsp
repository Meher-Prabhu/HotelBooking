<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.Account" %>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cancelled!!</title>
<% boolean redirect = false;
	if(session.getAttribute("currentUser") != null) {
	Account user = (Account) session.getAttribute("currentUser");
	if(user.get_type().equalsIgnoreCase("hotel")) {
		redirect = true;
	}
	}
	if(redirect)
		response.sendRedirect("Hoteldetails.jsp");
 else { %>
</head>
<body>
<nav class = "navbar navbar-default">
<div class = "container-fluid">
<div class = "navbar-header">
<a class = "navbar-brand" href = "Homepage.jsp"> Hotel Booking </a>
</div>
<% if(session.getAttribute("currentUser") != null && session.getAttribute("currentUser") != "") { %>
<div>
<ul class = "nav navbar-nav navbar-right">
<li> <a href = "#"> Welcome <% out.write(((Account) session.getAttribute("currentUser")).get_name()); %> </a> </li>
<% if(((Account) session.getAttribute("currentUser")).get_type().equalsIgnoreCase("admin")) { %>
<li> <a href = "Adminlogin.jsp"> Requests </a> </li>
<% } %>  
<li> <a href = "userbookings.jsp"> Bookings </a> </li>
<li> <a href = "userprofile.jsp"> Edit Profile </a> </li>
<li> <a href = "Logout.jsp">Logout   </a> </li>
</ul>
</div>
</div>
</nav> 
<% } %>
</div>
</nav>
<div class = "container">
	<h1> Cancelled!!!
	</h1>
	<br>
	<p class = "lead">We have successfully cancelled your booking of the room.<br>
	<a href = "Homepage.jsp"> Go to Homepage </a> </p>
<% } %>
</div>
</body>
</html>