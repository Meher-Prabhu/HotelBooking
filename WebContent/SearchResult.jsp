<%@page import="database.Hotelinfo"%>
<%@page import="database.Hotel"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="searchresult" action="Hotelinfo.java" method="post">
<div id="filter" style="float:left; width:25%;"> 
	Filter options:<br>
	Rating : <select name="rating">
				<option value="0">Any</option>
				<option value="1">1 and above</option>
				<option value="2">2 and above</option>
				<option value="3">3 and above</option>
				<option value="4">4 and above</option>
				<option value="5">5</option>
			 </select>
	<br>
	Price-range : <br>
		<input type="checkbox" name="price_range" value="1">5000-10000<br>
		<input type="checkbox" name="price_range" value="2">10000-15000<br>
		<input type="checkbox" name="price_range" value="3">15000-20000<br>
		<input type="checkbox" name="price_range" value="4">20000-25000<br>
	<br>
	Amenities : <br>
		<%List <String> amenitieslist=Hotelinfo.getamenities();
		for(int i=0;i<amenitieslist.size();i++)
			{%>
				<input type="checkbox" name="amenities" value=<%amenitieslist.get(i);%>><br>
		 	<%}%>
</div>
<div id="result" style="float:right; width:75%;">
	List of hotels that match your search results: <br>
	
		<%
		if(session.getAttribute("hotel_search_results")!=null)
		{List <Hotel> hotellist = (List<Hotel>)session.getAttribute("hotel_search_results"); //we are supposed to get this list from Hotel.java servlet
		for(int i=0;i<hotellist.size();i++)
			{%>
				<input type="radio" name="option" value=${hotellist.get(i).get_name() }> <br>
		 	<%;}}%>

	<br>
<input type="submit" name="gethotel" value="Search in this hotel"></input>
</div>

</form>
</body>
</html>