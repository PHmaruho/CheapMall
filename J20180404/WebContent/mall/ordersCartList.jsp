<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
	.colorButton {
	    border: none;
	    padding: 20px; 
	    display: inline-block;
	    margin: 4px 2px;
	    border-radius: 50%;
	}
	td {
		text-align: center;
	}
	th {
		width: 10%;
	}
</style>
</head>
<body>
	<table border="1px solid black">
		<tr>
			<th>상품</th>
			<th>상품</th>
			<th>수량</th>
			<th>가격</th>
			<th>합계</th>
			<th>총계</th>
		</tr>
		<c:forEach var="cart" items="${list }" varStatus="status">
			<c:set var="total" value="${total + (cart.cnt * cart.origin_price) }"/>
			<c:set var="rowCount" value="${status.count }"/>
		</c:forEach>
		<c:choose>
			<c:when test="${total < 30000 }">
				<c:set var="delivery_fee" value="2500"/>
			</c:when>
			<c:otherwise>
				<c:set var="delivery_fee" value="0"/>
			</c:otherwise>
		</c:choose>
		<c:forEach var="cart" items="${list }" varStatus="status">
			<tr>
				<td><img src="../images/${cart.gender}/${cart.top_category }/${cart.middle_category }/original/${cart.path }.png"
					width="50%" height="50%"></td>
				<td><button class="colorButton" style="background-color: ${cart.color};"></button><br>${cart.goods_size }<br>
					${cart.nm }</td>
				<td>
					<form action="ordersCartListUpdate.mall" method="post">
						<input type="number" name="cnt" value="${cart.cnt }"></input>
						<input type="hidden" name="cart_sq" value="${cart.cart_sq }"></input>
						<input type="submit" value="수정">
					</form>
					<form action="ordersCartListDelete.mall" method="post">
						<input type="hidden" name="cart_sq" value="${cart.cart_sq }"></input>
						<input type="submit" value="삭제">
					</form>
				</td>
				<td>${cart.origin_price }</td>
				<td>${cart.cnt * cart.origin_price}</td>
				<c:if test="${status.first }">
					<td rowspan="${rowCount }" align="center">${total }</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<button onclick="location.href='ordersCartToPay.mall?delivery_fee=${delivery_fee}&total=${total}'">주문하기</button>
</body>
</html>	