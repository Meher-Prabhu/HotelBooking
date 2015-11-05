<%@	page import="java.util.*" %>
<%@ page import = "database.Account" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<% Account account = (Account)session.getAttribute("currentUser"); %>
<h2>Current Details:</h2> 
Mail ID: <% out.print(account.get_mail_id()); %> <br>
Name: <% out.print(account.get_name()); %><br>
Contact Number: <% out.print(account.get_contact_number()); %><br>
Address: <% out.print(account.get_address()); %>
<br>
<h2>Edit Profile: </h2>
<form action="Userprofile" method="post">
Name: <input type="text" name="name"></input><br>
Contact number: <input type="text" name="contact_number"></input><br>
Address: <input type="text" name="address"></input><br>
New Password for account: <input type="password" name="pass1"></input><br>
Retype password: <input type="password" name="pass2"></input><br>
<input type="submit" name="editprofile"></input><br>
</form>
<% if(session.getAttribute("error") == "Mismatch") {	%>
Passwords same daal chutiye
<% } session.setAttribute("error", "");%>
<a href = "Homepage.jsp"> Go to Homepage </a>
<% } %>
</body>
</html>