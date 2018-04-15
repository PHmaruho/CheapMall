<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js">
function chk() {
	
	if(frm.pw.value != frm.pw2.value) {
		alert("암호가 다릅니다");
		frm.pw.focus();
		return false;
	}
	return true;
}
function winop() {
	if(!frm.id.value) {
		alert("ID를 입력하세요");
		frm.id.focus();
		return false;
	}
	window.open("confirmId.jsp?id="+frm.id.value,"","width=300 height=300");
}

function selectEmail(ele){ var $ele = $(ele); 
var $email2 = $('input[name=email2]'); 
// '1'인 경우 직접입력 
if($ele.val() == "1"){ 
	$email2.attr('readonly', false); 
	$email2.val(''); 
	} else { 
		$email2.attr('readonly', true); 
		$email2.val($ele.val()); } }

			</script>

</head>
<body>
<div id = "wrap">
<%
             if(session.getAttribute("auth")!=null && session.getAttribute("auth").equals("A0")){
                %>
                <jsp:include page="adminMenuList.jsp" />
      <% } %>
</div>

<div id="main">
<h3>관리자 등록</h3>
<form action="AdminInsertPro.admin?pageNum=${pageNum }" name="frm" onsubmit="return chk()" >
<table border="1" >
<tr>
	<td>ID</td>
	<td><input type="text" name="id" required="required">
	<a href="#" class="a" onclick="winop()"></a></td>
	</tr>
	<tr>
	<td>PASSWORD</td>
	<td><input type="password" name="pw" required="required"></td>
	</tr>
	<tr>
	<td>PASSWD CHECK</td>
	<td><input type="password" name="pw2" required="required"></td>
	<tr>
	<td>성명</td>
	<td><input type="text" name="nm" required="required"></td>
	</tr>
	<tr>
	<td>부서</td>
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
	<td>직급</td>
	<td><select name="position">
	<option value="사장">사장</option>
	<option value="이사">이사</option>
	<option value="실장">실장</option>
	<option value="과장">과장</option>
	<option value="주임">주임</option>
	<option value="사원">사원</option>
	</select>
	</tr>
	<tr><td>사번</td>
	<td><input type="text" name="emp_no" required="required"></td>
	</tr>
	<tr><td>권한</td>
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
	
	<tr><td>Tel</td>
	<td><input type="tel" name="tel" required="required">
	<!-- pattern="\d{3}-\d{3,4}-\d{4}" placeholder="xxx-xxxx-xxxx"
				title="3자리-3,4자리-4자리"	> --></td>
	</tr>
	
	<tr><td>Email</td>
		<td><input name="email1" type="text"> @ <input name="email2" type="text"> 
			<select name="select_email" onChange="selectEmail(this)">
			<option value="" selected>직접입력</option> 
			<option value="naver.com" selected>naver.com</option> 
			<option value="hanmail.net">hanmail.net</option> 
			<option value="hotmail.com">hotmail.com</option> 
			<option value="nate.com">nate.com</option> 
			<option value="yahoo.co.kr">yahoo.co.kr</option> 
			<option value="empas.com">empas.com</option> 
			<option value="dreamwiz.com">dreamwiz.com</option> 
			<option value="freechal.com">freechal.com</option> 
			<option value="lycos.co.kr">lycos.co.kr</option> 
			<option value="korea.com">korea.com</option> 
			<option value="gmail.com">gmail.com</option> 
			<option value="hanmir.com">hanmir.com</option> 
			<option value="paran.com">paran.com</option> </select>
	   </td>
   </tr>
   
   <tr><td>사진 경로</td>
   	<td><input type="text" name="path" required="required"></td>
   </tr>


      
  <tr><td><input type="reset" value="Reset" ></td>
	<td><input type="submit" value="Complete" ></td></tr>
		
		 </table>
	   </form>
	   </div> 
		
	   
	<div id="footer">
		<ul>
			<li><a class="a" href="AdminForm.admin">back</a></li>
			<li><a href="#" class="a" type="reset">Reset</a></li>
			<li>
				<a class="a" type="submit" onclick="location.href='AdminInsertPro.admin?pageNum=${pageNum }'">Complete</a>
			</li>	
		</ul>
	</div>
       
</body>
</html>