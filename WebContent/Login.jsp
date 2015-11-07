<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<% if(session.getAttribute("currentUser") != null) { 
	response.sendRedirect("Homepage.jsp");
}
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
<li> <a href = "Signup.jsp"> Signup </a> </li>
</ul>
</div>
</div>
</nav> 
<div class = "container">
<h2> LOGIN </h2>
<form action="Login" method="post" role="form">
<div class = "form-group">
User Name:
<input type="email" class="form-control" name="username" >
</div>
<div class = "form-group">
Password:
<input type="password" class = "form-control" name="password" >
</div>
<input type="submit" class = "btn btn-success" value="Login">
</form>
<br>
<br>
<% if(session.getAttribute("error") == "Invalid") {	%>

<div class = "alert alert-danger" role = "alert">
<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
Invalid data please verify your details
</div>

<% session.setAttribute("error",null);} %>
</div>
</body>
</html>