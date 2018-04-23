<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>

<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	
		$(function(){
			$('input[type="checkbox"]').bind('click',function(){
				$('input[type="checkbox"]').not(this).prop("checked",false);
			});
		})

function displayButton(){
			var checkIt=$("#del:checked").length;
			if(checkIt==0){
				$('#submitB').hide();				
			}else $('#submitB').show(); 
			
		}
</script>

</head>

<body>

	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main" class="main">
	<h1>회원 목록</h1>
		<form action="userAdminList.admin" method="post">
 		<div class="mainH" >
 				등급: 
				<input type="text" name="search"> 
				<input type="submit" class="btn mini" value="검색">
			</div>
		</form>
			<br>
			<br>
	<form action="userAdminDeletePro.admin?pageNum=${pageNum }&search=${search}" method="post">
		<table class="table" border="1" id="deleteMember">
			<tr>
				<th class="th">회원ID</th>
				<th class="th">성명</th>
				<th class="th">생년월일</th>
				<th class="th">연락처</th>
				<th class="th">이메일</th>
				<th class="th">등급</th>
				<th class="th">삭제</th>
			</tr>

	       
			<c:if test="${count>0 }">
				<c:forEach var="user" items="${dto }">
					<tr>
						<td>
						<a href="#" 
						onclick="javascript:window.open('AdminUserModifyPopUp.admin?id=${user.id}&pageNum=${pageNum}&popup','회원수정', 'width=500, height=500')">
						${user.id }</a></td>
						<td>${ user.nm}</td>
						<td>${ user.birth}</td>
						<td>${ user.tel}</td>
						<td>${ user.email}</td>
						<td>
							<c:if test="${user.grade=='G0' }"> 브론즈</c:if>
							<c:if test="${user.grade=='G1' }"> 실버</c:if>
							<c:if test="${user.grade=='G2' }"> 골드</c:if>
							<c:if test="${user.grade=='G3' }"> 플라티넘</c:if>
							<c:if test="${user.grade=='G4' }"> 다이아</c:if>
							<c:if test="${user.grade=='G5' }"> VIP</c:if>
							<c:if test="${user.grade=='GG' }"> 탈퇴</c:if>
						</td>
						<td><input type="checkbox" name="del" id="del" value="${user.id }" onclick="displayButton()"></td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${count==0 }">
				<tr>
					<td colspan=8>no data exists</td>
				</tr>
			</c:if>
			
			
			</table>
			<br>

 		<div class="pagination" >
			<c:if test="${startPage > blockSize }">
				<a class="a" href='userAdminList.admin?pageNum=${startPage-blockSize }&search=${search}'>« Prev</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a class="a active" href='userAdminList.admin?pageNum=${i}&search=${search}'> ${i}</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a class="a" href='userAdminList.admin?pageNum=${startPage+blockSize }&search=${search}'>Next »</a>
			</c:if>
 		</div>
	
 		<div class="mainF" >
				<input type="submit" class="btn mini" value="삭제" id="submitB" style="display:none;"> 
				<input type="reset"  class="btn mini" value="취소">
			</div>
		</form>
	</div>
</body>
</html>