<%@	page import="java.util.*" %>
<%@ page import = "database.Account" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Profile</title>
<% boolean redirect = false;
	if(session.getAttribute("currentUser") != null) {
	Account user = (Account) session.getAttribute("currentUser");
	if(user.get_type().equalsIgnoreCase("hotel")) {
		redirect = true;
	}
	}
	if(redirect)
		response.sendRedirect("Hoteldetails.jsp");
 else if(session.getAttribute("currentUser") == null) {
	 response.sendRedirect("Homepage.jsp"); }
	 else {%>
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
<% if(((Account) session.getAttribute("currentUser")).get_type().equalsIgnoreCase("admin")) { %>
<li> <a href = "Adminlogin.jsp"> Requests </a> </li>
<% } %>  
<li> <a href = "userbookings.jsp"> Bookings </a> </li>
<li class = "active"> <a href = "userprofile.jsp"> Edit Profile </a> </li>
<li> <a href = "Logout.jsp">Logout   </a> </li>
</ul>
</div>
</div>
</nav> 
<% Account account = (Account)session.getAttribute("currentUser"); %>
<div class = "container">
<h2>Current Details:</h2> 
<p class = "lead"> Mail ID: <% out.print(account.get_mail_id()); %> <br> 
Name: <% out.print(account.get_name()); %> <br>
Contact Number: <% out.print(account.get_contact_number()); %> <br> 
Address: <% out.print(account.get_address()); %> </p>
<br>
<h2>Edit Profile: </h2>
<form action="Userprofile" method="post" role = "form">
<h4> Name: </h4> <input type="text" name="name" class = "form-control"></input><br>
<h4> Contact number: </h4> <input type="text" name="contact_number" class = "form-control"></input><br>
<h4> Address: </h4> <input type="text" name="address" class = "form-control"></input><br>
<h4> New Password for account: </h4> <input type="password" name="pass1" class = "form-control"></input><br>
<h4> Retype password: </h4> <input type="password" name="pass2" class = "form-control"></input><br>
<input type="submit" name="editprofile" class = "btn btn-success"></input><br>
</form>
<% if(session.getAttribute("error") == "Mismatch") {	%>
Passwords do not match
<% } session.setAttribute("error", "");%>
<br>
<a class = "lead" href = "Homepage.jsp"> Go to Homepage </a>
<% } %>
<br>
<p class = "lead">	</p>
</div>
</body>
</html>