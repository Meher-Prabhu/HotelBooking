<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
body {text-align:center;}
</style>
</head>
<body>

<br>
<form name="Login" action="Login.java" method="post">
<input type="submit" name="Login" value="Loginto existing account"></input><br>
Userid: <input type="text" name="userid"></input><br>
Password: <input type="password" name="pass"></input><br>
</form>
<form name="Signup" action="Signup.jsp" method="post">
<input type="submit" name="Signup" value="Signup for new account"></input>
</form>
<br><br>

<form name="CancelBooking" action="CancelBooking.java" method="post">
<input type="submit" name="cancel" value="Cancel a previous booking"></input>
</form>
<br><br>

<datalist id="cities">
#fill in cities for autofill
</datalist>
<datalist id="areas">
#fill in cities for autofill
</datalist>

Search for hotels: <br>
<form name="Search" action="Hotelinfo.java" method="post">
City: <input type="text" list="cities" name="city"></input><br>
Area: <input type="text" list="areas" name="area"></input><br>
Date of booking: <input type="text" name="date"></input><br>
<input type="submit" ></input>
</form>

</body>
</html>