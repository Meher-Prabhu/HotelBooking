<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "database.SampleAccount" %>
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
<% } else {  %>
<p> Welcome ${currentUser.get_name() } </p>
<% } %>
<br><br>
<form name="CancelBooking" action="CancelBooking.jsp">
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
Start date of booking: <input type="date" name="start_date"></input><br>
End date of booking: <input type="date" name="end_date"></input><br>
<br>
<% if(session.getAttribute("empty_field")=="true") {%>
Provide correct start,end dates
<%} %>

<input type="submit" ></input>
</form>

</body>
</html>