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
		window.open("boardAdminOtherReplyGoods.admin?object=" + object, "a", "width=400, height=300, left=100, top=50");
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
					<c:if test="${boardDto.object == null || boardDto.object eq ''}">
						일반문의
					</c:if>
					<c:if test="${boardDto.object != null || boardDto.object ne ''}">
						<a href="#" onclick="goodsPop(); return false;">${boardDto.object }</a>
					</c:if>
				</td>
			</tr>
			<tr><td>내용</td><td>${boardDto.content}</td></tr>
		</table>
		<form action="boardAdminOtherReply.admin" method="post">
			<input type="hidden" name="board_sq" value="${boardDto.board_sq}">
			<input type="hidden" name="subject" value="[답변] ${boardDto.subject}">
			<input type="hidden" name="pageNum" value="${pageNum }">
			<input type="hidden" name="board_cd" value="${boardDto.board_cd }">
			<c:choose>
				<c:when test="${boardDto.board_p_cd eq 'BP2' }">
					<textarea rows="10" cols="50" name="content" disabled="disabled">${content }</textarea><br>
				</c:when>
				<c:otherwise>
					<textarea rows="10" cols="50" name="content"></textarea><br>
					<input type="submit" value="답변달기"> 
				</c:otherwise>
			</c:choose>
		</form>
		<input type="button" onclick="location.href='boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${board_cd }'"
			value="목록">
	</div>
</body>
</html>