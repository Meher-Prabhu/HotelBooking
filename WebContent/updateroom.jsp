<%@page import="database.Hotelinfo"%>
<%@page import="database.SampleAccount"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<form action="Hotelchanges" method="post">
Enter room details to change: <br>
Room no. : <input type="text" name="room_id" value=""><br>
Room type to change to : <select name="room_type">
	<%List <String> roomtypeslist=Hotelinfo.getroomtypes(session);
		for(int i=0;i<roomtypeslist.size();i++)
			{%>
				<option value=<%out.write(roomtypeslist.get(i));%>><%out.write(roomtypeslist.get(i));%></option>
		 	<%}%>
	</select>
<br>
<input type="submit" name="Submit" value="Submit">
<br>
<% if(session.getAttribute("roompresent") == "false") {	%>
Room not present, enter correct room.
<% }}} %>

</form>
</body>
</html>