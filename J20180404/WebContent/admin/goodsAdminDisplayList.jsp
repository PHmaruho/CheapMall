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

	 <div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	
	<div id="main" class="main">
		<h2>상품수정</h2>
<button class="btn mini"  onclick="location.href='goodsAdminUpdateList.admin'">전체상품 리스트</button>
		<c:set var="displayNumber" value="0" />
		
			<form action="GoodsAdminDisplayList.admin?pageNum=${currentPage }&gender=${gender}&top_category=${top_category}&middle_category=${middle_category}"
				name="searchDetail">
 		<div class="mainH" >
					<select name="gender">
						<option value="All">성별</option>
						<option value="M">-남성</option>
						<option value="F">-여성</option>
						<option value="U">-공용</option>
					</select> 
					<select name="top_category">
						<option value="All">대분류</option>
						<option value="O">-아우터</option>
						<option value="I">-이너</option>
						<option value="E">-기타</option>
					</select> 
					<select name="middle_category">
						<option value="All">소분류</option>
						<option value="JAC">-재킷</option>
						<option value="CAR">-가디건</option>
						<option value="TSH">-티셔츠</option>
						<option value="SHI">-셔츠</option>
						<option value="PAN">-바지</option>
						<option value="WAT">-시계</option>
						<option value="SHO">-신발</option>
						<option value="HAT">-모자</option>
						<option value="BAG">-가방</option>
						<option value="SKI">-치마</option>
						<option value="ONE">-원피스</option>
						<option value="SCA">-스카프</option>
					</select> 
					 <input type="submit" class="btn mini"  value="검색"> 
					 <input type="button" class="btn mini" value="등록"> 
					 <input type="button" class="btn mini" value="활성/비활성" id="display">
				</div>
			</form>

			<br>
			<br>
			<form action="goodsAdminUpdateDisplayPro.admin">
				<table class="table" border="1">
					<tr>
						<th class="th">상품Id</th>
						<th class="th">코드</th>
						<th class="th">이름</th>
						<th class="th">가격</th>
						<th class="th">성별</th>
						<th class="th">대분류</th>
						<th class="th">소분류</th>
						<th class="th">재고량</th>
						<th class="th">종료일</th>
						<th class="th">display 상태</th>
						<th class="goodsShow th" style="display: none;">상태</th>
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
									src="../images/${goods.gender}/${goods.top_category }/${goods.middle_category }/thumbnail/${goods.path }.png">${goods.nm }</td>
								<td>${goods.price }원</td>
								<td>
									<c:if test="${goods.gender=='M' }">남자</c:if>
									<c:if test="${goods.gender=='F' }">여자</c:if>
								</td>
								<td>
									<c:if test="${goods.top_category =='M' }">남성</c:if>
									<c:if test="${goods.top_category =='F' }">여성</c:if>
									<c:if test="${goods.top_category =='U' }">공용</c:if>
									<c:if test="${goods.top_category =='O' }">아우터</c:if>
									<c:if test="${goods.top_category =='I' }">이너</c:if>
									<c:if test="${goods.top_category =='E' }">기타</c:if>
								</td>
								<td>
									<c:if test="${goods.middle_category=='JAC' }">재킷</c:if>
									<c:if test="${goods.middle_category=='CAR' }">가디건</c:if>
									<c:if test="${goods.middle_category=='TSH' }">티셔츠</c:if>
									<c:if test="${goods.middle_category=='SHI' }">셔츠</c:if>
									<c:if test="${goods.middle_category=='PAN' }">바지</c:if>
									<c:if test="${goods.middle_category=='WAT' }">시계</c:if>
									<c:if test="${goods.middle_category=='SHO' }">신발</c:if>
									<c:if test="${goods.middle_category=='HAT' }">모자</c:if>
									<c:if test="${goods.middle_category=='BAG' }">가방</c:if>
									<c:if test="${goods.middle_category=='SKI' }">치마</c:if>
									<c:if test="${goods.middle_category=='ONE' }">원피스</c:if>
									<c:if test="${goods.middle_category=='SCA' }">스카프</c:if>
								</td>
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
			<br>
	
 		<div class="pagination" >

					<c:if test="${ startPage > blockSize }">
						<a class="a" 
							href='GoodsAdminDisplayList.admin?pageNum=${startPage-blockSize }&gender=${gender}&top_category=${top_category}&middle_category=${middle_category}'>
							« Prev</a>
					</c:if>
	
	
	
					<c:forEach var="i" begin="${startPage }" end="${endPage }">
						<a class="a"  href='GoodsAdminDisplayList.admin?pageNum=${i}&gender=${gender}&top_category=${top_category}&middle_category=${middle_category}'> ${i}</a>
					</c:forEach>
	
					<c:if test="${endPage<totalPage }">
						<a class="a" 
							href='GoodsAdminDisplayList.admin?pageNum=${startPage+blockSize }&gender=${gender}&top_category=${top_category}&middle_category=${middle_category}'>
							Next »</a>
					</c:if>
				</div>
				<div class="mainF">
					<input type="submit"value="확인"  class="btn mini goodsShow" id="cssStyle"
					style="padding:10 10 10 10px!important!;float:left; 	 display: none;">
				</div>
<br>
<br>

		</form>
	</div>
</body>
</html>