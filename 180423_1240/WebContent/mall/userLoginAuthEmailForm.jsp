<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	var setTime;
	var tid;
	var key='00000000000';

	function certBtn() {
		var email = '${email}';
		
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
		var id = '${id}';
		var email = '${email}';
		
		if (key == "00000000000") {
			alert("인증번호를 요청하세요.");
		} else if (key == "11111111111") {
			alert("만료된 인증번호입니다.");
		} else if (key == userKey) {
			alert("확인되었습니다.");
			var nm = $('#nm').val();
			var email = $('#email').val();
			location.href="userLoginAuthEmailPro.mall?id="+ id + "&email=" + email;
		} else {
			alert("인증번호가 일치하지 않습니다.");
		}
	}
</script>
</head>
<body>
${email }
	<h1>인증되지 않은 회원입니다.</h1>
	<label>인증번호</label><input type="text" id="userKey">
	<div id="timer"></div>
	<input type="button" value="인증번호 요청" onclick="certBtn()">
	<input type="button" value="확인" onclick="checkKey()">
	<div id ="test"></div>
	<div id ="test2"></div>
</body>
</html>