<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>

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

	<div id="main" class="main">
		<h1>공지사항</h1>		
		<a href="boardAdminNoticeWriteForm.admin"  class="btn mini" >글쓰기</a>
	<p>
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
						<td class="td left" width="200"> 
							 <a class="td" href="boardAdminNoticeContent.admin?board_sq=${board.board_sq }&pageNum=${currentPage}">${board.subject }</a> 
						</td>
						<td>${board.write_dt }</td>
					</tr>
					<c:set var="startNum" value="${startNum - 1 }"/>
				</c:forEach>
			</c:if>
		</table>
			<br>
 		<div class="pagination" >
			<c:if test="${startPage > blockSize }">
				<a class="a"  href="boardAdminNoticeList.admin?pageNum=${startPage - blockSize }&option=${option}&searchText=${searchText}">« Prev</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<a class="a"  href="boardAdminNoticeList.admin?pageNum=${i }&option=${option}&searchText=${searchText}"> ${i}</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a class="a"  href="boardAdminNoticeList.admin?pageNum=${startPage + blockSize }&option=${option}&searchText=${searchText}">Next »</a>
			</c:if>
		</div>
		 		<div class="mainF" >
		
		<select id="searchSelect">
			<option id="all" value="all">전체</option>
			<option id="content" value="subject">제목</option>
			<option id="subject" value="content">내용</option>
			<option id="user_id" value="user_id">작성자</option>
		</select>
		<input type="text" id="searchText" value="${searchText }">
		<input type="button" class="btn mini" value="검색" onclick="searchSelect()">
		<input type="hidden" id="searchHidden">
				</div> 
		
	</div>
</body>
</html>