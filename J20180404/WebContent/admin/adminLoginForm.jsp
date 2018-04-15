<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>관리자 로그인</h1>
<form action="AdminLoginPro.admin" method="post">
<table border="1">

	<tr><td>ID</td><td><input type="text" name="id" required="required"></td></tr>
	<tr><td>PASSWORD</td><td><input type="password" name="pw" required="required"></td></tr>
	<tr><td><input type="submit" value="LOGIN"></td>

</table>
</form>
</body>
</html>