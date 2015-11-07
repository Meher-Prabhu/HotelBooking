<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="database.Hotelinfo"%>
<jsp:include page="header.jsp"></jsp:include>
<%@ page import="database.Account"%>
<%@ page import="java.util.*"%>
<%@ page session="true"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel Booking</title>
<script>
	function fillAreas() {
		var city = document.getElementsByName("city")[0].value;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4) {
				var data = xhttp.responseText;
				var areas = data.split(",");
				var options = '';
				for (var i = 0; i < areas.length; i++)
					options += '<option value = "' + areas[i] + '">';
				document.getElementsByName("area")[0].value = "";
				document.getElementById('areas').innerHTML = options;
			}
		}
		xhttp.open('GET', 'Hotelinfo', true);
		xhttp.setRequestHeader("city_name", city);
		xhttp.send(null);
	}
</script>
<%
	boolean redirect = false;
	if (session.getAttribute("currentUser") != null) {
		Account user = (Account) session.getAttribute("currentUser");
		if (user.get_type().equalsIgnoreCase("hotel")) {
			redirect = true;
		}
	}
	if (redirect)
		response.sendRedirect("Hoteldetails.jsp");
	else {
%>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="Homepage.jsp"> Hotel Booking </a>
			</div>
			<div>
				<%
					if (session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="Login.jsp"> Login </a></li>
					<li><a href="Signup.jsp"> Signup </a></li>
				</ul>
			</div>
		</div>
	</nav>
	<%
		} else {
	%>
	<ul class="nav navbar-nav navbar-right">
		<li><a href="#"> Welcome <%
			out.write(((Account) session.getAttribute("currentUser")).get_name());
		%>
		</a></li>
		<%
			if (((Account) session.getAttribute("currentUser")).get_type().equalsIgnoreCase("admin")) {
		%>
		<li><a href="Adminlogin.jsp"> Requests </a></li>
		<%
			}
		%>
		<li><a href="userbookings.jsp"> Bookings </a></li>
		<li><a href="userprofile.jsp"> Edit Profile </a></li>
		<li><a href="Logout.jsp">Logout </a></li>
	</ul>
	</div>
	</div>
	</nav>
	<%
		}
	%>
	<br>
	<br>
	<div class="container">
		<datalist id="cities">
			<%
				List<String> cities = Hotelinfo.getCities();
					for (int i = 0; i < cities.size(); i++) {
			%>
			<option value="<%out.print(cities.get(i));%>">
				<%
					}
				%>
			
		</datalist>
		<datalist id="areas">

		</datalist>

		<h3>Search for hotels:</h3>
		<form class="form-inline" name="Search" action="Hotelinfo"
			method="post" role="form">
			City: <input type="text" list="cities" name="city"
				onchange="fillAreas()" class="form-control"></input> Area: <input
				type="text" list="areas" name="area" class="form-control"></input><br>
			<br> Start date of booking: <input type="date" name="start_date"
				class="form-control"></input> End date of booking: <input
				type="date" name="end_date" class="form-control"></input><br> <br>
			<%
				if (session.getAttribute("empty_field") == "true") {
			%>
			Provide correct start,end dates
			<%
				}
			%>

			<input type="submit" class="btn btn-success" value="Search"></input>
		</form>
		<br>
		<form name="CancelBooking" action="CancelBooking.jsp">
			<input type="submit" name="cancel" class="btn btn-danger"
				value="Cancel a previous booking"></input>
		</form>
		<br>
	</div>
	<%
		}
	%>
</body>
</html>