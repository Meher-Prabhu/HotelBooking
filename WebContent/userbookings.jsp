<%@	page import="java.util.*" %>
<%@ page import="database.Account" %>
<%@ page import="database.Userprofile" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Bookings</title>
<% boolean redirect = false;
	if(session.getAttribute("currentUser") != null) {
	Account user = (Account) session.getAttribute("currentUser");
	if(user.get_type().equalsIgnoreCase("hotel")) {
		redirect = true;
	}
	}
	if(redirect)
		response.sendRedirect("Hoteldetails.jsp");
 else if(session.getAttribute("currentUser") == null) {
	 response.sendRedirect("Homepage.jsp"); }
	 else {%>
</head>
<body>
<nav class = "navbar navbar-default">
<div class = "container-fluid">
<div class = "navbar-header">
<a class = "navbar-brand" href = "Homepage.jsp"> Hotel Booking </a>
</div>
<% if(session.getAttribute("currentUser") != null && session.getAttribute("currentUser") != "") { %>
<div>
<ul class = "nav navbar-nav navbar-right">
<li> <a href = "#"> Welcome <% out.write(((Account) session.getAttribute("currentUser")).get_name()); %> </a> </li>
<% if(((Account) session.getAttribute("currentUser")).get_type().equalsIgnoreCase("admin")) { %>
<li> <a href = "Adminlogin.jsp"> Requests </a> </li>
<% } %>  
<li class = "active"> <a href = "userbookings.jsp"> Bookings </a> </li>
<li> <a href = "userprofile.jsp"> Edit Profile </a> </li>
<li> <a href = "Logout.jsp">Logout   </a> </li>
</ul>
</div>
</div>
</nav> 
<% } %>
</div>
</nav>
<% Account user = (Account) session.getAttribute("currentUser");
List<Object[]> list = (List<Object[]>) Userprofile.getBookings(user.get_mail_id()); %>
<div class = "container">
<table class = "table" align="center">
<% out.print("<tr> <th>Booking_id</th> <th>Rooms</th> <th>Hotel Name </th> <th>Area</th> <th>City</th> <th>Start date</th> <th>End date</th> <th>Status</th></tr>");
for (int i = 0; i < list.size(); i++) {
	if(list.get(i)[7].toString().equalsIgnoreCase("cancelled")) { %>
		<tr class = "danger">
	<%} else if(list.get(i)[7].toString().equalsIgnoreCase("active")) {%>
		<tr class = "success">
	<% } else { %>
		<tr>
	<% }		
	out.print("<td>" + list.get(i)[0].toString() + "</td>" + "<td>"
			+ list.get(i)[1].toString() + "</td>" + "<td>"+ list.get(i)[2].toString()+ "</td>"
			+ "<td>"+ list.get(i)[3].toString()+ "</td>" + "<td>"+ list.get(i)[4].toString()+ "</td>" + "<td>"+ list.get(i)[5].toString()+ "</td>" + "<td>"+ list.get(i)[6].toString()+ "</td>" + "<td>"+ list.get(i)[7].toString()+ "</td>" );
	 %>
	 </tr>
<%}
%>
</table>
<br>
<a class = "lead" href = "Homepage.jsp"> Go to Homepage </a>
<% } %>
</div>
</body>
</html>