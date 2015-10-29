<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
Enter your details (if signing up for hotel account enter hotel details else your personal details): <br>
<form action="Login" method="post">
Name*: <input type="text" name="name"></input><br>
Mail-id*: <input type="text" name="mail_id"></input><br>
Contact number: <input type="text" name="contact_number"></input><br>
Address: <input type="text" name="address"></input><br>
Password for account*: <input type="password" name="pass1"></input><br>
Retype password*: <input type="password" name="pass2"></input><br>
<input type="radio" name="type" value="user">User Account</input><br>
<input type="radio" name="type" value="hotel">Hotel Account</input><br>
<input type="submit" name="signup"></input><br>
</form>
<% if(session.getAttribute("error") == "Invalid") {	%>
Invalid data please verify your details
<% } if(session.getAttribute("error") == "Mismatch") {	%>
Passwords same daal chutiye
<% } if(session.getAttribute("error") == "Present") {	%>
Kitne baar account banana hain chutiye
<% } %>
</body>
</html>