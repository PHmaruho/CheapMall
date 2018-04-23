<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../js/bootstrap.min.css">
<title>Cheap Mall</title>
<style type="text/css">
.container {
	position: absolute;
	width: 100%;
	height: 100%;
	padding: 0;
}

.h {
	position: relative;
	border-style: none;
	left: 45%;
}

.ordercanceltb {
	position: relative;
	width : 100%;
	border-style: none;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
}

.ordercanceltb img{
	width: 30px;
	height: 30px;
}

.ordercanceltb tr td, th {
	text-align: center;
	border-top-style: none;
}

.ordercanceltb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
}

.ordercanceltb th {
	background-color: #E5E1E1;
	border-bottom-style: none;
}

#ordercancelbtn {
 	position : relative;
	border-style: solid;
	border-width: 1px;
	margin-top : 10px;
	background-color: rgba(255, 255, 255, 0);
	color: black;
	width: 100px;
}

#ordercancelbtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="h">
			<h2>주문 취소</h2>
		</div>
		<form action="OrderUserCanclePro.mall">
			<table class="ordercanceltb">
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
						<td>${list.order_dt }</td>
						<td><img
							src="../images/${list.gender }/${list.top_category}/${list.middle_category}/thumbnail/${list.goods_sq}.png"
							align="left">${list.nm }</td>
						<td>${list.cnt }</td>
						<td>${list.origin_price }</td>
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
			<input type="submit" value="삭제" class="btn btn-danger"
				id="ordercancelbtn">
		</form>
	</div>
</body>
</html>