<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	if('${result}' == '1'){
		alert("등록이 완료되었습니다.\n로그인 후 이메일을 인증해야 정상적인 이용이 가능합니다.");
		location.href="UserLoginForm.mall";
	} else {
		alert("등록이 실패하였습니다.!");
		location.href="UserRegistForm.mall";
	}
</script>
</body>
</html>