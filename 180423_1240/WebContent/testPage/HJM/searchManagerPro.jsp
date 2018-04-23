<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${result eq '0'}">
	데이터가 없습니다.
</c:if>
<c:if test="${result eq '1' }">
	데이터가 중복됩니다.
</c:if>
</body>
</html>