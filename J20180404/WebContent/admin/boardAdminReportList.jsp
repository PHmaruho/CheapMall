<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	window.onload = function() {
		var board_p_cd = '${bp}';
		document.getElementById(board_p_cd).selected = true;
	}

	function bpSelect() {
		var select = document.getElementById("bp");
		var options = select.options;
		var selected = select.options[select.selectedIndex].value;
		var board_cd = '${board_cd}'
		
		location.href = "boardAdminReportList.admin?board_cd=" + board_cd + "&bp=" + selected;
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	
	<div id="main">
		<h1>신고처리</h1>
		
		<select id="bp" onchange="bpSelect()">
			<option id="all" value="all">전체</option>
			<option id="BP0" value="BP0">미확인</option>
			<option id="BP1" value="BP1">처리중</option>
			<option id="BP3" value="BP3">처리완료</option>
		</select>
		<br><br>
		<table class="table" border="1">
			<tr>
				<th class="th">번호</th>
				<th class="th">제목</th>
				<th class="th">작성일</th>
				<th class="th">처리상태</th>
			</tr>
			<c:if test="${totCnt > 0 }">
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${startNum }</td>
						<td class="left td" width="200"> 
							 <a class="td " href="boardAdminReportContent.admin?board_sq=${board.board_sq}&
							 	pageNum=${currentPage}">${board.subject}</a> 
						</td>
						<td>${board.write_dt }</td>
						<td>${board.meaning }</td>
					</tr>
					<c:set var="startNum" value="${startNum - 1 }"/>
				</c:forEach>
			</c:if>
		</table>
		<br>
 		<div class="pagination" >
			<c:if test="${startPage > blockSize }">
				<a href="boardAdminReportList.admin?pageNum=${startPage - blockSize }">« Prev</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<a href="boardAdminReportList.admin?pageNum=${i }"> ${i}</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a href="boardAdminReportList.admin?pageNum=${startPage + blockSize }">Next »</a>
			</c:if>
		</div>
	</div>
</body>
</html>