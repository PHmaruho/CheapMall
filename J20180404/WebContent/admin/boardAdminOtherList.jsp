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
		
		location.href = "boardAdminOtherList.admin?board_cd=" + board_cd + "&bp=" + selected;
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	
	<div id="main">
		<c:if test="${board_cd eq 'B1' }">
			<h2>문의사항</h2>
		</c:if>
		<c:if test="${board_cd eq 'B2' }">
			<h2>건의사항</h2>
		</c:if>
		
		<select id="bp" onchange="bpSelect()">
			<option id="all" value="all">전체</option>
			<option id="BP0" value="BP0">미확인</option>
			<option id="BP1" value="BP1">처리중</option>
			<option id="BP2" value="BP2">답변완료</option>
		</select>
		
		<table>
			<tr>
				<th>번호</th><th>제목</th><th>작성일</th><th>처리상태</th>
			</tr>
			<c:if test="${totCnt > 0 }">
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${startNum }</td>
						<td class="left" width="200"> 
							 <a href="boardAdminOtherContent.admin?board_sq=${board.board_sq}&
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
				<a href="boardAdminOtherList.admin?pageNum=${startPage - blockSize }">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<a href="boardAdminOtherList.admin?pageNum=${i }">[${i }]</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a href="boardAdminOtherList.admin?pageNum=${startPage + blockSize }">[다음]</a>
			</c:if>
		</div>
	</div>
</body>
</html>