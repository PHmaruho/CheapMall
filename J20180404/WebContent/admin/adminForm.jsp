<%@page import="java.awt.Checkbox"%>
<%@page import="com.cheapmall.dto.AdminDto"%>
<%@page import="java.util.List"%>
<%@page import="com.cheapmall.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>view/adminMember/list</title>
<link rel="stylesheet" href="style.css" type="text/css">
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

	function deleteCheck() {
		var checkIt=$("#checkRow:selected").val();
		var gubun;
		if(checkIt==0) {
		    alert("삭제할 항목을 하나이상 선택해주세요.");
			return false;
		} else {
			gubun = confirm("정말로 삭제하시겠습니까?");
			if(gubun) {
				alert("삭제가 완료되었습니다.")
				return true;
			} 
			else {
				alert("취소하셨습니다.")
				return false;
			}
			return false;
	}
	}
	
	function displayButton(){
		var checkIt=$("#checkRow:selected").val();
		if(checkIt==1){
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

	<h1>관리자 목록 </h1>
	<form action="AdminFormSearch.admin?pageNum=${pageNum }" method="post">
 		<div class="mainH" >
 			<select name="how">
			<option value="0">항목선택</option>
			<option value="1">이름</option>
			<option value="2">권한</option>
			<option value="3">부서</option>
			</select>&nbsp;
				<input type="text" name="search" value="${search }"> 
				<input type="submit" class="btn mini" value="검색"><p>
 		</div>
 	</form><br>
	<form action="AdminDeleteForm.admin?pageNum=${pageNum }" name="frm" onsubmit="return deleteCheck()" >
		<table class="table" border="1">
			<tr class="tr">
				<th class="th">
				삭제 여부
				</th>
				<th class="th">관리자 ID</th>
				<th class="th">비밀번호</th>
				<th class="th">성 명</th>
				<th class="th">부 서</th>
				<th class="th">직 급</th>
				<th class="th">사 번</th>
				<th class="th">권 한</th>
				<th class="th">전화 번호</th>
				<th class="th">이메일</th>
			</tr>
				
		<c:if test="${count>0 }">
		<c:forEach var="adminList" items="${adminList }">
			<tr>
				<td class="td">
					<select name="checkRow" id="checkRow" required="required" onclick="displayButton()" >
										<option value="0">유지  </option>
										<option value="1">삭제  </option>
					</select> 							       
		    		<input type="hidden" name="id" value="${adminList.id}">
		    		
				</td>
				<td class="td tdh">
					<a href="#" 
						onclick="javascript:window.open('AdminUpdateForm.admin?id=${adminList.id}&pageNum=${pageNum}&popup','관리자 수정', 'width=500, height=500')">
					${adminList.id } </a>
				</td>
				<td class="td">${adminList.pw }</td>
				<td class="td">${adminList.nm }</td>
				<td class="td">${adminList.dept }</td>
				<td class="td">${adminList.position }</td>
				<td class="td">${adminList.emp_no }</td>
				<td class="td">${adminList.auth }</td>
				<td class="td">${adminList.tel }</td>
				<td class="td">${adminList.email }</td>
			</tr>
		</c:forEach>
		</c:if>

		<c:if test="${count==0 }">
			<tr>
				<td colspan=11 class="td">검색 자료가 없습니다.</td>
			</tr>
		</c:if>
	</table>
		<br>

 		<div class="pagination" >
			<c:if test="${startPage > blockSize }">
				<a class="a" href='AdminForm.admin?pageNum=${startPage-blockSize}'>« Prev</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a class="a active" href='AdminForm.admin?pageNum=${i}'> ${i}</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a class="a" href='AdminForm.admin?pageNum=${startPage+blockSize}'>Next »</a>
			</c:if>
 		</div>

 		<div class="mainF" >
			<input type="submit"  class="btn mini" value="삭제"  id="submitB" style="display:none;"> 
			<button type="button" class="btn mini"  onclick="location.href='AdminInsertForm.admin'" >등록</button>
			<input type="reset" class="btn mini "  value="유지버튼 초기화">
		</div> 
 	</form>	
	</div>
</body>
</html>