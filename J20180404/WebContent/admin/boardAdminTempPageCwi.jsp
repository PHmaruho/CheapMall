<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	<h1>임시 페이지입니다.</h1>
	<div id="main">
		<a href="boardAdminNoticeList.admin">공지사항</a>
		<a href="boardAdminOtherList.admin?board_cd=B1">문의사항</a>
		<a href="boardAdminOtherList.admin?board_cd=B2">건의사항</a>
		<a href="boardAdminOtherList.admin?board_cd=B3">신고처리</a>
	</div>
</body>
</html>