<%@page import="com.cheapmall.dto.AdminDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	width: 100%;
}

td {
	text-align: center;
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

</script>
</head>
<body>
	<h3>관리자 수정</h3>
	<form action="AdminUpdatePro.admin" method="post" name="frm" onsubmit="return chk()" >
		<table border="1">

			<tr>
				<th>ID</th>
				<td>${adminDto.id } <input type="hidden"
					value="${adminDto.id }" name="id">
				</td>
			</tr>

			<tr>
				<th>PASSWORD</th>
				<td><input type="password" name="pw"class="inputText">
				</td>
			</tr>
			<tr>
				<th>PW CHECK</th>
				<td><input type="password" name="pw2"class="inputText" ></td>
			</tr>
			<tr>
				<th>성 명</th>
				<td><input type="text" value="${adminDto.nm }" name="nm"
					id="nm" class="inputText"></td>
			</tr>
			<tr>
				<th>부 서</th>
				<td><select name="dept" class="selectBox">
						<c:if test="${adminDto.dept eq '인사' }">
							<option value="인사" selected="selected">인사</option>
							<option value="회계">회계</option>
							<option value="영업">영업</option>
							<option value="물류">물류</option>
							<option value="유지보수">유지보수</option>
						</c:if>
						<c:if test="${adminDto.dept eq '회계' }">
							<option value="인사">인사</option>
							<option value="회계" selected="selected">회계</option>
							<option value="영업">영업</option>
							<option value="물류">물류</option>
							<option value="유지보수">유지보수</option>
						</c:if>
						<c:if test="${adminDto.dept eq '영업' }">
							<option value="인사">인사</option>
							<option value="회계">회계</option>
							<option value="영업" selected="selected">영업</option>
							<option value="물류">물류</option>
							<option value="유지보수">유지보수</option>
						</c:if>
						<c:if test="${adminDto.dept eq '물류' }">
							<option value="인사">인사</option>
							<option value="회계">회계</option>
							<option value="영업">영업</option>
							<option value="물류" selected="selected">물류</option>
							<option value="유지보수">유지보수</option>
						</c:if>
						<c:if test="${adminDto.dept eq '유지보수' }">
							<option value="인사">인사</option>
							<option value="회계">회계</option>
							<option value="영업">영업</option>
							<option value="물류">물류</option>
							<option value="유지보수" selected="selected">유지보수</option>
						</c:if>
				</select></td>
			</tr>
			<tr>
				<th>직 급</th>
				<td><select name="position" class="selectBox">
						<c:if test="${adminDto.position eq '사장' }">
							<option value="사장" selected="selected">사장</option>
							<option value="이사">이사</option>
							<option value="실장">실장</option>
							<option value="과장">과장</option>
							<option value="주임">주임</option>
							<option value="사원">사원</option>
							<option value="팀장">팀장</option>
						</c:if>
						<c:if test="${adminDto.position eq '이사' }">
							<option value="사장">사장</option>
							<option value="이사" selected="selected">이사</option>
							<option value="실장">실장</option>
							<option value="과장">과장</option>
							<option value="주임">주임</option>
							<option value="사원">사원</option>
							<option value="팀장">팀장</option>
						</c:if>
						<c:if test="${adminDto.position eq '실장' }">
							<option value="사장">사장</option>
							<option value="이사">이사</option>
							<option value="실장" selected="selected">실장</option>
							<option value="과장">과장</option>
							<option value="주임">주임</option>
							<option value="사원">사원</option>
							<option value="팀장">팀장</option>
						</c:if>
						<c:if test="${adminDto.position eq '팀장' }">
							<option value="사장">사장</option>
							<option value="이사">이사</option>
							<option value="실장">실장</option>
							<option value="과장">과장</option>
							<option value="주임">주임</option>
							<option value="사원">사원</option>
							<option value="팀장" selected="selected">팀장</option>
						</c:if>
						<c:if test="${adminDto.position eq '과장' }">
							<option value="사장">사장</option>
							<option value="이사">이사</option>
							<option value="실장">실장</option>
							<option value="과장" selected="selected">과장</option>
							<option value="주임">주임</option>
							<option value="사원">사원</option>
							<option value="팀장">팀장</option>
						</c:if>
						<c:if test="${adminDto.position eq '주임' }">
							<option value="사장">사장</option>
							<option value="이사">이사</option>
							<option value="실장">실장</option>
							<option value="과장">과장</option>
							<option value="주임" selected="selected">주임</option>
							<option value="사원">사원</option>
							<option value="팀장">팀장</option>
						</c:if>
						<c:if test="${adminDto.position eq '사원' }">
							<option value="사장">사장</option>
							<option value="이사">이사</option>
							<option value="실장">실장</option>
							<option value="과장">과장</option>
							<option value="주임">주임</option>
							<option value="사원" selected="selected">사원</option>
							<option value="팀장">팀장</option>
						</c:if>

				</select></td>
			</tr>
			<tr>
				<th>권 한</th>
				<td><select name="auth" class="selectBox">
						<c:if test="${adminDto.auth eq 'A0' }">
							<option value="A0" selected="selected">관리자 관리(최종)</option>
							<option value="A1">회원 관리</option>
							<option value="A2">검색어 관리</option>
							<option value="A3">코드 관리</option>
							<option value="A4">통계 관리</option>
							<option value="A5">상품 관리</option>
						</c:if>
						<c:if test="${adminDto.auth eq 'A1' }">
							<option value="A0">관리자 관리(최종)</option>
							<option value="A1" selected="selected">회원 관리</option>
							<option value="A2">검색어 관리</option>
							<option value="A3">코드 관리</option>
							<option value="A4">통계 관리</option>
							<option value="A5">상품 관리</option>
						</c:if>
						<c:if test="${adminDto.auth eq 'A2' }">
							<option value="A0">관리자 관리(최종)</option>
							<option value="A1">회원 관리</option>
							<option value="A2" selected="selected">검색어 관리</option>
							<option value="A3">코드 관리</option>
							<option value="A4">통계 관리</option>
							<option value="A5">상품 관리</option>
						</c:if>
						<c:if test="${adminDto.auth eq 'A3' }">
							<option value="A0">관리자 관리(최종)</option>
							<option value="A1">회원 관리</option>
							<option value="A2">검색어 관리</option>
							<option value="A3" selected="selected">코드 관리</option>
							<option value="A4">통계 관리</option>
							<option value="A5">상품 관리</option>
						</c:if>
						<c:if test="${adminDto.auth eq 'A4' }">
							<option value="A0">관리자 관리(최종)</option>
							<option value="A1">회원 관리</option>
							<option value="A2">검색어 관리</option>
							<option value="A3">코드 관리</option>
							<option value="A4" selected="selected">통계 관리</option>
							<option value="A5">상품 관리</option>
						</c:if>
						<c:if test="${adminDto.auth eq 'A5' }">
							<option value="A0">관리자 관리(최종)</option>
							<option value="A1">회원 관리</option>
							<option value="A2">검색어 관리</option>
							<option value="A3">코드 관리</option>
							<option value="A4">통계 관리</option>
							<option value="A5" selected="selected">상품 관리</option>
						</c:if>
				</select></td>
			</tr>

			<tr>
				<th>Tel</th>
				<td><input type="tel" name="tel" value="${adminDto.tel }"
					class="inputText">
			</tr>

			<tr>
				<th>Email</th>
				<td><input type="email" value="${adminDto.email }" id="email"
					name="email" class="inputText"></td>
			</tr>

			<tr>
				<th>사진경로</th>
				<td><input type="text" value="${adminDto.path }" name="path"
					class="inputText"></td>
			</tr>

			<tr>
				<td colspan="2">
				<input type="submit" value="수정하기" >
				<input type="button" value="닫기" onclick="" id="exitButton"></td>
			</tr>
		</table>
	</form>
</body>
</html>