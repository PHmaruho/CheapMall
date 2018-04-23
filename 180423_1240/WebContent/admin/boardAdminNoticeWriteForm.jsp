<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<form action="boardAdminNoticeWritePro.admin?pageNum=${pageNum }" method="post">
			<table>
				<caption><h2>게시판 글쓰기</h2></caption>
				<tr><td>제목</td><td>
				<input type="text" name="subject" required="required">
				<tr><td>내용</td><td><textarea rows="10" cols="30" name="content" required="required"></textarea></td></tr>
				<tr><td><input type="submit" value="확인"></td><td><input type="reset" value="다시작성"></td></tr>
			</table>
		</form>
	</div>
</body>
</html>