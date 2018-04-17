<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Cheap Mall</title>
<style type="text/css">
table {
	width: 100%;
}

td {
	text-align: center;
}
</style>
</head>
<body>
	<form action="OrderUserCanclePro.mall">
		<table>
			<tr>
				<th>선택</th>
				<th>주문번호</th>
				<th>주문일</th>
				<th>상품</th>
				<th>수량</th>
				<th>금액</th>
				<th>할인가</th>
				<th>상태</th>
			</tr>

			<c:forEach var="list" items="${list }">
				<tr>
					<td><input type="checkbox" name="check"
						value="${list.detail_sq }"></td>
					<td>${list.order_sq }</td>
					<td width="10%">${list.order_dt }</td>
					<td width="15%"><img
						src="images/${list.gender }/${list.top_category}/${list.middle_category}/thumbnail/sm_${list.goods_sq}.jpg"
						height="40" width="40" align="left">${list.nm }</td>
					<td>${list.cnt }</td>
					<td>${list.sale_price }</td>
					<td>${list.dc_price }</td>
					<c:if test="${list.order_cd=='O0' }">
						<td>결제완료</td>
					</c:if>
					<c:if test="${list.order_cd=='O1' }">
						<td>배송준비</td>
					</c:if>
				</tr>
			</c:forEach>

		</table>
		<input type="submit" value="삭제">
	</form>
</body>
</html>