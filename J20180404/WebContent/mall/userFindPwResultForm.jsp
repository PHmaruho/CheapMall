<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../js/bootstrap.min.css">
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
<style type="text/css">
.container {
	position: absolute;
	width: 100%;
	height: 100%;
	padding: 0;
}

.div1 {
	position: relative;
	left: 35%;
}

.div2 {
	position: relative;
	left: 35%;
}

#pwresultbtn {
	position: relative;
	border-style: solid;
	border-width: 1px;
	margin-top: 10px;
	background-color: rgba(255, 255, 255, 0);
	color: black;
	width: 130px;
	left: 35%;
}

#pwresultbtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}

.h {
	position: relative;
	border-style: none;
	left: 40%;
}

.txt1, .txt2 {
	position : absolute;
	left: 10%;
}
</style>
</head>
<body>
	<div class="container">
		<div class="h">
			<h2>비밀번호 재설정</h2>
		</div>
		<form action="userFindPwResultPro.mall" onsubmit="return checkPw()"
			method="post">
			<div class="div1">
				<label>비밀번호 재설정</label><input type="password" required="required"
					id="pw1" name="pw1" class="txt1">
			</div>
			<div class="div2">
				<label>비밀번호 확인</label><input type="password" required="required"
					id="pw2" name="pw2" class="txt2">
			</div>
			<input type="hidden" value="${id }" name="id"> <input
				type="hidden" value="${email }" name="email"> <input
				type="submit" value="비밀번호 재설정" class="btn btn-success"
				id="pwresultbtn">
		</form>
	</div>
</body>
</html>