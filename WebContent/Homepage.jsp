<%@page import="database.Hotelinfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "database.SampleAccount" %>
<%@ page import = "java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel Booking</title>
<style>
body {text-align:center;}
</style>
<script>
function fillAreas() {
	var city = document.getElementsByName("city")[0].value;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if(xhttp.readyState == 4) {
			var data = xhttp.responseText;
			var areas = data.split(",");
			var options = '';
			for(var i = 0; i < areas.length; i++)
				options += '<option value = "' + areas[i] + '">';
			document.getElementById('areas').innerHTML = options;
		}
	}
	xhttp.open('GET','Hotelinfo',true);
	xhttp.setRequestHeader("city_name", city);
	xhttp.send(null);
}
</script>
</head>
<body>

<br>
<% if(session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<a href = "Login.jsp"> Login </a> | <a href = "Signup.jsp"> Signup </a> <br>
<% } else {  %>
<p> Welcome ${currentUser.get_name() } | <a href = "Logout.jsp">Logout</a> </p>
<form name="userbookings" action="Userprofile" method="post">
<input type="submit" name="userbookings" value="User previous bookings"></input>
</form><br>
<form name="editprofile" action="userprofile.jsp">
<input type="submit" name="editprofile" value="Edit Profile"></input>
</form>
<% } %>
<br>
<form name="CancelBooking" action="CancelBooking.jsp">
<input type="submit" name="cancel" value="Cancel a previous booking"></input>
</form>
<br><br>

<datalist id="cities">
<% List<String> cities = Hotelinfo.getCities();
	for(int i = 0; i < cities.size(); i++) {
		%> <option value = "<% out.print(cities.get(i)); %>">
	<% }
%>
</datalist>
<datalist id="areas">

</datalist>

Search for hotels: <br>
<form name="Search" action="Hotelinfo" method="post">
City: <input type = "text" list="cities" name="city" onchange="fillAreas()"></input><br>
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