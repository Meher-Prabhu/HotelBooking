<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "database.SampleAccount"%>    
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
if(user.get_type() != "hotel") {
	response.sendRedirect("Homepage.jsp");
} else {
	%>
</head>
<body>
<form action="Hotelchanges" method="post">
Enter room no. to remove : <input type="text" name="room_id" value=""><br>
<input type="submit" name="Submit" value="Submit">
<br>
<% if(session.getAttribute("roompresent") == "false") {	%>
Room not present , please enter correct room.
<% }} } %>

</form>

</body>
</html>