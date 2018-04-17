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
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js">

	$(function() { //전체선택 체크박스 클릭 
		$("#checkAll").click(function() { //만약 전체 선택 체크박스가 체크된상태일경우 
			if ($("#checkAll").prop("checked")) { //해당화면에 전체 checkbox들을 체크해준다 
				$("input[type=checkbox]").prop("checked", true); // 전체선택 체크박스가 해제된 경우 
			} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
				$("input[type=checkbox]").prop("checked", false);
			}
		})
	})

	function go_modify() {
		if ($(":checkbox[name='checkRow']:checked").length != 0) {
			alert("수정할 항목을 하나만 체크해주세요.");
			return;
		}
	}
	function go_delete() {
		if ($(":checkbox[name='checkRow']:checked").length == 0) {
		alert("삭제할 항목을 하나이상 체크해주세요.");
			return;
		}
	}
	
	function deleteCheck() {
		alert("asdf");
		var gubun;
		gubun = confirm("정말로 삭제하시겠습니까?");
		if(gubun) {
			alert("삭제가 완료되었습니다.")
			return false;
		} 
		else {
			alert("취소하셨습니다.")
			return false;
		}
		return false;
	}

</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="adminMenuList.jsp" />
</div>
	<h2>관리자 리스트</h2>
	<form action="AdminFormSearch.admin?pageNum=${pageNum }" method="post">
		<div style="float:right; padding: 10 10 10 10px! important;" >
			<select name="how">
			<option value="1">이름</option>
			<option value="2">권한</option>
			<option value="3">부서</option>
			</select>&nbsp;
				<input type="text" name="search" value="${search }"> 
				<input type="submit" value="검색"><p>
		</div>
	</form><br>
	
	<form action="AdminDeleteForm.admin?pageNum=${pageNum }" onsubmit="return deleteCheck();" method="post">
		<table border="1" id="list">
			<tr>
				<th>
					<input type="checkbox" id="checkAll" onclick="checkAll();" >
				</th>
				<th>관리자 ID</th>
				<th>비밀번호</th>
				<th>성 명</th>
				<th>부 서</th>
				<th>직 급</th>
				<th>사 번</th>
				<th>권 한</th>
				<th>전화 번호</th>
				<th>이메일</th>
				<th>사진 경로</th>
			</tr>
				
		<c:if test="${count>0 }">
		<c:forEach var="adminList" items="${adminList }">
			<tr>
				<td>
					<select name="checkRow" required="required"  >
										<option value="0">유지  </option>
										<option value="1">삭제  </option>
					</select> 							       
		    		<input type="hidden"   name="id" value="${adminList.id}">
		    		
				</td>
				<td>
					<a href="#" 
						onclick="javascript:window.open('AdminUpdateForm.admin?id=${adminList.id}&pageNum=${pageNum}&popup','관리자 수정', 'width=500, height=500')">
					${adminList.id } </a>
				</td>
				<td>${adminList.pw }</td>
				<td>${adminList.nm }</td>
				<td>${adminList.dept }</td>
				<td>${adminList.position }</td>
				<td>${adminList.emp_no }</td>
				<td>${adminList.auth }</td>
				<td>${adminList.tel }</td>
				<td>${adminList.email }</td>
				<td>${adminList.path }</td>
			</tr>
		</c:forEach>
		</c:if>

		<c:if test="${count==0 }">
			<tr>
				<td colspan=11>검색 자료가 없습니다.</td>
			</tr>
		</c:if>
	</table>

	<div style="text-align: center;">
			<c:if test="${startPage > blockSize }">
				<a href='AdminUserListForm.admin?pageNum=${startPage-blockSize}'>[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a href='AdminUserListForm.admin?pageNum=${i}'>[${i}]</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a href='AdminUserListForm.admin?pageNum=${startPage+blockSize}'>[다음]</a>
			</c:if>
		</div>

		<div style="float: right; padding: 10 10 10 10px!important;"> 
			<input type="submit" value="삭제" > 
			<button type="button" onclick="location.href='AdminInsertForm.admin' ">등록</button>
			<input type="reset" value="취소">
		</div>
	</form>	
</body>
</html>