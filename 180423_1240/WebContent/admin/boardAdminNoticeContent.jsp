<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
	table {width: 80%}
	.tdBtn {text-align: center;}
</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<table border="1">
			<caption><h2>공지사항</h2></caption>
			<tr><td>제목</td><td>${boardDto.subject}</td></tr>
			<tr><td>작성일</td><td>${boardDto.write_dt}</td></tr>
			<tr><td>내용</td><td>${boardDto.content}</td></tr>
		</table>
		<input type="button"
			onclick="location.href='boardAdminNoticeUpdateForm.admin?board_sq=${boardDto.board_sq}'" value="수정">
		<input type="button"
			onclick="location.href='boardAdminNoticeDelete.admin?board_sq=${boardDto.board_sq}&pageNum=${pageNum }'" value="삭제">
		<input type="button" onclick="location.href='boardAdminNoticeList.admin?pageNum=${pageNum}'" value="목록">
	</div>
</body>
</html>