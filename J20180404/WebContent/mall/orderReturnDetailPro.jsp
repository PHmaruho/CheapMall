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
		alert("선택한 상품이 반품되었습니다.");
		location.href="OrderListSimpleForm.mall?id=${id}"
	</script>
</c:if>

<c:if test="${result<=0 }">
	<script type="text/javascript">
		alert("다시 한번 확인해주세요");
		location.href="OrderListSimpleForm.mall?id=${id}"
	</script>
</c:if>

</body>
</html>