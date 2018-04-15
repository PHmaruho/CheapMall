<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
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
                document.getElementById('addr_detail').focus();
            }
        }).open();
    }
    function returnMyPage(){
    	location.href="UserMyPageForm.mall"
    }
</script>
</head>
<body>
<div class="formDiv">
	<form action="UserModifyPro.mall" method="post">
		<table border="1">
			<tr>
				<th> ID </th>
				<td>
					${usersDto.id }
					<!-- 나중에 세션값을 출력한다. 지금은 임의로 지정한다. -->
					<input type="hidden" value="${usersDto.id }" name="id">
				</td>
			</tr>
			<tr>
				<th> 이름 </th>
				<td>
					<input type="text" value="${usersDto.nm }" id="name" name="nm">
				</td>
			</tr>
			<tr>
				<th> 생년월일 </th>
				<td>
					<input type="text" value="${usersDto.birth }" id="birth" name="birth">
				</td>
			</tr>
			<tr>
				<th> 전화번호 </th>
				<td>
					<select name="tel">
						<c:if test="${fn:substring(usersDto.tel, 0, 3) == '010'}">
							<option value="010" selected="selected">010</option>
							<option value="016">016</option>
							<option value="017">017</option>
						</c:if>
						<c:if test="${fn:substring(usersDto.tel, 0, 3) == '016'}">
							<option value="010">010</option>
							<option value="016" selected="selected">016</option>
							<option value="017">017</option>
						</c:if>
						<c:if test="${fn:substring(usersDto.tel, 0, 3) == '017'}">
							<option value="010">010</option>
							<option value="016">016</option>
							<option value="017" selected="selected">017</option>
						</c:if>
					</select> -
					<c:if test="${fn:length(usersDto.tel) < 11 }">
						<input type="text" value="${fn:substring(usersDto.tel, 3, 6)}" max="4" id="tel1" name="tel1"> -
						<input type="text" value="${fn:substring(usersDto.tel, 6, 10)}" max="4" id="tel2" name="tel2">  
					</c:if>
					<c:if test="${fn:length(usersDto.tel) >= 11}">
						<input type="text" value="${fn:substring(usersDto.tel, 3, 7)}" max="4" id="tel1" name="tel1"> - 
						<input type="text" value="${fn:substring(usersDto.tel, 7, 11)}" max="4" id="tel2" name="tel2"> 
					</c:if>
				</td>
			</tr>
			<tr>
				<th rowspan="2"> 주소 </th>
				<td>
					<input type="text" width="6" value="${usersDto.zipcode }" id="zipcode" name="zipcode">
					<input type="button" value="우편번호찾기" onclick="findZipcode()">
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" width="30" value="${usersDto.addr }" id="addr" name="addr">
				</td>
			</tr>
			<tr>
				<th> 상세주소 </th>
				<td>
					<input type="text" width="30" value="${usersDto.addr_detail }" id="addr_detail" name="addr_detail">
				</td>
			</tr>
			<tr>
				<th> 이메일 </th>
				<td>
					<input type="email" value="${usersDto.email }" id="email" name="email">
				</td>
			</tr>
			<tr>
				<th> 성별 </th>
				<td>
					<c:if test="${usersDto.gender eq 'M' }">
						<input type="radio" name="gender" id="M" checked="checked" value="M"> 남자
						<input type="radio" name="gender" id="F" value="여자" value="F"> 여자
					</c:if>
					<c:if test="${usersDto.gender eq 'F' }">
						<input type="radio" name="gender" id="M" value="M"> 남자
						<input type="radio" name="gender" id="F" checked="checked" value="F"> 여자
					</c:if>
				</td>
			</tr>
			<tr>
				<th> 등급 </th>
				<td>
					<c:if test="${usersDto.grade eq 'G0' }">
						Bronze
					</c:if>
					<c:if test="${usersDto.grade eq 'G1' }">
						Silver
					</c:if>
					<c:if test="${usersDto.grade eq 'G2' }">
						Gold
					</c:if>
					<c:if test="${usersDto.grade eq 'G3' }">
						Platinum
					</c:if>
					<c:if test="${usersDto.grade eq 'G4' }">
						Diamond
					</c:if>
					<c:if test="${usersDto.grade eq 'G5' }">
						VIP
					</c:if>
				</td>
			</tr>
			<tr>
				<th> 포인트 </th>
				<td>
					포인트 : ${usersDto.point }
				</td>
			</tr>
			<tr style="align:center;">
				<td colspan="2">
					<input type="submit" value="변경하기">
					<input type="button" value="취소하기" onclick="returnMyPage()">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>