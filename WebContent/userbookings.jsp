<%@	page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Bookings</title>
</head>
<body>
<% List<Object[]> list = (List<Object[]>)session.getAttribute("bookings");

out.print("<table border='1' align='center'>");
out.print("<tr> <th>Booking_id</th> <th>Hotel Name </th> <th>Area</th> <th>City</th> <th>Start date</th> <th>End date</th> </tr>");
for (int i = 0; i < list.size(); i++) {
	out.print("<tr>");
	out.print("<td>" + list.get(i)[0].toString() + "</td>" + "<td>"
			+ list.get(i)[1].toString() + "</td>" + "<td>"+ list.get(i)[2].toString()+ "</td>"
			+ "<td>"+ list.get(i)[3].toString()+ "</td>" + "<td>"+ list.get(i)[4].toString()+ "</td>" + "<td>"+ list.get(i)[5].toString()+ "</td>");
	out.print("</tr>");
}
out.print("</table>");
%>
<br>
<a href = "Homepage.jsp"> Go to Homepage </a>
</body>
</html>