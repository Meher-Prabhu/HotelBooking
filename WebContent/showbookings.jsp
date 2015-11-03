<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@	page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

List<Object[]> bookinglist;
if (session.getAttribute("bookings") != null) {
	bookinglist = (List<Object[]>) session.getAttribute("bookings");
} else {
	bookinglist = new ArrayList<Object[]>();}
					out.print("<table border='1' align='center'>");
					out.print("<tr> <th>Booking_id</th> <th>Name </th> <th>Room_id</th> <th>Start date</th> <th>End date</th> </tr>");
					for (int i = 0; i < bookinglist.size(); i++) {
						out.print("<tr>");
						out.print("<td>" + bookinglist.get(i)[0].toString() + "</td>" + "<td>"
								+ bookinglist.get(i)[1].toString() + "</td>" + "<td>"+ bookinglist.get(i)[2].toString()+ "</td>"
								+ "<td>"+ bookinglist.get(i)[3].toString()+ "</td>" + "<td>"+ bookinglist.get(i)[4].toString()+ "</td>");
						out.print("</tr>");
					}
					out.print("</table>");
%>
</body>
</html>