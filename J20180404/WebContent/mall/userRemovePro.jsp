<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 이 페이지는 회원이 탈퇴가 완료되었을 경우 
	 결과를 알리는 알림창입니다. -->


<title>Cheap Mall</title>

	<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("탈퇴되었습니다.");
			location.href="UserRemoveForm.mall";
		</script>
	</c:if>

	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("비밀번호를 다시 한번 확인해주세요.");
			location.href="UserRemoveForm.mall";
		</script>
	</c:if>
	
	<c:if test="${result<0 }">
		<script type="text/javascript">
			alert("회원이 아닙니다.");
			location.href="UserRemoveForm.mall";
		</script>
	</c:if>
</head>
<body>


</body>
</html>