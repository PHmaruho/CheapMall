<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.container {
	position: absolute;
	width: 100%;
	height: 100%;
	padding: 0;
}

.h {
	border-style: none;
	position: relative;
	left: 42%;
}

.userremoveta {
	position: absolute;
	margin-top : 3.5px;
	left: 40%;
}

#userremovebtn {
	position : absolute;
	left : 55%;
	border-style: solid;
	border-width: 1px;
	/* border-color: gray; */
	background-color: rgba(255, 255, 255, 0);
	color: black;
}

#userremovebtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}
</style>
<title>Cheap Mall</title>

</head>
<body>


	<div id="container">
		<form action="userRemovePro.mall" method="post">
			<div class="h">
				<h2>비밀번호 확인</h2>
			</div>
			<input type="password" name="pw" class="userremoveta">
			<p>
				<input type="submit" value="확인" class="btn btn-primary"
					id="userremovebtn">
		</form>
	</div>
</body>
</html>