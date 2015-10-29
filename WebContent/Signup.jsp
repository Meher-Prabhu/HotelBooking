<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sign Up</title>
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
<input type="radio" name="option" value="Signup for user account"></input><br>
<input type="radio" name="option" value="Signup for hotel account"></input><br>
<input type="submit" name="signup"></input><br>
</form>
</body>
</html>