<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.*"%>
<%@ page import="database.Account"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel's bookings</title>
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
		<%
			List<Object[]> bookinglist;
					if (session.getAttribute("bookings") != null) {
						bookinglist = (List<Object[]>) session.getAttribute("bookings");
					} else {
						bookinglist = new ArrayList<Object[]>();
					}
		%>
		<table class="table table-striped">
			<%
				out.print(
								"<tr> <th>Booking_id</th> <th>Name </th> <th>Room_id</th> <th>Start date</th> <th>End date</th> </tr>");
						for (int i = 0; i < bookinglist.size(); i++) {
							out.print("<tr>");
							out.print("<td>" + bookinglist.get(i)[0].toString() + "</td>" + "<td>"
									+ bookinglist.get(i)[1].toString() + "</td>" + "<td>" + bookinglist.get(i)[2].toString()
									+ "</td>" + "<td>" + bookinglist.get(i)[3].toString() + "</td>" + "<td>"
									+ bookinglist.get(i)[4].toString() + "</td>");
							out.print("</tr>");
						}
			%>
			<%
				}
				}
			%>
		</table>
		<a class="lead" href="Hoteldetails.jsp">Go to homepage</a>
	</div>
</body>
</html>