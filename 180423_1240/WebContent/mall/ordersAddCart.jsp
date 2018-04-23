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
			askCart();
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			window.alert("ordersAddCart 수정 실패");
		</script>
	</c:if>
</body>
</html>