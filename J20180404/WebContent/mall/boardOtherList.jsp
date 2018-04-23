<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<script type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">
.container {
	position: absolute;
	width: 100%;
	height: 100%;
	padding: 0;
}

.h {
	border-style: none;
	position: relative;
	left: 41%;
}

.boardtb {
	position: relative;
	width : 100%;
	border-style: none;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
}

.boardtb tr td, th {
	text-align: center;
	border-top-style: none;
}

.boardtb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
}

.boardtb th {
	background-color: #E5E1E1;
	border-bottom-style: none;
}
#boardbtn {
	border-style: solid;
	border-width: 1px;
	/* border-color: gray; */
	background-color: rgba(255, 255, 255, 0);
	color: black;
	margin-bottom: 10px;
}

#boardbtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="h">
			<h2>문의/건의/신고</h2>
		</div>
		<input type="button" value="작성"
			onclick="location.href='boardWriteForm.mall'" class="btn btn-primary" id="boardbtn">
		<table class="boardtb">
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성일</th>
				<th>처리상태</th>
			</tr>
			<c:if test="${totCnt > 0 }">
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${startNum }</td>
						<td>${board.board_cd }</td>
						<td class="left" width="200"><a
							href="boardOtherContent.mall?board_sq=${board.board_sq}&
						 	pageNum=${currentPage}&board_cd=${board.board_cd}&board_p_cd=${board.board_p_cd}">${board.subject}</a>
						</td>
						<td>${board.write_dt }</td>
						<td>${board.board_p_cd }</td>
					</tr>
					<c:set var="startNum" value="${startNum - 1 }" />
				</c:forEach>
			</c:if>
		</table>

		<div style="text-align: center;">
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
	</div>
</body>
</html>