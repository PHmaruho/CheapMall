<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="style.css?ver=20180423" rel="stylesheet" type="text/css" />

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
					<li class="topMenuLi">
					<a class="menuLink" href="AdminForm.admin">관리자관리</a></li>
					<li>|</li>
					<li class="topMenuLi">
					<a class="menuLink" href="CodeList.admin">코드관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A1' }">
				<li>|</li>
					<li class="topMenuLi">
					<a class="menuLink" href="userAdminList.admin">회원관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A2' }">
				<li>|</li>
					<li class="topMenuLi">
					<a class="menuLink" href="SearchManagerForm.admin">검색어관리</a></li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A3' }">
				<li>|</li>
					<li class="topMenuLi">
					<a class="menuLink" href=" boardAdminNoticeList.admin">게시판관리</a>
						<ul class="submenu">
							<li><a href="boardAdminNoticeList.admin" class="submenuLink longLink">공지사항</a></li>
							<li><a href="boardAdminOtherList.admin?board_cd=B1" class="submenuLink longLink">문의사항</a></li> 
							<li><a href="boardAdminOtherList.admin?board_cd=B2" class="submenuLink longLink">건의사항</a></li>
							<li><a href="boardAdminOtherList.admin?board_cd=B3" class="submenuLink longLink">신고처리</a></li>
						</ul>
					</li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A4' }">
				<li>|</li>
					<li class="topMenuLi">
						<a class="menuLink" href="statisticsAdminMain.jsp">통계</a>
						<ul class="submenu">
							<li><a class="submenuLink longLink" href="statisticsAdminMain.jsp">종합</a></li>
							<li><a class="submenuLink longLink" href="statisticsAdminDetail.jsp">통계</a></li>
						</ul>
					</li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A5' }">
				<li>|</li>
					<li class="topMenuLi">
					<a class="menuLink" href="goodsAdminUpdateList.admin">상품관리</a>
						<ul class="submenu">
							<li><a href="GoodsAdminDisplayList.admin" class="submenuLink longLink">판매상품목록</a>
							<li><a href="goodsAdminUpdateList.admin" class="submenuLink longLink">전체상품목록</a>
							<li><a href="ExcelForm.admin" class="submenuLink longLink">택배사별운송목록</a>
						</ul>
					</li>
				</c:if>
				<c:if test="${auth eq 'A0' || auth eq 'A5' }">
													<li>|</li>
				
					<li class="topMenuLi">
					<a class="menuLink" href="adminPopupList.admin">팝업관리</a></li>
					
				</c:if>
									<li>|</li>
				<li class="topMenuLi">
				<a class="menuLink" href="AdminLogout.admin">로그아웃</a></li>
			</ul>
		</nav>
	</div>

</body>
</html>