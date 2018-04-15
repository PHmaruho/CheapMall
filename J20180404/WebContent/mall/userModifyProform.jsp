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
<c:if test="${result eq '1' }">
	<script type="text/javascript">
		alert("변경되었습니다.");
		location.href="UserMyPageForm.mall";
	</script>
</c:if>
<c:if test="${result eq '0' }">
	<script type="text/javascript">
		alert("변경이 실패하였습니다.");
		location.href="UserModifyForm.mall";
	</script>
</c:if>
</body>
</html>