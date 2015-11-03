<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="Hotelchanges" method="post">
Enter details of the new room type: <br>
Room type name : <input type="text" name="room_type" value=""><br>
Price : <input type="number" name="price" value=""><br>
Capacity : <input type="number" name="capacity" value=""><br>
Amenities provided in the room type (comma seperated) : <input type="text" name="amenities" value=""><br>
<input type="submit" name="Submit" value="Submit">
<br>
<% if(session.getAttribute("roomtypepresent") == "true") {	%>
Roomtype already present , please enter a new roomtype.
<% } %>


</form>
</body>
</html>