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
		���� ��� : ${path }
		<button onclick="location.href='ExcelForm.admin'">��۸�� Main Page�� �̵�</button>
	</div>
</body>
</html>