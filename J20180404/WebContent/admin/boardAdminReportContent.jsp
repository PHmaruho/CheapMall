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
	function goodsPop() {
		var object = ('${boardDto.object}');
		window.open("boardAdminOtherReportUsers.admin?object=" + object, "a", "width=400, height=300, left=100, top=50");
	}
</script>
<style type="text/css">
	table {width: 80%}
	.tdBtn {text-align: center;}
</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<table border="1">
			<caption><h2>공지사항</h2></caption>
			<tr><td>제목</td><td>${boardDto.subject}</td></tr>
			<tr><td>작성자</td><td>${boardDto.user_id}</td></tr>
			<tr><td>IP</td><td>${boardDto.ip}</td></tr>
			<tr><td>작성일</td><td>${boardDto.write_dt}</td></tr>
			<tr>
				<td>대상</td>
				<td>
					<a href="#" onclick="goodsPop(); return false;">${boardDto.object }</a>
				</td>
			</tr>
			<tr><td>내용</td><td>${boardDto.content}</td></tr>
		</table>
			
		<c:if test="${boardDto.board_p_cd ne 'BP3' }">
			<form action="boardAdminReportPro.admin" method="post">
				<input type="hidden" name="board_sq" value="${boardDto.board_sq }">
				<input type="hidden" name="object" value="${boardDto.object}">
				<input type="hidden" name="pageNum" value="${pageNum }">
				<input type="hidden" name="board_cd" value="${boardDto.board_cd }">
				<input type="radio" name="radio" value="0">해당없음
				<input type="radio" name="radio" value="7">7일
				<input type="radio" name="radio" value="14">14일
				<input type="radio" name="radio" value="30">30일
				<input type="radio" name="radio" value="180">180일
				<input type="radio" name="radio" value="360">360일
				<input type="submit" value="처리">
			</form>
		</c:if>
		<input type="button" onclick="location.href='boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${boardDto.board_cd }'"
			 value="목록">
	</div>
</body>
</html>