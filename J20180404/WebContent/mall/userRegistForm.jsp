<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
table {
	background-color: pink;
}
</style>
<style>
	h1{font-size:3em;}
	
</style>
<script src="../js/jquery.js"></script>
<link href="../js/jquery-ui.css" rel="stylesheet">
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script type="text/javascript">
	function chk() {
		var v_id = frm.id;
		if (document.getElementById('checkId').value == '0'){
			alert("ID 중복체크를 확인해 주세요.");
			return false;
		}
		
		var v_pw = frm.pw;
		if (v_pw.value != frm.pw2.value) {
			alert("암호가 다릅니다");
			v_pw.focus();
			return false;
		}
		
		var checkPwUpper = 0;
		for(var i=0; i<v_pw.value.length ; i++){
			if(v_pw.value.charAt(i) == v_pw.value.charAt(i).toUpperCase()){
				checkPwUpper += 1;
				break;
			}
		}
		if(checkPwUpper == 0){
			alert("비밀번호 형식에 맞지않습니다.");
			v_pw.value = "";
			frm.pw2.value ="";
			v_pw.focus();
			return false;
		}
		
		return true;
	}
	function winop() {
		var v_id = frm.id;
		if (!v_id.value) {
			alert("id를 입력 후 중복확인을 눌러주세요.");
			v_id.focus();
			return false;
		}
		if(v_id.value.length < 4 || !v_id.value.length > 16){
			alert("4자이상 16미만으로 작성해주세요.");
			v_id.focus();
			return false;
		}
		
		for(var i=0 ; i<v_id.value.length ; i++){
			if(v_id.value.charAt(i) == v_id.value.charAt(i).toUpperCase()){
				alert("대문자가 포함되면 안됩니다.");
				v_id.focus();
				return false;
			}
		}
		
		// ajax
		$.ajax({
			type:"POST",
			url: "UserIdCompareAjax.mall",
			data:{id:v_id.value},
			success: function(data){
				var json = JSON.parse(data);
				if(json.result == 'yes'){
					$('#idChk').html("");
					$('#idChk').html("이미 존재합니다.");
					$('#checkId').val("0"); // 0은 중복체크 미완료, 아이디변경됨
				} else {
					$('#idChk').html("");
					$('#idChk').html("사용 가능합니다.");
					$('#checkId').val("1"); // 1은 중복체크 완료
				}
			}
		});
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function findZipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr_detail').readOnly = false;
                document.getElementById('addr_detail').focus();
            }
        }).open();
    }
    function returnMyPage(){
    	location.href="UserMyPageForm.mall"
    }
    
    function datePic(){
    	$('#birth').datepicker({
    		changeMonth: true, 
            changeYear: true,
            nextText: '다음 달',
            prevText: '이전 달',
            dateFormat: 'yy-mm-dd'
    	});
    }
</script>
</head>
<body>
  <form action="UserRegistPro.mall" name="frm" onsubmit="return chk()">
  	<input type="hidden" value="0" id="checkId">
	
	<div style="text-align:center">
	<h1><strong>JOIN US</strong></h1>
	<h2>회원가입</h2></div>
	
	<h3>기본 정보(<span style="color:orange">◎</span>)필수 입력사항</h3>
		<table border="1">
		<colgroup>
			<col style="background:#EDCE7A"></colgroup> 
			<tr>
				<td><span style="color:orange">◎</span>아이디</td>
				<td><input type="text" name="id" placeholder="ID를 입력하세요" autofocus required="required" onkeyup="">
				<input type="button" onclick="winop()" style="background-color:#EDCE7A" value="아이디 중복확인"><div id="idChk"></div>(영,&nbsp;소문자/숫자,&nbsp;4~16자)</td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>비밀번호</td>
				<td><input type="password" name="pw" placeholder="비번을 입력하세요" maxlength="8" required="required">(영문&nbsp;대소문자/숫자&nbsp;4~20자)</td>
				
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>비밀번호 확인</td>
				<td><input type="password" name="pw2" placeholder="비번을 재입력하세요" maxlength="8" required="required"></td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>이름</td>
				<td><input type="text" name="nm" required="required"></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;주소</td>
				<td><input type="text" name="addtext1" id="zipcode" readonly="readonly" onclick="findZipcode()">
					<input type="button" onclick="findZipcode()" style="background-color:#EDCE7A"><br>
					<input type="text" name="addtext2" id="addr" readonly="readonly"><br>
					<input type="text" name="addtext3" id="addr_detail" placeholder="상세주소" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>휴대전화</td>
				<td>
					<select name="tel1">
						<option value="010" selected="selected">010</option>
						<option value="016">016</option>
						<option value="017">017</option>
					</select>
					-
					<input type="tel" name="tel2" required="required" pattern="\d{3,4}">
					-
					<input type="tel" name="tel3" required="required" pattern="\d{4}">
				</td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>이메일</td>
				<td><input type="text" name="mail" required></td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>생년월일</td>
				<td>
					<input type="text" name="birth" id="birth" onclick="datePic()" required="required">
				</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;성별</td>
				<td>
					<input type="radio" name="gender" id="M" checked="checked" value="M" class="inputText"> 남자
					<input type="radio" name="gender" id="F" value="F" class="inputText"> 여자
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="회원가입">
					<input type="reset" value="초기화">
					<input type="button" value="가입취소" onclick="">
				</td>
			</tr>
		</table>
  </form>	
</body>
</html>