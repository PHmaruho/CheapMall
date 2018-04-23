<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<form action="boardAdminNoticeUpdatePro.admin" method="post">
			<input type="hidden" name="board_sq" value="${boardDto.board_sq }">
			<input type="hidden" name="pageNum" value="${pageNum }">
			
			<table border="1">
				<caption><h2>게시판 수정</h2></caption>
				<tr><td>번호</td><td>${boardDto.board_sq }</td></tr>
				<tr><td>제목</td><td><input type="text" name="subject" required="required" value="${boardDto.subject }"></td></tr>
				<tr><td>내용</td><td><textarea rows="10" cols="40" name="content" required="required">${boardDto.content }</textarea></td></tr>
				<tr><td colspan="2"><input type="submit" value="확인"><input type="reset" value="다시작성"></td></tr>
			</table>
		</form>
	</div>
</body>
</html>