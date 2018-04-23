<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${check == null || check eq '' }">
			<c:if test="${result > 0 }">
				<script type="text/javascript">
					alert("적용 완료");
					location.href = "boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${board_cd}";
				</script>
			</c:if>
			<c:if test="${result == 0 }">
				<script type="text/javascript">
					alert("적용 실패");
					location.href = "boardAdminReportContent.admin?&pageNum=${pageNum}&board_sq=${board_sq}&board_cd=${board_cd}";
				</script>
			</c:if>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert("이미 제재된 사용자입니다. 제재 종료일은 " + ('${check}') + " 입니다.");
				location.href = "boardAdminOtherList.admin?pageNum=${pageNum}&board_cd=${board_cd}";
			</script>
		</c:otherwise>
	</c:choose>
	
	

</body>
</html>