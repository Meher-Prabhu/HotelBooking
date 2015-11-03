<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Congratulations!!!</title>
</head>
<body>
	<h1> Congratulations!!!
	</h1>
	<br>
	You have successfully booked a room.<br>
	Your Booking Id is : <% out.print(session.getAttribute("booking_id"));%> <br>
	Please note your booking id for future referneces. <br>
	<a href = "Homepage.jsp"> Go to Homepage </a>
</body>
</html>