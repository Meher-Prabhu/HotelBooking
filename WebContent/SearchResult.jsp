<%@page import="database.Hotelinfo"%>
<%@ page import="database.Account"%>
<%@page import="database.Hotel"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search results</title>
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
	<div id="filter" style="float: left; width: 22%;"
		class="container-fluid">
		<form name="searchresult" action="Hotelinfo" method="post" role="form">
			<h4>Filters:</h4>
			Rating : <select name="rating" class="form-control">
				<option value="0"
					<%if (session.getAttribute("searchrating") != null) {
					if ((Integer) session.getAttribute("searchrating") == 0) {%>
					selected <%;
					}
				}%>>Any</option>
				<option value="1"
					<%if (session.getAttribute("searchrating") != null) {
					if ((Integer) session.getAttribute("searchrating") == 1) {%>
					selected <%;
					}
				}%>>1 and above</option>
				<option value="2"
					<%if (session.getAttribute("searchrating") != null) {
					if ((Integer) session.getAttribute("searchrating") == 2) {%>
					selected <%;
					}
				}%>>2 and above</option>
				<option value="3"
					<%if (session.getAttribute("searchrating") != null) {
					if ((Integer) session.getAttribute("searchrating") == 3) {%>
					selected <%;
					}
				}%>>3 and above</option>
				<option value="4"
					<%if (session.getAttribute("searchrating") != null) {
					if ((Integer) session.getAttribute("searchrating") == 4) {%>
					selected <%;
					}
				}%>>4 and above</option>
				<option value="5"
					<%if (session.getAttribute("searchrating") != null) {
					if ((Integer) session.getAttribute("searchrating") == 5) {%>
					selected <%;
					}
				}%>>5 and above</option>
			</select> <br> Budget(cost in rupees per day) : <select name="budget"
				class="form-control">
				<option value="1000"
					<%if (session.getAttribute("budget") != null) {
					if ((Integer) session.getAttribute("budget") == 1000) {%>
					selected <%;
					}
				}%>>Under 1000</option>
				<option value="2000"
					<%if (session.getAttribute("budget") != null) {
					if ((Integer) session.getAttribute("budget") == 2000) {%>
					selected <%;
					}
				}%>>Under 2000</option>
				<option value="3000"
					<%if (session.getAttribute("budget") != null) {
					if ((Integer) session.getAttribute("budget") == 3000) {%>
					selected <%;
					}
				}%>>Under 3000</option>
				<option value="4000"
					<%if (session.getAttribute("budget") != null) {
					if ((Integer) session.getAttribute("budget") == 4000) {%>
					selected <%;
					}
				}%>>Under 4000</option>
				<option value="5000"
					<%if (session.getAttribute("budget") == null) {%> selected
					<%;
				}
				if (session.getAttribute("budget") != null) {
					if ((Integer) session.getAttribute("budget") == 5000) {%>
					selected <%;
					}
				}%>>Under 5000</option>

			</select> <br> Amenities : <br>
			<%
				List<String> amenitieslist = Hotelinfo.getamenities();
					for (int i = 0; i < amenitieslist.size(); i++) {
			%><div class="checkbox">
				<label> <input type="checkbox" name="amenities"
					value="<%out.write(amenitieslist.get(i));%>"
					<%if (session.getAttribute("amenitiesselected") != null) {
						if (((List<String>) session.getAttribute("amenitiesselected")).contains(amenitieslist.get(i))) {%>
					checked <%;
						}
					}%>> <%
 	out.write(amenitieslist.get(i));
 %><br>
				</label>
			</div>
			<%
				}
			%>
			<input type="submit" name="getlisthotels" class="btn btn-info"
				value="Filter"></input><br> <br>
			<%
				if (session.getAttribute("missing_input") == "true") {
			%>
			Please fill in the checkboxes.
			<%
				}
			%>
		
	</div>

	<div class="container-fluid">
		<div id="result" style="float: right; width: 73%;">
			<h4>Results:</h4>

			<%
				if (session.getAttribute("hotel_search_results") != null) {
						List<Object[]> hotellist = (List<Object[]>) session.getAttribute("hotel_search_results"); //we are supposed to get this list from Hotel.java servlet
						for (int i = 0; i < hotellist.size(); i++) {
			%>
			<div class="radio">
				<label> <input type="radio" name="option"
					value=<%out.write(hotellist.get(i)[0].toString());%>> <%
 	out.write(hotellist.get(i)[1].toString());
 %> <br>
				</label>
			</div>
			<%}}%>

			<br> <input type="submit" name="gethotel"
				class="btn btn-success" value="Proceed"></input>
		</div>

		</form>
	</div>
	<% } %>
</body>
</html>