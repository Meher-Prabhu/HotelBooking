<%@ page import="database.Hotel"%>
<%@ page import="database.Account"%>
<%@	page import="java.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@	page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel</title>
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
	<%
		Hotel hotel = (Hotel) session.getAttribute("hotel_under_search");
			BigDecimal rating = (BigDecimal) session.getAttribute("rating");
			List<Object[]> room_type_list;
			if (session.getAttribute("room_type_availabilities") != null) {
				room_type_list = (List<Object[]>) session.getAttribute("room_type_availabilities");
			} else {
				room_type_list = new ArrayList<Object[]>();
			}
	%>
	<div id="wrapper" class="container">
		<div id="top">
			<div id="book" style="float: right; width: 43%;">
				<h4>Book rooms</h4>
				<form name="book" action="booking.jsp" method="post"
					class="form-vertical">
					<div class="form-group">
						<label> Room Type: </label> <select name="department"
							class="form-control">
							<%
								for (int i = 0; i < room_type_list.size(); i++) {
							%>
							<option>
								<%
									out.write(room_type_list.get(i)[0].toString());
								%>
							</option>
							<%
								}
							%>
						</select>
					</div>
					<div class="form-group">
						<label>Number of rooms : </label> <br> <input type="number"
							name="num_rooms" class="form-control">
					</div>
					<input class="btn btn-success" type="submit" name="book"
						value="Book "></input>
				</form>
			</div>
			<div id="availability" style="float: left; width: 47%;">
				<h1>
					<%
						out.print(hotel.get_name());
					%>
				</h1>
				<h4>
					Rating:
					<%
					out.print(rating);
				%>
				</h4>
				<h4>
					<%
						out.print(hotel.get_phone_number());
					%>
				</h4>
				<h4>
					<%
						out.print(hotel.get_area());
					%>
				</h4>
				<h4>
					<%
						out.print(hotel.get_city());
					%>
				</h4>
				<%
					if (session.getAttribute("currentUser") != null) {
							if (session.getAttribute("userRating") != null) {
				%>
				<h4>
					Your rating:
					<%
					out.print(session.getAttribute("userRating"));
				%>
				</h4>
				<%
					} else {
				%>
				<h4>Your rating:</h4>
				<form name="Rating" action="Hotelinfo" method="post" role="form">
					<input type="hidden" name="formName" value="rating"> <label
						class="radio-inline"><input type="radio" name="rating"
						value="0.5">0.5 </label> <label class="radio-inline"><input
						type="radio" name="rating" value="1.0">1.0 </label> <label
						class="radio-inline"><input type="radio" name="rating"
						value="1.5">1.5 </label> <label class="radio-inline"><input
						type="radio" name="rating" value="2.0">2.0 </label> <label
						class="radio-inline"><input type="radio" name="rating"
						value="2.5">2.5 </label> <label class="radio-inline"><input
						type="radio" name="rating" value="3.0">3.0 </label> <label
						class="radio-inline"><input type="radio" name="rating"
						value="3.5">3.5 </label> <label class="radio-inline"><input
						type="radio" name="rating" value="4.0">4.0 </label> <label
						class="radio-inline"><input type="radio" name="rating"
						value="4.5">4.5 </label> <label class="radio-inline"><input
						type="radio" name="rating" value="5.0">5.0 </label><br> <br>
					<input type="submit" name="rate" class="btn btn-info" value="Rate">
				</form>
				<%
					}
						}
				%>
				<br>
				<table class="table">
					<tr>
						<th>Type</th>
						<th>Available rooms</th>
						<th>Capacity</th>
						<%
							for (int i = 0; i < room_type_list.size(); i++) {
									out.print("<tr>");
									out.print("<td>" + room_type_list.get(i)[0].toString() + "</td>" + "<td>"
											+ room_type_list.get(i)[1].toString() + "</td>" + "<td>"
											+ room_type_list.get(i)[2].toString() + "</td>");
									out.print("</tr>");
								}
						%>
					
				</table>
			</div>
		</div>
		<br>
		<div id="bottom" style="float: left; clear: left">
			<h3>Reviews:</h3>
			<br>
			<%
				if (session.getAttribute("currentUser") != null && session.getAttribute("reviewed").equals(false)) {
			%>
			<h4>Add Review</h4>
			<form name="Review" action="Hotelinfo" method="post"
				class="form-inline">
				<input type="hidden" name="formName" value="review">
				<textarea placeholder="Write review" name="review"
					class="form-control"></textarea>
				<input type="submit" value="Review" class="btn btn-info">
			</form>
			<br>
			<%
				}
			%>
			<%
				List<Object[]> reviews = new ArrayList<Object[]>();
					List<Object[]> replies = new ArrayList<Object[]>();
					if (session.getAttribute("hotel_reviews") != null) {
						reviews = (List<Object[]>) session.getAttribute("hotel_reviews");
					}
					if (session.getAttribute("review_replies") != null) {
						replies = (List<Object[]>) session.getAttribute("review_replies");
					}
					Map<Object[], List<Object[]>> mapped_replies = new HashMap<Object[], List<Object[]>>();
					for (int i = 0; i < reviews.size(); i++) {
						String rev_id = reviews.get(i)[0].toString();
						List<Object[]> rev_replies = new ArrayList<Object[]>();
						for (int j = 0; j < replies.size(); j++) {
							if (rev_id.equals(replies.get(j)[0].toString())) {
								rev_replies.add(replies.get(j));
							}
						}
						mapped_replies.put(reviews.get(i), rev_replies);
					}
					for (int i = 0; i < reviews.size(); i++) {
						Object[] review = reviews.get(i);
						int id = Integer.valueOf(review[0].toString());
			%>
			<div class="panel panel-default">
				<div class="panel panel-heading">
					<h4>
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						<%
							out.print(review[1].toString());
						%>
					</h4>
				</div>
				<div class="panel panel-body">
					<%
						out.print(review[2].toString());
					%>
					<br> <br>
					<%
						if (session.getAttribute("currentUser") != null) {
					%>
					<form style="padding-left: 1em" name="Reply" action="Hotelinfo"
						method="post" class="form-inline">
						<input type="hidden" name="formName" value="reply"> <input
							type="hidden" name="rev_id" value=<%out.print(id);%>>
						<textarea class="form-control" placeholder="Write reply"
							name="reply"></textarea>
						<input type="submit" class="btn btn-info" value="Reply">
					</form>
					<br>
					<%
						}
					%>
					<%
						List<Object[]> rev_replies = mapped_replies.get(review);
								if (rev_replies.size() > 0) {
					%>

					<h4>Replies</h4>
					<%
						for (int j = 0; j < rev_replies.size(); j++) {
					%>

					<ul class="list-group">
						<li class="list-group-item disabled">
							<%
								out.print(rev_replies.get(j)[1].toString());
							%>
						</li>
						<li class="list-group-item" style="padding-left: 2em">
							<%
								out.print(rev_replies.get(j)[2].toString());
							%>
						</li>
						<%
							}
									}
						%>
					</ul>
				</div>
			</div>
			<%}
			%>

			<br>
			<p></p>
		</div>
	</div>

	<% } %>
</body>
</html>