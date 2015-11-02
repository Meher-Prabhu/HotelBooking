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
<div id = "wrapper">
<div id="top" >
	<div id="book" style="float:right; width:50%;">
	<form name="book" action="booking.jsp" method="post">
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
</div>
<br>
<div id="bottom" style="float:left; clear:left">
<br>
Reviews:
<br>
<br>
<% List<Object[]> reviews = new ArrayList<Object[]>();
   List<Object[]> replies = new ArrayList<Object[]>();
	if(session.getAttribute("hotel_reviews") != null) {
		reviews = (List<Object[]>) session.getAttribute("hotel_reviews"); }
	if(session.getAttribute("review_replies") != null) {
		replies = (List<Object[]>) session.getAttribute("review_replies"); }
	Map<Object[],List<Object[]>> mapped_replies = new HashMap<Object[],List<Object[]>>();
	for(int i = 0; i < reviews.size(); i++) {
		String rev_id = reviews.get(i)[0].toString();
		List <Object[]> rev_replies = new ArrayList<Object[]>();
		for(int j = 0; j < replies.size(); j++) {
			if(rev_id.equals(replies.get(j)[0].toString())) {
				rev_replies.add(replies.get(j));
			}
		}
		mapped_replies.put(reviews.get(i), rev_replies);
	}
	for(int i = 0; i < reviews.size(); i++) {
		Object[] review = reviews.get(i);
		int id = Integer.valueOf(review[0].toString());
		out.print(review[1].toString()); %> <br>
		<% out.print(review[2].toString()); %> <br>
		<% if(session.getAttribute("currentUser") != null) { %>
		<form name = "Reply" action = "Hotelinfo" method = "post">
		<input type = "hidden" name = "formName" value = "reply">
		<input type = "hidden" name = "rev_id" value = <% out.print(id); %>>
		<input type = "text" placeholder = "Write reply" name = "reply">
		<input type = "submit" value = "Reply">
		</form><br>
		<% } %>
		<%List<Object[]> rev_replies = mapped_replies.get(review);
		for(int j = 0; j < rev_replies.size(); j++) { %>
		<p style = "padding-left:5em">	<% out.print(rev_replies.get(j)[1].toString()); %> </p>
		<p style = "padding-left:5em">	<% out.print(rev_replies.get(j)[2].toString());  %> </p>
		<%} 
	} %>
	<% if(session.getAttribute("currentUser") != null && session.getAttribute("reviewed").equals(false)) { %>
	<form name = "Review" action = "Hotelinfo" method = "post">
	<input type = "hidden" name = "formName" value = "review">
	<input type = "text" placeholder = "Write review" name = "review">
	<input type = "submit" value = "Review">
	</form>
	<% } %>
	<br>
	<p>		</p>
</div>
</div>
	

</body>
</html>