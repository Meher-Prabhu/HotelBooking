<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="database.Account"%>
<%@page import="database.Hotelinfo"%>
<%@ page import="java.util.*"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html >
<html>
<head>
<title>Update Room Type</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		<form action="Hotelchanges" method="post">
			<h4>Enter details of the room type to update:</h4>
			<br> Room type name : <select name="room_type"
				class="form-control">
				<%
					List<String> roomtypeslist = Hotelinfo.getroomtypes(session);
							for (int i = 0; i < roomtypeslist.size(); i++) {
				%>
				<option value=<%out.write(roomtypeslist.get(i));%>>
					<%
						out.write(roomtypeslist.get(i));
					%>
				</option>
				<%
					}
				%>
			</select><br> Price : <input type="number" name="price" value=""
				class="form-control"><br> Capacity : <input
				type="number" name="capacity" value="" class="form-control"><br>
			<input type="submit" name="Submit" value="Submit"
				class="btn btn-success">
			<%
				}
				}
			%>
		</form>
	</div>
</body>
</html>