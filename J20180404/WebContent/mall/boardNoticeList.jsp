<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../js/bootstrap.min.css">
<title>Cheap Mall</title>
<style type="text/css">
.container {
	position: absolute;
	width: 100%;
	height: 100%;
}

.h {
	border-style: none;
	position: relative;
	left: 45%;
}

.noticetb {
	position: relative;
	width: 100%;
	border-style: none;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
	border-style: none
}

.noticetb tr td, th {
	text-align: center;
	border-top-style: none;
}

.noticetb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
}

.noticetb th {
	background-color: #E5E1E1;
}

#noticebtn {
	border-style: solid;
	border-width: 1px;
	/* border-color: gray; */
	background-color: rgba(255, 255, 255, 0);
	color: black;
}

#noticebtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}
</style>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	window.onload = function() {
		var option = '${option}';
		$("#searchSelect").val(option);
		$("#searchHidden").val('${searchText}');
	}

	function searchSelect() {
		var select2 = document.getElementById("searchSelect");
		var options2 = select2.options;
		var selected2 = select2.options[select2.selectedIndex].value;

		var searchText = document.getElementById("searchText").value;
		$("#searchHidden").val(searchText);
		var searchHidden = document.getElementById("searchHidden").value;

		location.href = "boardNoticeList.mall?option=" + selected2
				+ "&searchText=" + searchHidden;
	}
</script>
</head>
<body>
	<div class="container">
		<div class="h">
			<h2>공지사항</h2>
		</div>
		<table class="noticetb">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
			<c:if test="${totCnt > 0 }">
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${startNum }</td>
						<td class="left" width="200"><a
							href="boardNoticeContent.mall?board_sq=${board.board_sq }&pageNum=${currentPage}">${board.subject }</a>
						</td>
						<td>${board.write_dt }</td>
					</tr>
					<c:set var="startNum" value="${startNum - 1 }" />
				</c:forEach>
			</c:if>
		</table>

		<div style="text-align: center;">
			<c:if test="${startPage > blockSize }">
				<a
					href="boardNoticeList.mall?pageNum=${startPage - blockSize }
					&option=${option }&searchText=${searchText }">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<a
					href="boardNoticeList.mall?pageNum=${i }
					&option=${option }&searchText=${searchText }">[${i }]</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a
					href="boardNoticeList.mall?pageNum=${startPage + blockSize }
					&option=${option }&searchText=${searchText }">[다음]</a>
			</c:if>
		</div>

		<select id="searchSelect">
			<option id="all" value="all">전체</option>
			<option id="content" value="subject">제목</option>
			<option id="subject" value="content">내용</option>
			<option id="user_id" value="user_id">작성자</option>
		</select> <input type="text" id="searchText" value="${searchText }"> <input
			type="button" value="검색" onclick="searchSelect()"
			class="btn btn-primary" id="noticebtn"> <input type="hidden"
			id="searchHidden">
	</div>
</body>
</html>