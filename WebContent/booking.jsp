<%@ page import="database.SampleAccount" %>
<%@ page import="database.Hotel" %>
<%@	page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Booking Details</title>
<% boolean redirect = false;
	if(session.getAttribute("currentUser") != null) {
	SampleAccount user = (SampleAccount) session.getAttribute("currentUser");
	if(user.get_type().equalsIgnoreCase("hotel")) {
		redirect = true;
	}
	}
	if(redirect)
		response.sendRedirect("Hoteldetails.jsp");
 else { %>
</head>
<body>
<% Hotel hotel = (Hotel)session.getAttribute("hotel_under_search");
SampleAccount sample_account = (SampleAccount)session.getAttribute("currentUser");%>

<form name="details" action="Bookinginfo" method="post">

Name: <input type="text" name="name" value="
<% if(session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<% } else {  %>
<% out.print(sample_account.get_address()); %>
<% } %>
"></input><br>

Address: <input type="text" name="address" value="
<% if(session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<% } else {  %>
<% out.print(sample_account.get_name()); %>
<% } %>
"></input><br>

Contact Number: <input type="text" name="contact_number" value="
<% if(session.getAttribute("currentUser") == null || session.getAttribute("currentUser") == "") {%>
<% } else {  %>
<% out.print(sample_account.get_contact_number()); %>
<% } %>
"></input><br>

<%	
	String start_date = (String)session.getAttribute("start_date");
	String end_date = (String)session.getAttribute("end_date");
%>

Type of Room: <input type="text" name="type_of_room" value="<% out.print(request.getParameter("department")); %>"><br>
Number of rooms : 	<input type="number" name="num_rooms" value="<% out.print(request.getParameter("num_rooms")); %>"><br>
Start Date: <% out.print((String)session.getAttribute("start_date")); %> <br>
End Date: <% out.print((String)session.getAttribute("end_date")); %> <br>
<input type="submit" ></input>
</form>
<% } %>
</body>
</html>