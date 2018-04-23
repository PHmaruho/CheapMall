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
	<c:if test="${result>0}">
		<span style="color: red"> <%
 	out.print("사용 불가능한 코드입니다.");
 %>
		</span>
	</c:if>
	<c:if test="${result==0 }">
		<span style="color: blue"> <%
 	out.print("사용 가능한 코드입니다.");
 %>
		</span>
	</c:if>
</body>
</html>