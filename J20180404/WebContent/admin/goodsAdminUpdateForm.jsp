<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<style>
	#main{
		display:flex;
	}
</style>
<script type="text/javascript">
	function changeRead(){
		$('#updateGoods').find("input").prop("readOnly",false);
		$('#checkIt').toggle();
		$('#modify').toggle();
	}
</script>
</head>
<body>

	<h2>상품 상세정보 수정</h2>
		<div id="main">
		<form action="goodsAdminUpdateFormPro.admin" method="post">
			상품Id: 	<input type="text" 	name="sq" 			value="${sq }"			readonly required="required"><br>
			상품코드: <input type="text" 	name="cd" 			value="${dto.cd }" 		readonly required="required"><br>
		<div id="updateGoods">
			상품명: 	<input type="text" 	name="nm" 			value="${dto.nm }" 		readonly required="required"><br>
			가격: 	<input type="number" 	name="price" 		value="${dto.price }" 	readonly required="required"><br>
			성별:	<select name="gender">
						<option value="M" <c:if test="${dto.gender=='M' }">selected</c:if>>남자
						<option value="F" <c:if test="${dto.gender=='F' }">selected</c:if>>여자
					</select> 	
					<br>
			대분류: 	
					<select name="top_category" >
						<option value="M" <c:if test="${dto.top_category=='M' }">selected</c:if>>남성
						<option value="F" <c:if test="${dto.top_category=='F' }">selected</c:if>>여성
						<option value="U" <c:if test="${dto.top_category=='U' }">selected</c:if>>공용
						<option value="O" <c:if test="${dto.top_category=='O' }">selected</c:if>>아우터
						<option value="I" <c:if test="${dto.top_category=='I' }">selected</c:if>>이너
						<option value="E" <c:if test="${dto.top_category=='E' }">selected</c:if>>기타
					</select>
					<br>
			소분류: 	<select name="middle_category">
						<option value="JAC" <c:if test="${dto.middle_category=='JAC' }">selected</c:if>>재킷
						<option value="CAR" <c:if test="${dto.middle_category=='CAR' }">selected</c:if>>가디건
						<option value="TSH" <c:if test="${dto.middle_category=='TSH' }">selected</c:if>>티셔츠
						<option value="SHI" <c:if test="${dto.middle_category=='SHI' }">selected</c:if>>셔츠
						<option value="PAN" <c:if test="${dto.middle_category=='PAN' }">selected</c:if>>바지
						<option value="WAT" <c:if test="${dto.middle_category=='WAT' }">selected</c:if>>시계
						<option value="SHO" <c:if test="${dto.middle_category=='SHO' }">selected</c:if>>신발
						<option value="HAT" <c:if test="${dto.middle_category=='HAT' }">selected</c:if>>모자
						<option value="BAG" <c:if test="${dto.middle_category=='BAG' }">selected</c:if>>가방
						<option value="SKI" <c:if test="${dto.middle_category=='SKI' }">selected</c:if>>치마
						<option value="ONE" <c:if test="${dto.middle_category=='ONE' }">selected</c:if>>원피스
						<option value="SCA" <c:if test="${dto.middle_category=='SCA' }">selected</c:if>>스카프
					</select><br>
			색상: 	<select name="color">
						<option value="none" <c:if test="${dto.color==null }">selected</c:if>>없음
						<option value="red" <c:if test="${dto.color=='red'}">selected</c:if>>빨강
						<option value="orange" <c:if test="${dto.color=='orange' }">selected</c:if>>주홍
						<option value="yellow" <c:if test="${dto.color=='yellow' }">selected</c:if>>노랑
						<option value="green" <c:if test="${dto.color=='green' }">selected</c:if>>초록
						<option value="blue" <c:if test="${dto.color=='blue' }">selected</c:if>>파랑
						<option value="gray" <c:if test="${dto.color=='gray' }">selected</c:if>>회색
						<option value="black" <c:if test="${dto.color=='black' }">selected</c:if>>검정
						<option value="white" <c:if test="${dto.color=='white' }">selected</c:if>>흰색
					</select><br>
			사이즈: 	<select name="goods_size">
						<option value="none" <c:if test="${dto.goods_size==null }">selected</c:if>>없음
						<option value="X2S" <c:if test="${dto.goods_size=='X2S'}">selected</c:if>>XXS
						<option value="X1S" <c:if test="${dto.goods_size=='X1S' }">selected</c:if>>XS
						<option value="X0S" <c:if test="${dto.goods_size=='X0S' }">selected</c:if>>S
						<option value="X0M" <c:if test="${dto.goods_size=='X0M' }">selected</c:if>>M
						<option value="X0L" <c:if test="${dto.goods_size=='X0L' }">selected</c:if>>L
						<option value="X1L" <c:if test="${dto.goods_size=='X1L' }">selected</c:if>>XL
						<option value="X2L" <c:if test="${dto.goods_size=='X2L' }">selected</c:if>>XXL
					</select><br>
			재고량: 	<input type="number" 	name="stock" 		value="${dto.stock }" readonly required="required"><br>
			시작일: 	<input type="date" 	name="start_dt" 	value="${dto.start_dt }" readonly required="required"><br>
			종료일: 	<input type="date" 	name="end_dt" 		value="${dto.end_dt }" 	readonly required="required"><br>
			노출:	<select name="display">
						<option value="Y" <c:if test="${dto.display=='Y'}">selected</c:if>>Y
						<option value="N" <c:if test="${dto.display=='M'}">selected</c:if>>N
					</select><br> 	
		</div>
			<div style="float:right; padding: 10 10 10 10px!important!;">
				<input type="button" value="상품 수정하기" onClick="changeRead()" id="checkIt" style="display:block">
				<input type="submit" value="확인"  id="modify"  style="display:none">
			</div>
		</form>
	</div>
</body>
</html>