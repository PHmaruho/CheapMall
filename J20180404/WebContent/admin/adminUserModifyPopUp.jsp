<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	// 로드시 모든 요소를 비활성화 시킨다.
	window.onload = function(){
		var input = document.getElementsByClassName("inputText");
		for (var items = 0; items < input.length; items++){
	       input[items].disabled=true;
	    }
		document.getElementByClassName("submit").disable=true;
	}
	// 미정!!
	function modifyAction(){
		var input = document.getElementsByClassName("inputText");
		for (var items = 0; items < input.length; items++){
	       input[items].disabled=false;
	    }
		document.getElementById("zipcode").disabled=true;
		document.getElementById("addr").disabled=true;
		document.getElementByClassName("submit").disabled=false;
	}
	
	// onclick
	
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
                document.getElementById('addr_detail').focus();
            }
        }).open();
    }
    function returnMyPage(){
    	location.href="UserMyPageForm.mall"
    }
    
    function check(){
    	var pw = document.getElementById("pw");
    	var pwchk = document.getElementById("pwchk");
    	if(pw.value.length == 0){
    		document.getElementById("pw").value = '${usersDto.pw}';
    	}
    	
    	if(document.getElementById("id").value.length == 0 || 
    			document.getElementById("id").value == ""){
    		alert("1.");
    		document.getElementById("id").focus();
    		return false;
    	}
    	
    	if(document.getElementById("email").value.length == 0){
    		alert("3.");
    		return false;
    	}
    	
    	if(document.getElementById("point").value.length == 0){
    		alert("숫자를 입력해주세요.");
    		return false;
    	}
    	
    	// radio와 select박스 체크
    	// 하지만 필요없다.
    	/* var radioCheck = document.getElementsByName("gender");
    	var i;
    	for (i = 0; i < radioCheck.length; i++) {
			if(radioCheck[i].checked){
				break;
			}
		}
    	if(i == radioCheck.length){
    		alert("둘 중 하나를 체크해주세요!");
    		return false;
    	}
    	
    	var grade = document.getElementsByName("grade");
    	if(document.getElementById("email").value.length == 0){
    		alert("빈칸이 존재합니다.");
    		return false;
    	} */
    	
    	// 길이를 검사하는 function 추가 예정
    	/* if(document.getElementById("id").value.length == 0 || 
    			document.getElementById("id").value == ""){
    		alert("빈칸이 존재합니다.");
    		document.getElementById("id").focus();
    	}
    	
    	....
    	*/
    	
    }
</script>
<body>
<h2>회원 상세 정보</h2>
	<form action="AdminUserModifyPopUpPro.admin?pageNum=${pageNum}" onsubmit="return check()" method="post">
		<table border="1">
			<tr>
				<th>ID</th>
				<td>
					${usersDto.id }
					<input type="hidden" value="${usersDto.id }" name="id" id="id">
				</td>
			</tr>
			<tr>
				<th>회원이름</th>
				<td>
					<input type="text" value="${usersDto.nm }" name="nm" id="nm" class="inputText">
				</td>
			</tr>
			<tr>
				<th id="thPw">PW</th>
				<td>
					<input type="password" name="pw" id="pw" class="inputText">
				</td>
			</tr>
			<tr>
				<th id="thPwChk">PW확인</th>
				<td>
					<input type="password" name="pwchk" id="pwchk" class="inputText">
				</td>
			</tr>
			<tr>
				<th>비밀번호 변경일</th>
				<td>
					${usersDto.pw_dt }
					<input type="hidden" value="${usersDto.pw_dt }" name="pw_dt" id="pw_dt">
				</td>
			</tr>
			<tr>
				<th rowspan="2">주소</th>
				<td>
					<input type="text" width="6" value="${usersDto.zipcode }" id="zipcode" name="zipcode" class="inputText">
					<input type="button" value="우편번호찾기" onclick="findZipcode()" class="inputText">
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" width="30" value="${usersDto.addr }" id="addr" name="addr" class="inputText">
				</td>
			</tr>
			<tr>
				<th>상세주소</th>
				<td>
					<input type="text" width="30" value="${usersDto.addr_detail }" id="addr_detail" name="addr_detail" class="inputText">
				</td>
			</tr>
			<tr>
				<th> 이메일 </th>
				<td>
					<input type="email" value="${usersDto.email }" id="email" name="email" class="inputText">
				</td>
			</tr>
			<tr>
				<th> 성별 </th>
				<td>
					<c:if test="${usersDto.gender eq 'M' }">
						<input type="radio" name="gender" id="M" checked="checked" value="M" class="inputText"> 남자
						<input type="radio" name="gender" id="F" value="F" class="inputText"> 여자
					</c:if>
					<c:if test="${usersDto.gender eq 'F' }">
						<input type="radio" name="gender" id="M" value="M" class="inputText"> 남자
						<input type="radio" name="gender" id="F" checked="checked" value="F" class="inputText"> 여자
					</c:if>
				</td>
			</tr>
			<tr>
				<th> 등급 </th>
				<td>
					<select name="grade" class="inputText">
						<c:if test="${usersDto.grade eq 'G0' }">
							<option value="G0" selected="selected">Bronze</option>
							<option value="G1">Silver</option>
							<option value="G2">Gold</option>
							<option value="G3">Platinum</option>
							<option value="G4">Diamond</option>
							<option value="G5">VIP</option>
						</c:if>
						<c:if test="${usersDto.grade eq 'G1' }">
							<option value="G0">Bronze</option>
							<option value="G1" selected="selected">Silver</option>
							<option value="G2">Gold</option>
							<option value="G3">Platinum</option>
							<option value="G4">Diamond</option>
							<option value="G5">VIP</option>
						</c:if>
						<c:if test="${usersDto.grade eq 'G2' }">
							<option value="G0">Bronze</option>
							<option value="G1">Silver</option>
							<option value="G2" selected="selected">Gold</option>
							<option value="G3">Platinum</option>
							<option value="G4">Diamond</option>
							<option value="G5">VIP</option>
						</c:if>
						<c:if test="${usersDto.grade eq 'G3' }">
							<option value="G0">Bronze</option>
							<option value="G1">Silver</option>
							<option value="G2">Gold</option>
							<option value="G3" selected="selected">Platinum</option>
							<option value="G4">Diamond</option>
							<option value="G5">VIP</option>
						</c:if>
						<c:if test="${usersDto.grade eq 'G4' }">
							<option value="G0">Bronze</option>
							<option value="G1">Silver</option>
							<option value="G2">Gold</option>
							<option value="G3">Platinum</option>
							<option value="G4" selected="selected">Diamond</option>
							<option value="G5">VIP</option>
						</c:if>
						<c:if test="${usersDto.grade eq 'G5' }">
							<option value="G0">Bronze</option>
							<option value="G1">Silver</option>
							<option value="G2">Gold</option>
							<option value="G3">Platinum</option>
							<option value="G4">Diamond</option>
							<option value="G5" selected="selected">VIP</option>
						</c:if>
					</select>
					
				</td>
			</tr>
			<tr>
				<th> 포인트 </th>
				<td>
					<input type="text" value="${usersDto.point }" class="inputText" name="point" id="point">
				</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>${usersDto.reg_dt }</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="수정하기" onclick="modifyAction()">
					<input type="submit" value="제출하기" class="submit" id="submit">
					<input type="button" value="닫기" onclick="" id="exitButton">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>