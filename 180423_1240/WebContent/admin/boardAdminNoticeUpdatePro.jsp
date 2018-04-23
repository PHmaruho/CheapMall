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
			if (confirm("수정 완료\n목록으로 이동하시겠습니까?")) {
				location.href="boardAdminNoticeList.admin?pageNum=${pageNum}";
			} else {
				location.href="boardAdminNoticeContent.admin?board_sq=${board_sq}";
			}
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("수정 실패");
			location.href="boardAdminNoticeUpdateForm.admin?board_sq=${board_sq}&pageNum=${pageNum}";
		</script>
	</c:if>
</body>
</html>