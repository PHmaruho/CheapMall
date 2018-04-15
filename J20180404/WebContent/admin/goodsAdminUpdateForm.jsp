<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style>
	#main{
		display:flex;
	}
</style>
</head>
<body>

	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
 
	<h2>상품 상세정보 수정</h2>
		<div id="main">
		
		<form action="goodsAdminUpdateFormPro.admin" method="post">
			상품Id: 	<input type="text" 	name="sq" 			value="${sq }"			readonly required="required"><br>
			상품코드: <input type="text" 	name="cd" 			value="${dto.cd }" 		readonly required="required"><br>
			상품명: 	<input type="text" 	name="nm" 			value="${dto.nm }" 		required="required"><br>
			가격: 	<input type="text" 	name="price" 		value="${dto.price }" 	required="required"><br>
			성별: 	<input type="text" 	name="gender" 		value="${dto.gender }" 	required="required"><br>
			대분류: 	<input type="text" 	name="top_category" value="${dto.top_category }" required="required"><br>
			소분류: 	<input type="text" 	name="middle_category" value="${dto.middle_category }" required="required"><br>
			색상: 	<input type="text" 	name="color" 		value="${dto.color }" 	required="required"><br>
			사이즈: 	<input type="text" 	name="goods_size" 	value="${dto.goods_size }" required="required"><br>
			재고량: 	<input type="text" 	name="stock" 		value="${dto.stock }" ><br>
			시작일: 	<input type="date" 	name="start_dt" 	value="${dto.start_dt }" required="required"><br>
			종료일: 	<input type="date" 	name="end_dt" 		value="${dto.end_dt }" 	required="required"><br>
			노출: 	<input type="text" 	name="display" 		value="${dto.display }" required="required"><br>
			
			<div style="float:right; padding: 10 10 10 10px!important!;">
				<input type="submit" value="수정">
				<input type="reset" value="취소"	>
			</div>
		</form>
	</div>
</body>
</html>