<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Cheap Mall</title>
</head>
<body>
	<c:if test="${result>0}">
		<span style="color: red; font-size: 10px"> <%
 	out.print("존재하는 코드입니다.");
 %>
		</span>
		<input type="hidden" name="result" id="result" value="3">
		<input type="hidden" name="result1" id="result1" value="1">
	</c:if>
	<c:if test="${result==0 }">
		<span style="color: blue; font-size: 10px"> <%
 	out.print("등록되지 않은 코드입니다.");
 %>
		</span>
		<input type="hidden" name="result" id="result" value="3">
		<input type="hidden" name="result1" id="result1" value="2">
	</c:if>
</body>
</html>