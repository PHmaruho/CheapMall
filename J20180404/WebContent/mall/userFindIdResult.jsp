<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<style type="text/css">
.container {
	position: absolute;
	width: 100%;
	height: 100%;
	padding: 0;
}

.h {
	position: relative;
	border-style: none;
	left: 40%;
}

#resultbtn1, #resultbtn2 {
	position: relative;
	border-style: solid;
	border-width: 1px;
	margin-top: 10px;
	background-color: rgba(255, 255, 255, 0);
	color: black;
	width: 100px;
}

#resultbtn1:hover, #resultbtn2:hover {
	border-width: 2px;
	padding: 5px 11px;
}

.btndiv {
	position: relative;
	left: 40%;
}
</style>
</head>
<body>
	<div class="container">
		<div class="h">
			<h2>당신의 아이디는 ${id } 입니다.</h2>
		</div>
		<div class="btndiv">
			<button onclick="location.href='#'" class="btn btn-success"
				id="resultbtn1">로그인</button>
			<button onclick="location.href='userFindPw.mall'"
				class="btn btn-warning" id="resultbtn2">PW 재설정</button>
		</div>
	</div>
</body>
</html>