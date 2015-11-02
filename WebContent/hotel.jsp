<%@ page import="database.Hotel" %>
<%@	page import="java.util.*" %>
<%@	page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel</title>
</head>
<body>
<%
	Hotel hotel = (Hotel)session.getAttribute("hotel_under_search");
	List <Object[]> room_type_list;
	if(session.getAttribute("room_type_availabilities")!=null)
	 {room_type_list=(List<Object[]>)session.getAttribute("room_type_availabilities");}
	else {room_type_list=new ArrayList<Object[]>();} 
%>
<div id="top" style="float:top; height:50%;">
	<div id="availability" style="float:left; width:50%;">
	<h1><% out.print(hotel.get_name()); %> </h1>
	<% out.print(hotel.get_phone_number()); %><br>
	<% out.print(hotel.get_area()); %> <br>
	<% out.print(hotel.get_city()); %><br><br>
	<% 
	out.print("<table border='1'>");
	
	for(int i=0;i<room_type_list.size();i++) {
		out.print("<tr>");
		out.print("<td>"+room_type_list.get(i)[0].toString()+"</td>"+"<td>"+room_type_list.get(i)[1].toString()+"</td>");
		out.print("</tr>");}
	out.print("</table>");
	%>
	</div>
	<div id="book" style="float:right; width:50%;">
	<form name="book" action="Booking" method="post">
	Book for room type: 
	<select name="department" >
	<%
	for(int i=0;i<room_type_list.size();i++){%>
	<option> <%out.write(room_type_list.get(i)[0].toString());%> </option>
 	<%}%>
  </select>
  <br>
	Number of rooms : 	<input type="text" name="num_rooms" value=""><br>
	<input type="submit" name="book" value="Book "></input>
	</form>
	</div>
</div>
<div id="bottom" style="float:bottom; height:50%;">
Reply and comments section
</div>

	

</body>
</html>