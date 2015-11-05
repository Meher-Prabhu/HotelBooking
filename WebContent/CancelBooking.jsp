<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.SampleAccount" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cancel Booking</title>
<% boolean redirect = false;
	if(session.getAttribute("currentUser") != null) {
	SampleAccount user = (SampleAccount) session.getAttribute("currentUser");
	if(user.get_type().equalsIgnoreCase("hotel")) {
		redirect = true;
	}
	}
	if(redirect)
		response.sendRedirect("Hoteldetails.jsp");
 else { %>
</head>
<body>
<form action = "Bookinginfo" method = "post">
Booking ID: <input type = "text" name = "booking_id"> <br>
<input type = "submit" value = "Cancel Booking">
</form>
<% } %>
</body>
</html>