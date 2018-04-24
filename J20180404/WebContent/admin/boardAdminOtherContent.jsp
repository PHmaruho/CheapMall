<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
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
			<h2>건의사항</h2>
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
					<c:if test="${boardDto.object == null || boardDto.object eq ''}">
						일반문의
					</c:if>
					<c:if test="${boardDto.object != null || boardDto.object ne ''}">
						${boardDto.object }
					</c:if>
				</td>
			</tr>
			<tr>
			<th class="th">내용</th>
			<td>${boardDto.content}</td></tr>
		</table>
		
		<form action="boardAdminOtherReply.admin" method="post">
			<input type="hidden" name="board_sq" value="${boardDto.board_sq}">
			<input type="hidden" name="subject" value="[답변] ${boardDto.subject}">
			<input type="hidden" name="pageNum" value="${pageNum }">
			<input type="hidden" name="board_cd" value="${boardDto.board_cd }">
			<br>
			<c:choose>
				<c:when test="${boardDto.board_p_cd eq 'BP2' }">
					<textarea rows="10" cols="150" name="content" disabled="disabled">${content }</textarea><br>
				</c:when>
				<c:otherwise>
					<textarea rows="10" cols="150" name="content"></textarea><p>
					<input type="submit" class="btn mini" value="답변달기"> 
				</c:otherwise>
			</c:choose>
		<br><br>
 		<div class="mainF" >
		<input type="button" class="btn mini" onclick="location.href='boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${board_cd }'"
			value="목록">
			</div>
		</form>
	</div>
</body>
</html>