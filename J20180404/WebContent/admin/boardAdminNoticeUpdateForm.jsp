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
						<h2>게시판 수정</h2>
						<br>
		
		<table class="tableN" border="1">
				<tr>
				<th class="th">번호</th>
				<td>${boardDto.board_sq }</td>
				</tr>
				<tr>
				<th class="th">제목</th>
				<td>
				<input type="text" name="subject" required="required" value="${boardDto.subject }"></td></tr>
				<tr>
				<th class="th">내용</th>
				<td>
				<textarea rows="10" cols="50" name="content" required="required">${boardDto.content }</textarea>
				</td>
				</tr>
			</table>
		<br>
		<div class="mainF">
				<input type="submit" class="btn mini" value="확인">
				<input type="reset" class="btn mini"  value="다시작성">
		</div>
		</form>
	</div>
</body>
</html>