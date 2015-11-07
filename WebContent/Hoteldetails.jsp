<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="database.Account"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel Details</title>
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
		<h4>Select one of the actions below</h4>
		<form name="SeeBooking" action="Hotelchanges" method="get">
			<input type="submit" name="see_booking" value="Bookings list"
				class="btn btn-info"></input>
		</form>
		<br> <a type="button" href="addroom.jsp" class="btn btn-success">Add
			a room</a><br> <br> <a type="button" href="addroomtype.jsp"
			class="btn btn-success">Add a new room type</a><br> <br> <a
			type="button" href="updateroom.jsp" class="btn btn-success">Update
			type of a room</a><br> <br> <a type="button"
			href="updateroomtype.jsp" class="btn btn-success">Update an
			existing room type</a><br> <br> <a type="button"
			href="removeroom.jsp" class="btn btn-danger">Remove a room</a><br>
		<br> <a type="button" href="removeroomtype.jsp"
			class="btn btn-danger">Remove a room type</a><br> <br>

		<%
			}
			}
		%>

		<%
			if (session.getAttribute("present") != null) {
		%>
		You already have a hotel.
		<%
			session.setAttribute("present", null);
			}
		%>
	</div>
</body>
</html>