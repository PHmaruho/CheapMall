<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Cheap Mall</title>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	<div class="main">
		저장 경로 : ${path }
		<button onclick="location.href='ExcelForm.admin'">운송목록 Main Page로 이동</button>
	</div>
</body>
</html>