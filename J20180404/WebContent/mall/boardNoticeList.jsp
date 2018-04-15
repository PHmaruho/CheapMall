<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
	table {
		width: 100%;
		text-align: center;
	}
	tr {
		border: solid 1px black;
	}
</style>
</head>
<body>
	<h2>공지사항</h2>
	<table>
		<tr>
			<th>번호</th><th>제목</th><th>작성일</th>
		</tr>
		<c:if test="${totCnt > 0 }">
			<c:forEach var="board" items="${list }">
				<tr>
					<td>${startNum }</td>
					<td class="left" width="200"> 
						 <a href="boardNoticeContent.mall?board_sq=${board.board_sq }&pageNum=${currentPage}">${board.subject }</a> 
					</td>
					<td>${board.write_dt }</td>
				</tr>
				<c:set var="startNum" value="${startNum - 1 }"/>
			</c:forEach>
		</c:if>
	</table>
	
	<div style="text-align:center;">
		<c:if test="${startPage > blockSize }">
			<a href="boardNoticeList.mall?pageNum=${startPage - blockSize }">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
			<a href="boardNoticeList.mall?pageNum=${i }">[${i }]</a>
		</c:forEach>
		<c:if test="${endPage < pageCnt }">
			<a href="boardNoticeList.mall?pageNum=${startPage + blockSize }">[다음]</a>
		</c:if>
	</div>
</body>
</html>