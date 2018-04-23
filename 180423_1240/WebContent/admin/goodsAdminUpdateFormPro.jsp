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

	<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("상품이 수정되었습니다.");
			window.close();
		</script>
	</c:if>

	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("전시중인 상품입니다.");
			window.close();
		</script>
	
	</c:if>

	<c:if test="${result<0 }">
		<script type="text/javascript">
			alert("수정이 완료되었습니다 .");
			window.close();
		</script>
	</c:if>


<!-- result 값 비교  -->


</body>
</html>