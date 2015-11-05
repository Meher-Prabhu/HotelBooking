<%@page import="database.Hotelinfo"%>
<%@page import="database.Hotel"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search results</title>
</head>
<body>
<form name="searchresult" action="Hotelinfo" method="post">
<div id="filter" style="float:left; width:25%;"> 
	Filter options:<br>
	Rating : <select name="rating">
				<option value="0">Any</option>
				<option value="1">>=1</option>
				<option value="2">>=2</option>
				<option value="3">>=3</option>
				<option value="4">>=4</option>
				<option value="5">=5</option>
			 </select>
	<br>
	Price-range : <br>
	Min-price:	<input type="number" name="minprice" value=""><br>
	Max-price:	<input type="number" name="maxprice" value=""><br>
	
	Amenities : <br>
		<%List <String> amenitieslist=Hotelinfo.getamenities();
		for(int i=0;i<amenitieslist.size();i++)
			{%>
				<input type="checkbox" name="amenities" value=<%out.write(amenitieslist.get(i));%>><%out.write(amenitieslist.get(i));%><br>
		 	<%}%>
	<input type="submit" name="getlisthotels" value="Get list of hotels"></input><br><br>
	<% if(session.getAttribute("missing_input") == "true") {	%>
Please fill in the checkboxes.
<% } %>
</div>

<div id="result" style="float:right; width:75%;">
	List of hotels that match your search results: <br>
	
		<%
		if(session.getAttribute("hotel_search_results")!=null)
		{List <Object[]> hotellist = (List<Object[]>)session.getAttribute("hotel_search_results"); //we are supposed to get this list from Hotel.java servlet
		for(int i=0;i<hotellist.size();i++)
			{
			%>

				<input type="radio" name="option" value=<% out.write(hotellist.get(i)[0].toString()); %> > <% out.write(hotellist.get(i)[1].toString()); %> <br> 
		 	 <%}}%> 

	<br>
<input type="submit" name="gethotel" value="Search in this hotel"></input>
</div>

</form>
</body>
</html>