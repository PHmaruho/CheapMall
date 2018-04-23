<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>

<style type="text/css">
	select {
		width: 100px;
	}
</style>
</head>
<body>
	<select id="size">
		<option value="" selected="selected">사이즈 선택</option>
		<c:forEach var="size" items="${list }" varStatus="status">
			<c:choose>
				<c:when test="${size.stock > 0 }">
	   				<option value="${size.goods_size }">${size.nm }</option>
				</c:when>
				<c:otherwise>
					<option value="${size.goods_size }" disabled="disabled">${size.nm } (품절)</option>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
</body>
</html>