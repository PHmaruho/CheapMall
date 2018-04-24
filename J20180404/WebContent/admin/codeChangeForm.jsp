<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main" class="main">
	<h2>코드 수정</h2>
	<br><br>
		<form action="CodeChangePro.admin?pageNum=${pageNum }" method="post">
			<input type="hidden" name="code" value="${codeDto.cd }">
			<table class="tableP" border="1">
				<tr>
					<th class="th">코드</th>
					<td>
						<input type="text" value="${codeDto.cd }" required="required" disabled="disabled"> 
					</td>
				</tr>
				<tr>
					<th class="th">카테고리</th>
					<td colspan="2">
						<input type="text" name="category" value="${codeDto.category }" required="required">
					</td>
				</tr>
				<tr>
					<th class="th">의미</th>
					<td colspan="2">
						<input type="text" name="meaning" value="${codeDto.meaning }" required="required">
					</td>
				</tr>
				<tr>
					<th class="th">사용여부</th>
					<c:if test="${used=='Y' }">
					<td colspan="2">
							<input type="radio" name="used" value="Y" checked="checked">Y
							<input type="radio" name="used" value="N">N
						</td>
					</c:if>
					<c:if test="${used=='N' }">
						<td colspan="2">
							<input type="radio" name="used" value="Y">Y   
							<input type="radio" name="used" value="N" checked="checked">N
						</td>
					</c:if>
				</tr>
							</table>
				
				<br>
 		<div class="mainF" >
						<input type="submit" class="btn mini" value="수정"> 
						<input type="button" class="btn mini" value="취소" onclick="location.href='CodeList.admin'">
		</div>
		</form>
	</div>
</body>
</html>