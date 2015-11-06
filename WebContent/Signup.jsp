<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sign Up</title>
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
<li> <a href = "Login.jsp"> Login </a> </li>
</ul>
</div>
</div>
</nav>
<div class = "container">
<h2> Signup </h2> 
<form action="Login" method="post" role = "form">
<h4>Name*:</h4> <input type="text" name="name" class = "form-control"></input><br>
<h4>Mail-id*:</h4> <input type="text" name="mail_id" class = "form-control"></input><br>
<h4>Contact number:</h4> <input type="number" name="contact_number" class = "form-control"></input><br>
<h4>Address:</h4> <input type="text" name="address" class = "form-control"></input><br>
<h4>Password for account*:</h4> <input type="password" name="pass1" class = "form-control"></input><br>
<h4>Retype password*:</h4> <input type="password" name="pass2" class = "form-control"></input><br>
<h4>
<label class = "radio-inline"> Register as (hotel account needs admin approval)*: </label>
<label class = "radio-inline"><input type="radio" name="type" value="user">User Account</label>
<label class = "radio-inline"><input type="radio" name="type" value="hotel">Hotel Account</label></h4><br>
<input type="submit" class = "btn btn-success" name="signup"></input><br>
</form>
<% if(session.getAttribute("error") == "Invalid") {	%>
Invalid data please verify your details
<% } if(session.getAttribute("error") == "Mismatch") {	%>
Passwords do not match
<% } if(session.getAttribute("error") == "Present") {	%>
Account already exists with the mailID
<% } session.setAttribute("error", "");%>
<p class = "lead">	</p>
</div>
</body>
</html>