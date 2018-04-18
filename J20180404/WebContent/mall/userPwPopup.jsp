<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">

	// 비밀번호 확인
	function check(){
		var pw = $('#pwd');
		
		$.ajax({
			type: "POST",
			url: "UserChkPwAjax.mall",
			data: {pw:pw.val()},
			success: function(data){
				var result = JSON.parse(data);
				if(result.value == 0){
					alert("비밀번호가 일치하지않습니다.");
					pw.val("");
					return;
				} else if(result.value == 1){
					alert("기존 비밀번호가 확인되었습니다.");
					$('#chkTable1').css("display", "none");
					$('#chkTable2').css("display", "block");
				}
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
	
	// form 전송 전, 체크확인
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
	}
	
	// 취소
	function cancle(){
		window.close();
	}
</script>
</head>
<body>
<h2>비밀번호 변경</h2>
<table border="1" id="chkTable1">
	<tr>
		<td>현재 비밀번호 : </td>
		<td>
			<input type="password" name="pwd" id="pwd">
			<input type="button" id="btncheck" value="비밀번호 확인" onclick="check()">
			<input type="button" id="cancle1" value="취소하기" onclick="cancle()">
		</td>
	</tr>
</table>

<form action="UserChkPwAjax.mall?check=yes" method="post" name="frm" onsubmit="return chk()">
	<table border="1" style="display:none;" id="chkTable2">
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
				<input type="button" id="cancle2" value="취소하기" onclick="cancle()">
			</td>
		</tr>
	</table>
</form>

</body>
</html>