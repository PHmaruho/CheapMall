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
	alert("수정이 불가합니다. 확인 후 재시도 해주세요");
	history.back();
}
if('${result}' > 0) {
	alert("정보 수정이 완료되었습니다.");
	opener.parent.location="AdminForm.admin";
	window.close();
}

</script>

</body>
</html>