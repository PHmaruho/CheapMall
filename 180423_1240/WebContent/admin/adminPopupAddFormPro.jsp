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
			alert("팝업이 등록되었습니다.");
			window.close();
		</script>
	</c:if>
	
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("항목을 다시 확인해주세요.");
			window.close();
		</script>
	</c:if>
	
</body>
</html>