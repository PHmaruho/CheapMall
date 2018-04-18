<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
.container {
	position: relative;
	border-style: none;
}

form {
	border-style: none;
}

#find {
	position: absolute;
	left: 140px;
	top: 80px;
}

#regist {
	position: absolute;
	left: 40px;
	top: 80px;
}

table {
	position: absolute;
	left: 400px;
	top: 50px;
	display: inline-block;
}

.submit {
	border-style: none;
	position: absolute;
	left: 650px;
	top: 60px;
}

.container table th, td {
	padding: 10px;
}

.h {
	border-right-style: none;
	border-left-style: none;
	border-top-style: none;
	border-bottom-width: 3px;
}
</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="h">
		<h2>로그인</h2>
	</div>
	<div class="container">
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
				class="submit btn btn-info btn-lg" value="로그인">

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
			location.href = "index_CWI_2.jsp";
		}
		function goRegist() {
			location.href = "UserRegistForm.mall";
		}
	</script>
</body>
</html>