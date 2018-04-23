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
			alert("입력 완료");
			location.href="boardAdminNoticeList.admin?pageNum=${pageNum}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("입력 실패");
			location.href="boardAdminNoticeWriteForm.admin?&pageNum=${pageNum}";
		</script>
	</c:if>
</body>
</html>