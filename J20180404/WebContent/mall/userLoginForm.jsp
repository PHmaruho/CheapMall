<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
<h2>회원 로그인</h2>
<form method="post" action="UserLoginPro.mall" onsubmit="return chk()">
	<!-- List에서 왔을 수도 있으므로 이건 들고 있는다. -->
	<input type="hidden" value="${gender }" name="gender">
	<input type="hidden" value="${top_category }" name="top_category">
	<input type="hidden" value="${middle_category }" name="middle_category">
	<table border="1">
		<tr>
			<th>
				ID
			</th>
			<td>
				<input type="text" name="id" id="id" required="required">
			</td>
		</tr>
		<tr>
			<th>
				PW
			</th>
			<td>
				<input type="password" name="pw" id="pw" required="required">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" required="required">
				<input type="button" name="find" onclick="goFind()" value="ID/PW찾기" id="find">
				<input type="button" name="regist" onclick="goRegist()" value="회원가입" id="regist">
			</td>
		</tr>
	</table>
	
</form>
<script type="text/javascript">
	function chk(){
		var id = document.getElementById("id");
		var pw = document.getElementById("pw");
		if(id.value == "" || id.length == 0){
			alert("ID를 입력해주세요.");
			return false;
		}
		if(pw.value == "" || pw.length == 0){
			alert("PW를 입력해주세요.");
			return false;
		}
	}
	function goFind(){
		location.href="index_CWI_2.jsp";
	}
	function goRegist(){
		location.href="UserRegistForm.mall";
	}
</script>
</body>
</html>