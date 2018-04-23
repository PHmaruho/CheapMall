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
	<c:if test="${result == 1 || result2 == 1}">
		<script type="text/javascript">
			alert("취소가 성공하셨습니다.");
			location.href = "OrderUserCancleForm.mall";
		</script>
	</c:if>
	<c:if test="${result != 1 && result2 != 1}">
		<script type="text/javascript">
			alert("취소가 실패하셨습니다.");
			location.href = "OrderUserCancleForm.mall";
		</script>
	</c:if>
</body>
</html>