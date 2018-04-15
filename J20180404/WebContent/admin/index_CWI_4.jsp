<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
<%
	String auth = "A0";
	session.setAttribute("auth", auth);
%>
	<input type="button" onclick="location.href='boardAdminNoticeList.admin'" value="공지사항">
	<input type="button" onclick="location.href='boardAdminOtherList.admin'" value="문의">
</body>
</html>