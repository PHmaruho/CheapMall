<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css" type="text/css">
<style type="text/css">
table {
	width : 100%;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
function chk() {
	
	if(frm.pw.value != frm.pw2.value) {
		alert("암호가 다릅니다");
		frm.pw2.focus();
		return false;
	}
	return true;
}

//이메일 입력방식 선택 
function SetEmailTail(emailValue) {
  var email = document.all("email")    // 사용자 입력
  var emailTail = document.all("email2") // Select box
   
  if ( emailValue == "notSelected" )
   return;
  else if ( emailValue == "etc" ) {
   emailTail.readOnly = false;
   emailTail.value = "";
   emailTail.focus();
  } else {
   emailTail.readOnly = true;
   emailTail.value = emailValue;
  }
 }

			</script>

</head>
<body>
<div id = "wrap">
	<c:if test="${auth eq 'A0' }">
                <jsp:include page="adminMenuList.jsp" />
     </c:if>
</div>

	<div id="main" class="main">
<h3>관리자 등록</h3>
<form action="AdminInsertPro.admin?pageNum=${pageNum }" name="frm" onsubmit="return chk()" >
<input type="hidden" name="pageNum" value="${pageNum }">

		<table class="table" border="1" >
			<tr class="tr">
	<th class="th">ID</th>
	<td><input type="text" name="id" required="required">
	<a href="#" class="a" onclick="winop()"></a></td>
	</tr>
	<tr>
	<th class="th">PASSWORD</th>
	<td><input type="password" name="pw" required="required"></td>
	</tr>
	<tr>
	<th class="th">PASSWD CHECK</tj>
	<td><input type="password" name="pw2" required="required"></td>
	<tr>
	<th class="th">성명</th>
	<td><input type="text" name="nm" required="required"></td>
	</tr>
	<tr>
	<th class="th">부서</th>
	<td><select name="dept">
	<option value="인사">인사</option>
	<option value="회계">회계</option>
	<option value="영업">영업</option>
	<option value="물류">물류</option>
	<option value="유지보수">유지보수</option>
	</select>
	</td>
	</tr>
	<tr>
	<th class="th">직급</th>
	<td><select name="position">
	<option value="사장">사장</option>
	<option value="이사">이사</option>
	<option value="실장">실장</option>
	<option value="과장">과장</option>
	<option value="주임">주임</option>
	<option value="사원">사원</option>
	</select>
	</tr>
	<tr><th class="th">사번</th>
	<td><input type="text" name="emp_no" required="required"></td>
	</tr>
	<tr><th class="th">권한</th>
	<td><select name="auth">
	<option value="A0">관리자 관리(최종)</option>
	<option value="A1">회원 관리</option>
	<option value="A5">상품 관리</option>
	<option value="A3">코드 관리</option>
	<option value="A2">검색어 관리</option>
	<option value="A4">통계 관리</option>
	</select>
	</td>
	</tr>
	
	<tr><th class="th">Tel</th>
	<td><input type="tel" name="tel" required="required">

	</tr>
	
	<tr><th class="th">Email</th>
		<td><input type="text" name="email1" value="" /> @
	<input type="text" name="email2" value="" ReadOnly="true"/>
	<select name="emailCheck" 
	onchange="SetEmailTail(emailCheck.options[this.selectedIndex].value)">
    <option value="notSelected" >::선택하세요::</option>
    <option value="etc">직접입력</option>
    <option value="naver.com">naver.com</option>
    <option value="nate.com">nate.com</option>
    <option value="empal.com">empal.com</option>
    <option value="hotmail.com">hotmail.com</option>
    <option value="lycos.co.kr">lycos.co.kr</option>
    <option value="msn.com">msn.com</option>
    <option value="hanmail.net">hanmail.net</option>
    <option value="yahoo.com">yahoo.com</option>
    <option value="korea.com">korea.com</option>
    <option value="kornet.net">kornet.net</option>
    <option value="yahoo.co.kr">yahoo.co.kr</option>
    <option value="kebi.com">kebi.com</option>
    <option value="orgio.net">orgio.net</option>
    <option value="paran.com">paran.com</option>    
    <option value="gmail.com">gmail.com</option>
   </select>
	   </td>
   </tr>
   	</table>
  	<br>
  	 <div class="mainF" >
			<input type="button" class="btn mini" onclick="location.href='AdminForm.admin'" value="뒤로가기">
		  	<input type="reset" class="btn mini" value="초기화" >
			<input type="submit"  class="btn mini" value="등록하기" >
	</div>
</form>
</div> 
		
</body>
</html>