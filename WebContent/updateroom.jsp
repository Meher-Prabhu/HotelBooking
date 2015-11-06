<%@page import="database.Hotelinfo"%>
<%@page import="database.Account"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update room</title>
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
<nav class = "navbar navbar-default">
<div class = "container-fluid">
<div class = "navbar-header">
<a class = "navbar-brand" href = "Homepage.jsp"> Hotel Booking </a>
</div>
<div>
<ul class = "nav navbar-nav navbar-right">
<li> <a href = "#"> Welcome <% out.write(((Account) session.getAttribute("currentUser")).get_name()); %> </a> </li>
<li> <a href = "Logout.jsp">Logout   </a> </li>
</ul>
</div>
</div>
</nav>
<div class = "container">
<form action="Hotelchanges" method="post" role = "form">
<h4>Enter room details to change:</h4> <br>
Room no. : <input type="text" name="room_id" value="" class = "form-control"><br>
Room type to change to : <select name="room_type" class = "form-control">
	<%List <String> roomtypeslist=Hotelinfo.getroomtypes(session);
		for(int i=0;i<roomtypeslist.size();i++)
			{%>
				<option value=<%out.write(roomtypeslist.get(i));%>><%out.write(roomtypeslist.get(i));%></option>
		 	<%}%>
	</select>
<br>
<input type="submit" name="Submit" value="Submit" class = "btn btn-success">
<br>
<% if(session.getAttribute("roompresent") == "false") {	%>
Room not present, enter correct room.
<% }}} %>

</form>
</div>
</body>
</html>