<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript">
	function chk(){
		if(frm.pw.value.length < 4 || frm.pw.value.length > 20){
			alert("비밀번호를 4~20이내로 입력해주세요.");
			frm.pw.focus();
			frm.pw.value="";
			return false;
		}
		
		if(frm.pw.value != frm.pw_r.value){
			alert("비밀번호 확인이 다릅니다.");
			frm.pw.focus();
			frm.pw_r.value="";
			return false;
		}
		
		var checkPwUpper = 0;
		for(var i=0; i<frm.pw.value.length ; i++){
			if(frm.pw.value.charAt(i) == frm.pw.value.charAt(i).toUpperCase()){
				checkPwUpper += 1;
				break;
			}
		}
		
		if(checkPwUpper == 0){
			alert("비밀번호 형식에 맞지않습니다.");
			frm.pw.value = "";
			frm.pw_r.value ="";
			frm.pw.focus();
			return false;
		}
		
		// 문자가 최소 3개 이상 들어가게 한다.
		checkPwUpper = 0;
		for(var i=0 ; i<v_pw.value.length ; i++){
			var asciiset = v_pw.value.charCodeAt(i);
			if((asciiset >= 65 && asciiset <= 90) || (asciiset >= 97 && asciiset <= 122)){
				checkPwUppder += 1;
			}
		}
		if(checkPwUpper < 3){
			alert("비밀번호 형식에 맞지않습니다.");
			v_pw.value = "";
			frm.pw2.value ="";
			v_pw.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<h1>비밀번호 변경일로부터 90일 이상 경과했습니다.</h1>
	<form action="userChangePwDtPro.mall" method="post" name="frm" onsubmit="return chk()">
	<table border="1" id="chkTable2">
		<tr>
			<td> 새로운 비밀번호 입력 : </td>
			<td>
				<input type="password" name="pw" id="pw">
			</td>
		</tr>
		<tr>
			<td> 비밀번호 재확인 : </td>
			<td>
				<input type="password" name="pw_r" id="pw_r">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="변경하기">
				<input type="button" id="cancle2" value="다음에 변경하기" onclick="location.href='cheapmall.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>