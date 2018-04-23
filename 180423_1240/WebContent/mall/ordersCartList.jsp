<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../js/bootstrap.min.css">
<title>Cheap Mall</title>
<style type="text/css">
.container {
	position: absolute;
	width: 100%;
	height: 100%;
	padding: 0;
}

.carttb {
	position: relative;
	width: 100%;
	height: 10%;
	border-style: none;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
}

.carttb tr td, th {
	text-align: center;
	border-top-style: none;
}

.carttb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
}

.carttb th {
	background-color: #E5E1E1;
	border-bottom-style: none;
}

.colorButton {
	border: none;
	padding: 20px;
	display: inline-block;
	margin: 4px 2px;
	border-radius: 50%;
}

#cartbtn {
	position: absolute;
	left: 43%;
	margin-top: 20px;
	border-style: solid;
	border-width: 1px;
	width: 140px;
	background-color: rgba(255, 255, 255, 0);
	color: black;
	border-style: solid;
}

#cartbtn:hover {
	border-width: 2px;
}

#cartbtn1, #cartbtn2 {
	border-style: solid;
	border-width: 1px;
	height : 28px;
	background-color: rgba(255, 255, 255, 0);
	color: black;
	border-style: solid;
}

#cartbtn1:hover,#cartbtn2:hover {
	border-width: 2px;
	padding: 5px 11px;
}

.carttotal {
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<table class="carttb">
			<tr>
				<th>상품</th>
				<th>상품</th>
				<th>수량</th>
				<th>가격</th>
				<th>합계</th>
				<th>총계</th>
			</tr>
			<c:forEach var="cart" items="${list }" varStatus="status">
				<c:set var="total"
					value="${total + (cart.cnt * cart.origin_price) }" />
				<c:set var="rowCount" value="${status.count }" />
			</c:forEach>
			<c:choose>
				<c:when test="${total < 30000 }">
					<c:set var="delivery_fee" value="2500" />
				</c:when>
				<c:otherwise>
					<c:set var="delivery_fee" value="0" />
				</c:otherwise>
			</c:choose>
			<c:forEach var="cart" items="${list }" varStatus="status">
				<tr>
					<td><img
						src="../images/${cart.gender}/${cart.top_category }/${cart.middle_category }/original/${cart.path }.png"
						width="50%" height="50%"></td>
					<td><button class="colorButton"
							style="background-color: ${cart.color};"></button> <br>${cart.goods_size }<br>
						${cart.nm }</td>
					<td>
						<form action="ordersCartListUpdate.mall" method="post">
							<input type="number" name="cnt" value="${cart.cnt }"></input> <input
								type="hidden" name="cart_sq" value="${cart.cart_sq }"></input> <input
								type="submit" value="수정" class="btn btn-warning" id="cartbtn1">
						</form>
						<form action="ordersCartListDelete.mall" method="post">
							<input type="hidden" name="cart_sq" value="${cart.cart_sq }"></input>
							<input type="submit" value="삭제" class="btn btn-danger"
								id="cartbtn2">
						</form>
					</td>
					<td>${cart.origin_price }</td>
					<td>${cart.cnt * cart.origin_price}</td>
					<c:if test="${status.first }">
						<td rowspan="${rowCount }" align="center" class="carttotal">${total }</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
		<button
			onclick="location.href='ordersCartToPay.mall?delivery_fee=${delivery_fee}&total=${total}'"
			class="btn btn-success" id="cartbtn">주문하기</button>
	</div>
</body>
</html>
