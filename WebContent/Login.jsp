<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<form action="Login" method="post">
User Name:<br>
<input type="text" name="username" >
<br>
Password:<br>
<input type="password" name="password" >
<br><br>
<input type="submit" value="Submit">
</form>
<br>
<br>
<% if(session.getAttribute("error") == "Invalid") {	%>
Invalid data please verify your details
<% } %>
</body>
</html>