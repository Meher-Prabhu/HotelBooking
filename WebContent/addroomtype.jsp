<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="database.Account"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Room Type</title>
<%
	if (session.getAttribute("currentUser") == null) {
		response.sendRedirect("Homepage.jsp");
	} else {
		Account user = (Account) session.getAttribute("currentUser");
		if (user.get_type().equalsIgnoreCase("user") || user.get_type().equalsIgnoreCase("admin")) {
			response.sendRedirect("Homepage.jsp");
		} else if (user.get_status().equalsIgnoreCase("pending")) {
			response.sendRedirect("Pending.jsp");
		} else {
%>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="Homepage.jsp"> Hotel Booking </a>
			</div>
			<div>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"> Welcome <%
						out.write(((Account) session.getAttribute("currentUser")).get_name());
					%>
					</a></li>
					<li><a href="Logout.jsp">Logout </a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<form action="Hotelchanges" method="post" role="form">
			<h4>Enter details of the new room type:</h4>
			<br> Room type name : <input type="text" name="room_type"
				value="" class="form-control"><br> Price : <input
				type="number" name="price" value="" class="form-control"><br>
			Capacity : <input type="number" name="capacity" value=""
				class="form-control"><br> Amenities provided in the
			room type (comma seperated, no spaces around commas) : <input
				type="text" name="amenities" value="" class="form-control"><br>
			<input type="submit" name="Submit" value="Submit"
				class="btn btn-success"> <br>
			<%
				if (session.getAttribute("roomtypepresent") == "true") {
			%>
			<div class="alert alert-danger" role="alert">
				<span class="glyphicon glyphicon-exclamation-sign"
					aria-hidden="true"></span> Roomtype already present , please enter
				a new roomtype.
			</div>
			<%
				session.setAttribute("roomtypepresent", "true");
						}
					}
				}
			%>


		</form>
	</div>
</body>
</html>