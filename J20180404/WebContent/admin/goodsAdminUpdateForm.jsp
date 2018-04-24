<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<link rel="stylesheet" href="style.css" type="text/css">

<script type="text/javascript" src="../js/jquery.js"></script>
<style>

</style>
<script type="text/javascript">
	function changeRead() {
		$('#updateGoods').find("input").prop("readOnly", false);
		$('#checkIt').toggle();
		$('#modify').toggle();
	}
</script>
</head>
<body>

	<h2>상품 상세정보 수정</h2>
		<form action="goodsAdminUpdateFormPro.admin" method="post">
			<table class="table" border="1">
				<tr>
					<th class="th">상품Id</th>
					<td><input type="text" name="sq" value="${sq }" readonly
						required="required"></td>
				</tr>
				<tr>
					<th class="th">상품코드</th>
					<td><input type="text" name="cd" value="${dto.cd }" readonly
						required="required"></td>
				</tr>

				<tr>
					<div id="updateGoods">
						<th class="th">상품명</th>
						<td><input type="text" name="nm" value="${dto.nm }" readonly
							required="required"></td>
					</div>
				</tr>

				<tr>
					<th class="th">가격</th>
					<td><input type="number" name="price" value="${dto.price }"
						readonly required="required"></td>
				</tr>
				<tr>
					<th class="th">성별</th>
					<td colspan="2"><select name="gender">
							<option value="M"
								<c:if test="${dto.gender=='M' }">selected</c:if>>남자
							<option value="F"
								<c:if test="${dto.gender=='F' }">selected</c:if>>여자
					</select></td>
				</tr>
				<tr>
					<th class="th">대분류</th>
					<td><select name="top_category">
							<option value="M"
								<c:if test="${dto.top_category=='M' }">selected</c:if>>남성


							
							<option value="F"
								<c:if test="${dto.top_category=='F' }">selected</c:if>>여성


							
							<option value="U"
								<c:if test="${dto.top_category=='U' }">selected</c:if>>공용


							
							<option value="O"
								<c:if test="${dto.top_category=='O' }">selected</c:if>>아우터


							
							<option value="I"
								<c:if test="${dto.top_category=='I' }">selected</c:if>>이너


							
							<option value="E"
								<c:if test="${dto.top_category=='E' }">selected</c:if>>기타


							
					</select></td>
				</tr>
				<tr>
					<th class="th">소분류</th>
					<td><select name="middle_category">
							<option value="JAC"
								<c:if test="${dto.middle_category=='JAC' }">selected</c:if>>재킷


							
							<option value="CAR"
								<c:if test="${dto.middle_category=='CAR' }">selected</c:if>>가디건


							
							<option value="TSH"
								<c:if test="${dto.middle_category=='TSH' }">selected</c:if>>티셔츠


							
							<option value="SHI"
								<c:if test="${dto.middle_category=='SHI' }">selected</c:if>>셔츠


							
							<option value="PAN"
								<c:if test="${dto.middle_category=='PAN' }">selected</c:if>>바지


							
							<option value="WAT"
								<c:if test="${dto.middle_category=='WAT' }">selected</c:if>>시계


							
							<option value="SHO"
								<c:if test="${dto.middle_category=='SHO' }">selected</c:if>>신발


							
							<option value="HAT"
								<c:if test="${dto.middle_category=='HAT' }">selected</c:if>>모자


							
							<option value="BAG"
								<c:if test="${dto.middle_category=='BAG' }">selected</c:if>>가방


							
							<option value="SKI"
								<c:if test="${dto.middle_category=='SKI' }">selected</c:if>>치마


							
							<option value="ONE"
								<c:if test="${dto.middle_category=='ONE' }">selected</c:if>>원피스


							
							<option value="SCA"
								<c:if test="${dto.middle_category=='SCA' }">selected</c:if>>스카프


							
					</select></td>
				</tr>
				<tr>
					<th class="th">색상</th>
					<td><select name="color">
							<option value="none"
								<c:if test="${dto.color==null }">selected</c:if>>없음
							<option value="red"
								<c:if test="${dto.color=='red'}">selected</c:if>>빨강
							<option value="orange"
								<c:if test="${dto.color=='orange' }">selected</c:if>>주홍


							
							<option value="yellow"
								<c:if test="${dto.color=='yellow' }">selected</c:if>>노랑


							
							<option value="green"
								<c:if test="${dto.color=='green' }">selected</c:if>>초록


							
							<option value="blue"
								<c:if test="${dto.color=='blue' }">selected</c:if>>파랑
							<option value="gray"
								<c:if test="${dto.color=='gray' }">selected</c:if>>회색
							<option value="black"
								<c:if test="${dto.color=='black' }">selected</c:if>>검정


							
							<option value="white"
								<c:if test="${dto.color=='white' }">selected</c:if>>흰색


							
					</select></td>
				</tr>
				<tr>
					<th class="th">사이즈</th>
					<td><select name="goods_size">
							<option value="none"
								<c:if test="${dto.goods_size==null }">selected</c:if>>없음


							
							<option value="X2S"
								<c:if test="${dto.goods_size=='X2S'}">selected</c:if>>XXS


							
							<option value="X1S"
								<c:if test="${dto.goods_size=='X1S' }">selected</c:if>>XS


							
							<option value="X0S"
								<c:if test="${dto.goods_size=='X0S' }">selected</c:if>>S


							
							<option value="X0M"
								<c:if test="${dto.goods_size=='X0M' }">selected</c:if>>M


							
							<option value="X0L"
								<c:if test="${dto.goods_size=='X0L' }">selected</c:if>>L


							
							<option value="X1L"
								<c:if test="${dto.goods_size=='X1L' }">selected</c:if>>XL


							
							<option value="X2L"
								<c:if test="${dto.goods_size=='X2L' }">selected</c:if>>XXL


							
					</select></td>
				<tr>
					<th class="th">재고량</th>
					<td><input type="number" name="stock" value="${dto.stock }"
						readonly required="required"></td>
				<tr>
					<th class="th">시작일</th>
					<td><input type="date" name="start_dt"
						value="${dto.start_dt }" readonly required="required"></td>
				</tr>
				<tr>
					<th class="th">종료일</th>
					<td><input type="date" name="end_dt" value="${dto.end_dt }"
						readonly required="required"></td>
				</tr>
				<tr>
					<th class="th">노출</th>
					<td><select name="display">
							<option value="Y"
								<c:if test="${dto.display eq 'Y'}">selected</c:if>>Y
							<option value="N"
								<c:if test="${dto.display eq 'N'}">selected</c:if>>N
					</select></td>
				</tr>
			</table>
<br>
			<div class="mainF">
				<input type="button"  class="btn mini" value="상품 수정하기" onClick="changeRead()"
					id="checkIt" style="display: block">
					<input type="submit" class="btn mini"
					value="확인" id="modify" style="display: none">
			</div>

		</form>
	</div>
</body>
</html>