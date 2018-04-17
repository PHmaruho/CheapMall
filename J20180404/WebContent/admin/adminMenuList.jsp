<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css" type="text/css">
<style type="text/css">
table {
	width: 100%;
}
</style>
</head>
<body>
	<div id="wrap">
		<nav id="topMenu">
			<ul>
				<c:if test="${auth eq 'A0' }">
					<li><a class="a" href="AdminForm.admin">관리자관리</a></li>
					<li><a class="a" href="CodeList.admin">코드관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A1' }">
					<li><a class="a" href="userAdminList.admin">회원관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A2' }">
					<li><a class="a" href="SearchManagerForm.admin">검색어관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A3' }">
					<!-- <li><a class="a" href="boardAdminNoticeList.admin">게시판관리</a></li> -->
					<li><a class="a" href="boardAdminTempPageCwi.jsp">게시판관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A4' }">
					<li><a class="a" href="#">통계</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A5' }">
					<li><a class="a" href="goodsAdminUpdateList.admin">상품관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A5' }">
					<li><a class="a" href="adminPopupList.admin">팝업관리</a></li>
				</c:if>
				<li><a class="a" href="AdminLogout.admin">로그아웃</a></li>
			</ul>
		</nav>
	</div>

</body>
</html>