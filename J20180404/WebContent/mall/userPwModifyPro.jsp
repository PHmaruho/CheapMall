<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<script type="text/javascript">
		if('${result}' == '1'){
			alert("비밀번호가 변경되었습니다.");
			window.close();
		} else {
			alert("변경이 안되었습니다.");
			location.href="userPwPopup.jsp";
		}
	</script>
</body>
</html>