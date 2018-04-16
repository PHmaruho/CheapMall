<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
</head>
<body>
	<h2>문의/건의/신고</h2>
	
	<table>
		<tr>
			<th>번호</th><th>제목</th><th>작성일</th><th>처리상태</th>
		</tr>
		<input type="button" value="작성" onclick="location.href='boardWriteForm.mall'">
		<c:if test="${totCnt > 0 }">
			<c:forEach var="board" items="${list }">
				<tr>
					<td>${startNum }</td>
					<td class="left" width="200"> 
						 <a href="boardOtherContent.mall?board_sq=${board.board_sq}&
						 	pageNum=${currentPage}&board_cd=${board_cd}">${board.subject}</a> 
					</td>
					<td>${board.write_dt }</td>
					<td>${board.meaning }</td>
				</tr>
				<c:set var="startNum" value="${startNum - 1 }"/>
			</c:forEach>
		</c:if>
	</table>
	
	<div style="text-align:center;">
		<c:if test="${startPage > blockSize }">
			<a href="boardOtherList.mall?pageNum=${startPage - blockSize }">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
			<a href="boardOtherList.mall?pageNum=${i }">[${i }]</a>
		</c:forEach>
		<c:if test="${endPage < pageCnt }">
			<a href="boardOtherList.mall?pageNum=${startPage + blockSize }">[다음]</a>
		</c:if>
	</div>
</body>
</html>