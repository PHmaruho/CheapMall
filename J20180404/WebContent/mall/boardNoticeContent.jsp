<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
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

#boardnoticecontentbtn {
	position : relative;
	left : 20%;
	margin-top : 10px;
	border-style: solid;
	border-width: 1px;
	/* border-color: gray; */
	background-color: rgba(255, 255, 255, 0);
	color: black;
}

#boardnoticecontentbtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}

.boardnoticecontenttb {
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

.boardnoticecontenttb tr td, th {
	/* text-align: center; */
	border-top-style: none;
}

.boardnoticecontenttb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
	padding-left: 5%;
}

.boardnoticecontenttb th {
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
	<div class="h">
		<h2>공지사항</h2>
	</div>
	<table class="boardnoticecontenttb">
		<tr>
			<th>제목</th>
			<td>${boardDto.subject}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${boardDto.write_dt}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${boardDto.content}</td>
		</tr>
	</table>
	<input type="button"
		onclick="location.href='boardNoticeList.mall?pageNum=${pageNum}'"
		value="목록" class="btn btn-primary" id="boardnoticecontentbtn">
</body>
</html>