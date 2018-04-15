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
	String id = "imgroot";
	session.setAttribute("id", id);
%>
	<input type="button" onclick="location.href='boardNoticeList.mall'" value="공지사항">
	<input type="button" onclick="location.href='boardWriteForm.mall'" value="문의">
</body>
</html>