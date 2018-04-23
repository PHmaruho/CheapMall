<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	function checkPw() {
		if ($('#pw1').val() == $('#pw2').val()) {
			location.href = "userFindPwResultPro.mall"
		} else {
			alert("비밀번호가 일치하지 않습니다.")
			return false;
		}
	}
</script>
</head>
<body>
	<form action="userFindPwResultPro.mall" onsubmit="return checkPw()" method="post">
		<label>비밀번호 재설정</label><input type="password" required="required" id="pw1" name="pw1"><br>
		<label>비밀번호 확인</label><input type="password" required="required" id="pw2" name="pw2"><br>
		<input type="hidden" value="${id }" name="id">
		<input type="hidden" value="${email }" name="email">
		<input type="submit" value="비밀번호 재설정">
	</form>
</body>
</html>