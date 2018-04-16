<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">
	table {width: 80%}
	.tdBtn {text-align: center;}
</style>
</head>
<body>
	<table border="1">
		<caption><h2>${board_cd }</h2></caption>
		<tr><td>제목</td><td>${boardDto.subject}</td></tr>
		<tr><td>작성자</td><td>${boardDto.user_id}</td></tr>
		<tr><td>IP</td><td>${boardDto.ip}</td></tr>
		<tr><td>작성일</td><td>${boardDto.write_dt}</td></tr>
		<tr>
			<td>대상</td>
			<td>
				<c:if test="${boardDto.object == null || boardDto.object eq ''}">
					일반문의
				</c:if>
				<c:if test="${boardDto.object != null || boardDto.object ne ''}">
					${boardDto.object }
				</c:if>
			</td>
		</tr>
		<tr><td>처리상태</td><td>${board_p_cd}</td></tr>
		<tr><td>내용</td><td>${boardDto.content}</td></tr>
	</table>
	<c:if test="${boardDto.board_p_cd eq 'BP2' }">
		<textarea rows="10" cols="50" name="content" disabled="disabled">${content }</textarea><br>
	</c:if>
	<input type="button" onclick="location.href='boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${board_cd }'"
		value="목록">
</body>
</html>