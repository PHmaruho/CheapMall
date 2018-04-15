<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>

<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">


	$(function(){
		$('#display').click(function(){
			$('.goodsShow').toggle();
		});

	});
	

		
</script>

</head>
<body>

	<%-- <div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div> --%>

	<h2>상품수정</h2>
	
	<div id="main"> 

		<c:set var="displayNumber" value="0" />
		
			<form action="goodsAdminUpdateList.admin?pageNum=${currentPage }&category=${category }&search=${search}"
				name="searchDetail">
				<div style="float: right;padding: 10 10 10 10px !important!;">
					<select name="category">
						<option value="">항목 선택</option>
						<option value="gender">성별</option>
						<option value="top_category">대분류</option>
						<option value="middle_category">소분류</option>
					</select> <input type="text" name="search">
					 <input type="submit" value="검색"> 
					 <input type="button" value="등록"> 
					 <input type="button" value="활성/비활성" id="display">
				</div>
			</form>


			<form action="goodsAdminUpdateDisplayPro.admin">
				<table border="1">
					<tr>
						<th>상품Id</th>
						<th>코드</th>
						<th>이름</th>
						<th>가격</th>
						<th>성별</th>
						<th>대분류</th>
						<th>재고량</th>
						<th>종료일</th>
						<th>display 상태</th>
						<th class="goodsShow" style="display: none;">상태</th>
					</tr>
	
					<c:if test="${list==null }">
						<tr>
							<td colspan="11">no data exists</td>
						</tr>
					</c:if>
	
	
					<c:if test="${list!=null || list.size()>0}">
						<c:forEach var="goods" items="${list }">
	
							<tr>
								<input type="hidden" name="sq" value="${goods.sq }" />
								<td><a href="#"
									onclick="javascript:window.open('goodsAdminUpdateForm.admin?sq=${goods.sq }','상품 수정','scrollbars=yes width=500 height=600')">
										${goods.sq }</a></td>
								<td>${goods.cd }</td>
								<td><img
									src="../images/${goods.gender}/${goods.top_category }/${goods.middle_category }/origin/${goods.path }">${goods.nm }</td>
								<td>${goods.price }</td>
								<td>${goods.gender }</td>
								<td>${goods.top_category }</td>
								<td>${goods.stock }</td>
								<td>${goods.end_dt }</td>
								<td>${goods.display }</td>
								<td class="goodsShow" style="display: none;"><c:set
										var="displayNumber" value="${displayNumber}" /> <c:if
										test="${goods.display=='Y'}">
											활성화<input type="radio" name="${displayNumber}" value="Y"
											checked="checked" />
											비활성화<input type="radio" name="${displayNumber}" value="N" />
										<c:set var="displayNumber" value="${displayNumber+1 }" />
									</c:if> <c:if test="${goods.display =='N'}">
											활성화<input type="radio" name="${displayNumber }" value="Y" />
											비활성화<input type="radio" name="${displayNumber }" value="N"
											checked="checked" />
										<c:set var="displayNumber" value="${displayNumber+1 }" />
									</c:if></td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
	
				<div style="text-align: center">
	
					<c:if test="${ startPage > blockSize }">
						<a
							href='goodsAdminUpdateList.admin?pageNum=${startPage-blockSize }'>
							[이전] </a>
					</c:if>
	
					<c:forEach var="i" begin="${startPage }" end="${endPage }">
						<a href='goodsAdminUpdateList.admin?pageNum=${i}'> [${i }] </a>
					</c:forEach>
	
					<c:if test="${endPage<totalPage }">
						<a
							href='goodsAdminUpdateList.admin?pageNum=${startPage+blockSize }'>
							[다음] </a>
					</c:if>
	
	
					<input type="submit" value="확인" class="goodsShow" id="cssStyle"
						style="display: none;">
				</div>

		</form>
	</div>
</body>
</html>