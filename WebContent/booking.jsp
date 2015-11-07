<%@ page import="database.Account"%>
<%@ page import="database.Hotel"%>
<%@	page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Booking Details</title>
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
			<%
				if (session.getAttribute("currentUser") != null && session.getAttribute("currentUser") != "") {
			%>
			<div>
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
	</div>
	</nav>
	<div class="container">
		<%
			Hotel hotel = (Hotel) session.getAttribute("hotel_under_search");
				Account sample_account = (Account) session.getAttribute("currentUser");
		%>

		<h3 style="text-align: center">Fill Details</h3>
		<form name="details" action="Bookinginfo" method="post" role="form"
			class="form-horizontal">

			<div class="form-group">
				<label class="col-sm-2 control-label">Name: </label>
				<div class="col-sm-6">
					<input type="text" name="name" class="form-control"
						value="
<%if (session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<%} else {%>
<%out.print(sample_account.get_name());%>
<%}%>
"></input>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label">Address: </label>
				<div class="col-sm-6">
					<input type="text" name="address" class="form-control"
						value="
<%if (session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<%} else {%>
<%out.print(sample_account.get_address());%>
<%}%>
"></input>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label">Contact number: </label>
				<div class="col-sm-6">
					<input type="text" name="contact_number" class="form-control"
						value="
<%if (session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<%} else {%>
<%out.print(sample_account.get_contact_number());%>
<%}%>
"></input>
				</div>
			</div>

			<%
				String start_date = (String) session.getAttribute("start_date");
					String end_date = (String) session.getAttribute("end_date");
			%>
			<div class="form-group">
				<label class="col-sm-2 control-label">Type of room: </label>
				<div class="col-sm-6">
					<input type="text" name="type_of_room" class="form-control"
						readonly
						value="<%out.print(request.getParameter("department"));%>">
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label">Number of rooms: </label>
				<div class="col-sm-6">
					<input type="number" name="num_rooms" class="form-control" readonly
						value="<%out.print(request.getParameter("num_rooms"));%>">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Start Date: </label>
				<div class="col-sm-6">
					<input type="date" class="form-control" readonly
						value="<%out.print((String) session.getAttribute("start_date"));%>">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">End Date: </label>
				<div class="col-sm-6">
					<input type="date" class="form-control" readonly
						value="<%out.print((String) session.getAttribute("end_date"));%>">
				</div>
			</div>
			<div class="col-sm-10" style="text-align: center">
				<input type="submit" class="btn btn-success"></input>
			</div>
		</form>
		<%
			}
		%>
	</div>
</body>
</html>