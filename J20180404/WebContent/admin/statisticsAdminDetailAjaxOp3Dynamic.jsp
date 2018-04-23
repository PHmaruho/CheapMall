<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
.dynamic th {
	border: solid 1px black;
}

.dynamic td {
	border: solid 1px black;
}
</style>
</head>
<body>
<br><br>
	<table class="dynamic table">
		<tr>
			<c:forEach var="ct" items="${columnType }">
				<c:choose>
					<c:when test="${ct eq 'cAddr' }"><th class="th">주소</th></c:when>
					<c:when test="${ct eq 'cGrade' }"><th class="th">등급</th></c:when>
					<c:when test="${ct eq 'cGender' }"><th class="th">성별</th></c:when>
					<c:otherwise><th class="th">연령</th></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:forEach var="rt" items="${resultType }">
				<c:choose>
					<c:when test="${rt eq 'rCnt' }"><th class="th">회원수</th></c:when>
					<c:when test="${rt eq 'rSsum' }"><th class="th">매출액</th></c:when>
					<c:otherwise><th class="th">반품액</th></c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
				<br><br>
		
		<c:forEach var="list" items="${list }">
			<tr>
				<c:forEach var="ct" items="${columnType }">
				<c:choose>
					<c:when test="${ct eq 'cAddr' }"><td>${list.addr }</td></c:when>
					<c:when test="${ct eq 'cGrade' }"><td >${list.grade }</td></c:when>
					<c:when test="${ct eq 'cGender' }"><td>${list.gender }</td></c:when>
					<c:otherwise><td>${list.year }</td></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:forEach var="rt" items="${resultType }">
				<c:choose>
					<c:when test="${rt eq 'rCnt' }"><td><fmt:formatNumber value="${list.cnt }" pattern="#,###" /></td></c:when>
					<c:when test="${rt eq 'rSsum' }"><td><fmt:formatNumber value="${list.ssum }" pattern="#,###" /></td></c:when>
					<c:otherwise><td><fmt:formatNumber value="${list.rsum }" pattern="#,###" /></td></c:otherwise>
				</c:choose>
			</c:forEach>
			</tr>
		</c:forEach>
	</table>
</body>
</html>