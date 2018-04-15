<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>


<body>
		<c:if test="${result>0 }">
			<script type="text/javascript">
				alert("선택한 회원이 삭제되었습니다.");
				location.href = "userAdminList.admin";
			</script>
		</c:if>

		<c:if test="${result<0 }">
			<script type="text/javascript">
				alert("삭제가 되지 않았습니다.");
			</script>
		</c:if>
</body>
</html>