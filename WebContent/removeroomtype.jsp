<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.Account" %> 
<%@page import="database.Hotelinfo"%>
<%@ page import="java.util.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
Enter the room type name to delete: 
<select name="room_type">
	<%List <String> roomtypeslist=Hotelinfo.getroomtypes(session);
		for(int i=0;i<roomtypeslist.size();i++)
			{%>
				<option value=<%out.write(roomtypeslist.get(i));%>><%out.write(roomtypeslist.get(i));%></option>
		 	<%}%>
	</select>
<input type="submit" name="Submit" value="Submit">
<br>

<%  } }%>

</form>

</body>
</html>