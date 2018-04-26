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

	<c:if test="${result==-1 }">
		<script type="text/javascript">
			alert("시작날짜와 종료날짜를 확인해주세요");
			history.go(-1);
		</script>
	</c:if>

	<c:if test="${result==-2 }">
		<script type="text/javascript">
			alert("날짜는 현재 날짜보다 앞서야 합니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>