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
	<div id="main" class="main">
		<h1>코드 목록</h1>
		<br><br>
		<table class="table" border="1">
			<tr>
				<th class="th">번호</th>
				<th class="th">코드</th>
				<th class="th">카테고리</th>
				<th class="th">의미</th>
				<th class="th">사용여부</th>
				<th class="th"></th>
	
			</tr>
			<c:forEach var="board" items="${list }">
				<tr>
					<td>${startNum }</td>
					<td>${board.cd}</td>
					<td>${board.category }</td>
					<td>${board.meaning }</td>
					<td>${board.used }</td>
					<td><input type="button" class="btn mini"  value="수정" onclick="location.href='CodeChangeForm.admin?code=${board.cd}&pageNum=${pageNum }'"></td>
				</tr>
				<c:set var="startNum" value="${startNum - 1 }" />
			</c:forEach>
			
		</table>
		<br>
 		<div class="pagination" >
			<c:if test="${startPage > blockSize }">
				<a class="a " href='CodeList.admin?pageNum=${startPage-blockSize}'>« Prev</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a class="a " href='CodeList.admin?pageNum=${i}'> ${i}</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a class="a " href='CodeList.admin?pageNum=${startPage+blockSize}'>Next »</a>
			</c:if>
		</div>
		<div class="mainF">
		<input type="button" class="btn mini"  value="등록" onclick="location.href='CodeInsertForm.admin?pageNum'"></td>
	</div>
	</div>
</body>
</html>