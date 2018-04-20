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
		
		location.href = "boardAdminNoticeList.admin?option=" + selected2 + "&searchText=" + searchHidden;
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<h2>공지사항</h2>
		<a href="boardAdminNoticeWriteForm.admin"  class="btn mini" >글쓰기</a>
		<table class="table" border="1">
			<tr>
				<th class="th">번호</th>
				<th class="th">제목</th>
				<th class="th">작성일</th>
			</tr>
			<c:if test="${totCnt > 0 }">
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${startNum }</td>
						<td class="left" width="200"> 
							 <a href="boardAdminNoticeContent.admin?board_sq=${board.board_sq }
							 		&pageNum=${currentPage}">${board.subject }</a> 
						</td>
						<td>${board.write_dt }</td>
					</tr>
					<c:set var="startNum" value="${startNum - 1 }"/>
				</c:forEach>
			</c:if>
		</table>
		
		<div style="text-align:center;">
			<c:if test="${startPage > blockSize }">
				<a href="boardAdminNoticeList.admin?pageNum=${startPage - blockSize }
						&option=${option}&searchText=${searchText}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<a href="boardAdminNoticeList.admin?pageNum=${i }
						&option=${option}&searchText=${searchText}">[${i }]</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a href="boardAdminNoticeList.admin?pageNum=${startPage + blockSize }
						&option=${option}&searchText=${searchText}">[다음]</a>
			</c:if>
		</div>
		
		<select id="searchSelect">
			<option id="all" value="all">전체</option>
			<option id="content" value="subject">제목</option>
			<option id="subject" value="content">내용</option>
			<option id="user_id" value="user_id">작성자</option>
		</select>
		<input type="text" id="searchText" value="${searchText }">
		<input type="button" value="검색" onclick="searchSelect()">
		<input type="hidden" id="searchHidden">
	</div>
</body>
</html>