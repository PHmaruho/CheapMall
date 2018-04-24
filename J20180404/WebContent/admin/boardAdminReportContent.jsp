<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
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
		<h2>신고처리</h2>
			<table class="tableP" border="1">
			<tr>
			<th class="th">제목</th>
			<td>${boardDto.subject}</td></tr>
			<tr>
			<th class="th">작성자</th>
			<td>${boardDto.user_id}</td></tr>
			<tr>
			<th class="th">IP</th>
			<td>${boardDto.ip}</td></tr>
			<tr>
			<th class="th">작성일</th>
			<td>${boardDto.write_dt}</td></tr>
			<tr>
				<th class="th">대상</th>
				<td>
					${boardDto.object }
				</td>
			</tr>
			<tr>
			<th class="th">내용</th>
			<td>${boardDto.content}</td></tr>
		</table>
			<br>
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
				<input type="submit" class="btn mini" value="처리">
		</form>
		</c:if>
		<br>
 		<div class="mainF" >
		<input type="button" class="btn mini" onclick="location.href='boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${boardDto.board_cd }'"
			 value="목록">
			 </div>
	</div>
</body>
</html>