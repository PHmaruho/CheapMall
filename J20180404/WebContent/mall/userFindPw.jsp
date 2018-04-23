<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	var setTime;
	var tid;
	var key='00000000000';	// 랜덤키는 최대 10자리, 입력 가능한 키도 최대 10자리이기때문에 일치하는 일이 없도록 11자리
	
	function okBtn() {
		var id = $('#id').val();
		var email = $('#email').val();
		
		$.ajax({
			type : "post",
			url : "userFindPwCheckAjax.mall",
			data : {"id":id, "email":email},
			success : function(a) {
				$('#test').html(a); 
			}
		});
	}
	
	function certBtn() {
		var email = $('#email').val();
		
		$.ajax({
			type : "post",
			url : "userSendEmail.mall",
			data : {"email":email},
			success : function(a) {
				$('#test2').html(a); 
			}
		});
		timerStart();
	}
		
	function timer() {
		var m = Math.floor(setTime / 60) + "분 " + (setTime % 60) + "초";
		var msg = "<font color='red'>" + m + "</font>";
		document.all.timer.innerHTML = msg;
		setTime--;

		if (setTime < 0) {
			clearInterval(tid);
			key = "11111111111";
		}
	}
	
	function timerStart() {
		clearInterval(tid);
		setTime = 30;	// 타이머 시간 설정
		tid=setInterval('timer()',1000)
	}
	
	function checkKey() {
		var userKey = $('#userKey').val();
		
		if (key == "00000000000") {
			alert("인증번호를 요청하세요.");
		} else if (key == "11111111111") {
			alert("만료된 인증번호입니다.");
		} else if (key == userKey) {
			alert("확인되었습니다.");
			var id = $('#id').val();
			var email = $('#email').val();
			location.href="userFindPwResultForm.mall?id="+ id +"&email=" + email;
		} else {
			alert("인증번호가 일치하지 않습니다.");
		}
	}
</script>
</head>
<body>
	<label>아이디</label><input type="text" id="id"><br>
	<label>이메일</label><input type="text" id="email">
	<input type="button" value="인증번호 요청" onclick="okBtn()"><br>
	<label>인증번호</label><input type="text" id="userKey" disabled="disabled"><div id="timer"></div><br>
	<input type="button" value="확인" id="checkKey" onclick="checkKey()"><br>
	<div id ="test"></div>
	<div id ="test2"></div>
</body>
</html>