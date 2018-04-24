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

	<div id="main" class="main">
	
				<h2>공지사항</h2>
				<br>
		<table class="tableN" border="1">
		
			<tr>
			<th class="th">제목</th>
			<td>${boardDto.subject}</td>
			</tr>
			<tr>
			<th class="th">작성일</th>
			<td>${boardDto.write_dt}</td>
			</tr>
			<tr>
			<th class="th">내용</th>
			<td>${boardDto.content}</td>
			</tr>
		</table>
		<br>
		<div class="mainF">
		<input type="button" class="btn mini"
			onclick="location.href='boardAdminNoticeUpdateForm.admin?board_sq=${boardDto.board_sq}'" value="수정">
		<input type="button"  class="btn mini"
			onclick="location.href='boardAdminNoticeDelete.admin?board_sq=${boardDto.board_sq}&pageNum=${pageNum }'" value="삭제">
		<input type="button"  class="btn mini" onclick="location.href='boardAdminNoticeList.admin?pageNum=${pageNum}'" value="목록">
	</div>
	</div>
</body>
</html>