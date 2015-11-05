<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.SampleAccount" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% if(session.getAttribute("currentUser") == null) {
	response.sendRedirect("Homepage.jsp");
}
else {
SampleAccount user = (SampleAccount) session.getAttribute("currentUser");  
if(user.get_type().equalsIgnoreCase("user") || user.get_type().equalsIgnoreCase("admin")) {
	response.sendRedirect("Homepage.jsp");
} else {
	%>

</head>
<body>
Welcome ${currentUser.get_name() } | <a href = "Logout.jsp">Logout</a>
<br>
Select from one of the below actions you wish to perform.<br>
<form name="SeeBooking" action="Hotelchanges" method="post">
<input type="submit" name="see_booking" value="See the list of rooms booked through our interface"></input><br>
</form>
<form name="AddRoom" action="addroom.jsp" method="post">
<input type="submit" name="add_room" value="Add a room"></input><br>
</form>
<form name="UpdateRoom" action="updateroom.jsp" method="post">
<input type="submit" name="update_room" value="Update features of a room"></input><br>
</form>
<form name="RemoveRoom" action="removeroom.jsp" method="post">
<input type="submit" name="delete_room" value="Remove a room"></input><br>
</form>
<form name="AddRoomType" action="addroomtype.jsp" method="post">
<input type="submit" name="add_room_type" value="Add a new room type"></input><br>
</form>
<form name="UpdateRoomType" action="updateroomtype.jsp" method="post">
<input type="submit" name="update_room_type" value="Update details of an existing room type"></input><br>
</form>
<form name="RemoveRoomType" action="removeroomtype.jsp" method="post">
<input type="submit" name="remove_room_type" value="Remove an existing room type"></input><br>
</form>

<%}} %>

<% if(session.getAttribute("present") != null) { %>
	You already have a hotel.
	<% session.setAttribute("present",null);
	} %>

</body>
</html>