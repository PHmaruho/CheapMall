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

<%
	//List<AdminDto> adminDto=(List<AdminDto>)request.getAttribute("adminList");
%>

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
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js">
	
</script>
<script type="text/javascript">
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

	$("#checkRow").click(function() {

		var rowData = new Array();
		var tdArr = new Array();
		var checkbox = $("input[name=checkRow]:checked");
	});
</script>
</head>
<body>

	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<h2>회원 정보</h2>

		<form action="AdminForm.admin?pageNum=${pageNum }" method="post">
			<table width="100%" border="1" id="adminList">
				<thead>
					<tr>
						<th><input type="checkbox" id="checkAll"
							onclick="checkAll();" /></th>
						<th>ID</th>
						<th>비밀번호</th>
						<th>이름</th>
						<th>부서</th>
						<th>직급</th>
						<th>사번</th>
						<td>권한</td>
						<td>전화번호</td>
						<td>이메일</td>
						<td>사진경로</td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${count>0 }">
						<c:forEach var="adminList" items="${adminList }">

							<tr>
								<td><input type="checkbox" name="checkRow"
									value="${adminList.id }" /></td>
								<td>${adminList.id}</td>
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

					<c:if test="${ currentPage>1 }">

						<a href='AdminForm.admin?pageNum=${currentPage-1 }'> [이전] </a>

					</c:if>


					<c:forEach var="i" begin="${startPage }" end="${endPage }">

						<a href='AdminForm.admin?pageNum=${i}&search=${search}'> [${i }]
						</a>

					</c:forEach>

					<c:if test="${endPage<pageCnt }">
						<a href='AdminForm.admin?pageNum=${startPage+blockSize }&'>
							[next] </a>
					</c:if>



				</tbody>

				<ul>
					<input type="text" name="search" value="${search }">
					<li><a class="a" href="AdminFormSearch.admin">검색</a></li>
				</ul>



			</table>
		</form>
	</div>

	<div id="footer">
		<ul>
			<li><a class="a" href="AdminUpdateForm.admin">수정</a></li>
			<li><a class="a" href="AdminDeleteForm.admin">삭제</a></li>
			<li><a class="a" href="AdminInsertForm.admin">등록</a></li>
		</ul>
	</div>


</body>
</html>