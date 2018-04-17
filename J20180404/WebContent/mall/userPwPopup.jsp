<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	function check(){
		var pw = $('#pw').val();
		
		$.ajax({
			type: "POST",
			url: "";
		});
	}
</script>
</head>
<body>
<h2>비밀번호 변경</h2>
<table border="1">
	<tr>
		<td>현재 비밀번호 : </td>
		<td>
			<input type="password" name="pw" id="pw">
			<input type="button" id="btncheck" value="비밀번호 확인" onclick="check()">
		</td>
	</tr>
</table>
</body>
</html>