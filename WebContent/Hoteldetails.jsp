<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
Welcome ${currentUser.get_name() } | <a href = "Logout.jsp">Logout</a> </p>
<br>
Select from one of the below actions you wish to perform.<br>
<form name="SeeBooking" action="Hotelchanges">
<input type="submit" name="see_booking" value="See the list of rooms booked through our interface"></input><br>
</form>
<form name="AddRoom" action="addroom.jsp">
<input type="submit" name="add_room" value="Add a room"></input><br>
</form>
<form name="UpdateRoom" action="updateroom.jsp">
<input type="submit" name="update_room" value="Update features of a room"></input><br>
</form>
<form name="RemoveRoom" action="removeroom.jsp">
<input type="submit" name="delete_room" value="Remove a room"></input><br>
</form>


</body>
</html>