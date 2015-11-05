<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.SampleAccount" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sorry :(</title>
<% boolean redirect = false;
	if(session.getAttribute("currentUser") != null) {
	SampleAccount user = (SampleAccount) session.getAttribute("currentUser");
	if(user.get_type().equalsIgnoreCase("hotel")) {
		redirect = true;
	}
	}
	if(redirect)
		response.sendRedirect("Hoteldetails.jsp");
 else { %>
</head>
<body>
Sorry,we were unable to process your request.<br>
Please check your details and try again.<br> 
<a href = "Homepage.jsp"> Go to Homepage </a>
<% } %>
</body>
</html>