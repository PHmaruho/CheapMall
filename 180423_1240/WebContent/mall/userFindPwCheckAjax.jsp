<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("인증번호가 요청되었습니다.")
			var userKey = document.getElementById("userKey");
			var id = document.getElementById("id");
			var email = document.getElementById("email");
			certBtn();
			userKey.disabled = false;
			id.disabled = true;
			email.disabled = true;
			/* var certBtn = document.getElementById("certBtn");
			certBtn.disabled = false;
			var checkKey = document.getElementById("checkKey");
			checkKey.disabled = false; */
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("입력하신 회원정보가 존재하지 않습니다.");
		</script>
	</c:if>
</body>
</html>