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
		alert("display 수정이 완료되었습니다.");
		location.href="goodsAdminUpdateList.admin?&GT=All&0T=All&1T=All";
	</script>
</c:if>

<c:if test="${result==0 }">
	<script type="text/javascript">
		alert("disply 수정이 되지 않았습니다.");
		location.href="goodsAdminUpdateList.admin?&GT=All&0T=All&1T=All";
	</script>
</c:if>
</body>
</html>