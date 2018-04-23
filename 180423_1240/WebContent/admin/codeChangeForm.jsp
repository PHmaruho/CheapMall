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

	<div id="main">
		<form action="CodeChangePro.admin?pageNum=${pageNum }" method="post">
			<input type="hidden" name="code" value="${codeDto.cd }">
			<table>
				<tr>
					<th>코드</th>
					<td>
						<input type="text" value="${codeDto.cd }" required="required" disabled="disabled"> 
					</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>
						<input type="text" name="category" value="${codeDto.category }" required="required">
					</td>
				</tr>
				<tr>
					<th>의미</th>
					<td>
						<input type="text" name="meaning" value="${codeDto.meaning }" required="required">
					</td>
				</tr>
				<tr>
					<th>사용여부</th>
					<c:if test="${used=='Y' }">
						<td>
							<input type="radio" name="used" value="Y" checked="checked">Y
						</td>
						<td>
							<input type="radio" name="used" value="N">N
						</td>
					</c:if>
					<c:if test="${used=='N' }">
						<td>
							<input type="radio" name="used" value="Y">Y
						</td>
						<td>
							<input type="radio" name="used" value="N" checked="checked">N
						</td>
					</c:if>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정"> 
						<input type="button" value="취소" onclick="location.href='CodeList.admin'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>