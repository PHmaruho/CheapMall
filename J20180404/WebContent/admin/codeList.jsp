<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
table {
	width: 100%;
}
td{
	text-align: center;
}

</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<table>
			<tr>
				<th>번호</th>
				<th>코드</th>
				<th>카테고리</th>
				<th>의미</th>
				<th>사용여부</th>
				<th></th>
	
			</tr>
			<c:forEach var="board" items="${list }">
				<tr>
					<td>${startNum }</td>
					<td>${board.cd}</td>
					<td>${board.category }</td>
					<td>${board.meaning }</td>
					<td>${board.used }</td>
					<td><input type="button" value="수정" onclick="location.href='CodeChangeForm.admin?code=${board.cd}&pageNum=${pageNum }'"></td>
				</tr>
				<c:set var="startNum" value="${startNum - 1 }" />
			</c:forEach>
			<tr>
				<td colspan="6"><input type="button" value="등록" onclick="location.href='CodeInsertForm.admin?pageNum'"></td>
			</tr>
		</table>
		<div style="text-align: center;">
			<c:if test="${startPage > blockSize }">
				<a href='CodeList.admin?pageNum=${startPage-blockSize}'>[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a href='CodeList.admin?pageNum=${i}'>[${i}]</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a href='CodeList.admin?pageNum=${startPage+blockSize}'>[다음]</a>
			</c:if>
		</div>
	</div>
</body>
</html>