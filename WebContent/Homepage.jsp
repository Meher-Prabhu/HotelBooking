<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel Booking</title>
<style>
body {text-align:center;}
</style>
</head>
<body>

<br>
<% String user = ""; 
if(session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<a href = "Login.jsp"> Login </a> | <a href = "Signup.jsp"> Signup </a>
<% } else { user = session.getAttribute("currentUser").toString(); %>
Welcome <%= user %>
<% } %>
<br><br>
<form name="CancelBooking" action="CancelBooking.java" method="post">
<input type="submit" name="cancel" value="Cancel a previous booking"></input>
</form>
<br><br>

<datalist id="cities">

</datalist>
<datalist id="areas">

</datalist>

Search for hotels: <br>
<form name="Search" action="Hotelinfo.java" method="post">
City: <input type="text" list="cities" name="city"></input><br>
Area: <input type="text" list="areas" name="area"></input><br>
Date of booking: <input type="text" name="date"></input><br>
<input type="submit" ></input>
</form>

</body>
</html>