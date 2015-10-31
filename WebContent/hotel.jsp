<%@ page import="database.Hotel" %>
<%@	page import="java.util.*" %>
<%@	page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Hotel hotel = (Hotel)session.getAttribute("hotel_under_search");
	List <Object[]> room_type_list = (List<Object[]>)session.getAttribute("room_type_availabilities");
%>
<div id="top" style="height:50%;">
	<div id="availability" style="float:left; width:50%;">
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
	Number of rooms : 	<input type="text" name="num_rooms" value=""><br>
	<input type="submit" name="book" value="Book "></input>
	</form>
	</div>
</div>
<div id="bottom">
Reply and comments section
</div>

	

</body>
</html>