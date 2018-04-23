<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
.container {
	position: absolute;
	width : 100%;
	height : 100%;
	border-style: none;
}

form {
	border-style: none;
}

#find {
	position: absolute;
	left: 140px;
	top: 90px;
	background-color: rgba(255, 255, 255, 0);
	border-color: gray;
}

#regist {
	position: absolute;
	left: 40px;
	top: 90px;
	background-color: rgba(255, 255, 255, 0);
	border-color: gray;
}

table {
	position: absolute;
	left: 40%;
	top: 5%;
	display: inline-block;
}

.submit {
	border-style: none;
	position: absolute;
	left: 60%;
	top: 5.5%;
}

#login1 {
	background-color: rgba(255, 255, 255, 0);
	color: gray;
	padding: 20px 16px;
}

#login1:hover, #regist:hover, #find:hover {
	border-width: 2px;
}

.container table th, td {
	padding: 10px;
}

.h {
	border-style: none;
	position: absolute;
	left: 50%;
}
</style>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="h">
			<h2>로그인</h2>
		</div>
		<form method="post" action="UserLoginPro.mall" onsubmit="return chk()">
			<!-- List에서 왔을 수도 있으므로 이건 들고 있는다. -->
			<input type="hidden" value="${gender }" name="gender"> <input
				type="hidden" value="${top_category }" name="top_category">
			<input type="hidden" value="${middle_category }"
				name="middle_category">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" id="id" required="required">
					</td>
				</tr>
				<tr>
					<th>PW</th>
					<td><input type="password" name="pw" id="pw"
						required="required"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" name="find"
						onclick="goFind()" value="ID/PW찾기" id="find" class="btn btn-sm">
						<input type="button" name="regist" onclick="goRegist()"
						value="회원가입" id="regist" class="btn btn-sm"></td>
				</tr>
			</table>

			<input type="submit" required="required"
				class="submit btn btn-info btn-lg" value="로그인" id="login1">

		</form>
	</div>
	<script type="text/javascript">
		function chk() {
			var id = document.getElementById("id");
			var pw = document.getElementById("pw");
			if (id.value == "" || id.length == 0) {
				alert("ID를 입력해주세요.");
				return false;
			}
			if (pw.value == "" || pw.length == 0) {
				alert("PW를 입력해주세요.");
				return false;
			}
		}
		function goFind() {
			location.href = "userFindId.mall";
		}
		function goRegist() {
			location.href = "UserRegistForm.mall";
		}
	</script>
</body>
</html>