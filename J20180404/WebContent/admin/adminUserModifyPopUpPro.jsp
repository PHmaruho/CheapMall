<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	if('${result}' == 0) {
		alert("error");
		location.href="AdminUserModifyPopUp.admin?id="+${userId};
	}
	if('${result}' >= 1) {
		alert("등록되었습니다.");
		opener.parent.location="AdminUserListForm.admin?pageNum="+${pageNum};
		window.close();
	}
	if('${result}' == -1) {
		alert("수상한 접근입니다.");
		opener.parent.location="AdminUserListForm.admin?pageNum="+${pageNum};
		window.close();
	}
</script>
</body>
</html>