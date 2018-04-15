<%@page import="com.cheapmall.dto.CartDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="AdminUserListForm.admin" method="post">
			<input type="submit" value="회원리스트">
		</form>
	</div>
	
	<div>
		<form action="SearchManagerForm.admin" method="get">
			<input type="submit" value="검색어등록">
		</form>
	</div>
	SearchManagerPro.admin
	<div>
		<form action="SearchManagerPro.admin" method="get">
			<input type="hidden" value="overlap" name="overlap">
			<input type="submit" value="검색어등록">
		</form>
	</div>
	
</body>
</html>