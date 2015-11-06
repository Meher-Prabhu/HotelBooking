<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.Account" %>    
<jsp:include page="header.jsp"></jsp:include>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Request pending</title>
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
<p class = "lead">
Your request is pending. Please wait for the admin's approval.<br>
If you did not add the details of your hotel yet, <a href = "addHotel.jsp">please add it</a> since the request will not be approved otherwise.
</p>
</div>
</body>
</html>