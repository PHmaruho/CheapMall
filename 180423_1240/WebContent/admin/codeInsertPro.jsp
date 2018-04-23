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
	<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("등록완료");
			location.href = "CodeList.admin";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("등록실패");
			location.href = "CodeInsertForm.admin?pageNum=${pageNum}";
		</script>
	</c:if>
</body>
</html>