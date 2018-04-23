<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
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
	left: 45%;
}

#boardcontentbtn {
	position : relative;
	left : 20%;
	margin-top : 10px;
	border-style: solid;
	border-width: 1px;
	/* border-color: gray; */
	background-color: rgba(255, 255, 255, 0);
	color: black;
}

#boardcontentbtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}

.boardcontenttb {
	position: relative;
	border-style: none;
	width : 60%;
	left : 20%;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color : black;
	border-top-style: solid;
	border-top-width: 1px;
}

.boardcontenttb tr td, th {
	/* text-align: center; */
	border-top-style: none;
}

.boardcontenttb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
	padding-left: 5%;
}

.boardcontenttb th {
	background-color: #E5E1E1;
	border-bottom-style: solid;
	border-bottom-color : #9A9A9A;
	border-bottom-width : 1px;
	border-right-style : solid;
	border-right-width : 1px;
	width: 10%;
}
</style>
</head>
<body>
	<div class="container">
		<div class="h">
			<h2>${board_cd }</h2>
		</div>
		<table class="boardcontenttb">
			<tr>
				<th>제목</th>
				<td>${boardDto.subject}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${boardDto.user_id}</td>
			</tr>
			<tr>
				<th>IP</th>
				<td>${boardDto.ip}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${boardDto.write_dt}</td>
			</tr>
			<tr>
				<th>대상</th>
				<td><c:if
						test="${boardDto.object == null || boardDto.object eq ''}">
					일반문의
				</c:if> <c:if test="${boardDto.object != null || boardDto.object ne ''}">
					${boardDto.object }
				</c:if></td>
			</tr>
			<tr>
				<th>처리상태</th>
				<td>${board_p_cd}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${boardDto.content}</td>
			</tr>
		</table>
		<c:if test="${boardDto.board_p_cd eq 'BP2' }">
			<textarea rows="10" cols="50" name="content" disabled="disabled">${content }</textarea>
			<br>
		</c:if>
		<input type="button"
			onclick="location.href='boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${board_cd }'"
			value="목록" class="btn btn-primary" id="boardcontentbtn">
	</div>
</body>
</html>