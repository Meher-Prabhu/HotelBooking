<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="database.Account" %> 
   <%@page import="database.Hotelinfo"%>
<%@ page import="java.util.*" %> 
<!DOCTYPE html >
<html>
<head>
<title>Add Room Type</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% if(session.getAttribute("currentUser") == null) {
	response.sendRedirect("Homepage.jsp");
}
else {
Account user = (Account) session.getAttribute("currentUser");  
if(user.get_type().equalsIgnoreCase("user") || user.get_type().equalsIgnoreCase("admin")) {
		response.sendRedirect("Homepage.jsp");
	} else if(user.get_status().equalsIgnoreCase("pending")){
		response.sendRedirect("Pending.jsp");
	} else {
	%>
</head>
<body>
<form action="Hotelchanges" method="post">
Enter details of the room type to update: <br>
Room type name : <select name="room_type">
	<%List <String> roomtypeslist=Hotelinfo.getroomtypes(session);
		for(int i=0;i<roomtypeslist.size();i++)
			{%>
				<option value=<%out.write(roomtypeslist.get(i));%>><%out.write(roomtypeslist.get(i));%></option>
		 	<%}%>
	</select>
Price : <input type="number" name="price" value=""><br>
Capacity : <input type="number" name="capacity" value=""><br>
<input type="submit" name="Submit" value="Submit">
<%  } }%>
</form>

</body>
</html>