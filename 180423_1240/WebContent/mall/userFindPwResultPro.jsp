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
			alert("비밀번호가 재설정 되었습니다.");
			location.href="#";	// 로그인화면으로 이동
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("오류가 발생하여 비밀번호 재설정에 실패하였습니다.");
			location.href="userFindPw.mall";
		</script>
	</c:if>
</body>
</html>
