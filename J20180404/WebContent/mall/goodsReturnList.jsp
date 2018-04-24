<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style>
.main {
	position: absolute;
	width: 100%;
	height: 100%;
}

.returnlisttb {
	position: relative;
	width: 80%;
	/* left: 20%; */
	border-style: none;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
}
.returnlisttb img{
	width: 30px;
	height: 30px;
}
.returnlisttb tr td, th {
	/* padding-top: 5px; */
}

.returnlisttb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
	border-top-style: solid;
	border-top-width: 1px;
	border-top-color: #E5E1E1;
	/* padding-left: 40px; */
}

.returnlisttb th {
	background-color: #E5E1E1;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #979797;
	border-top-style: solid;
	border-top-width: 1px;
}
</style>
</head>
<body>

	<div id="main">
		<h2>반품 목록</h2>
		<table class="returnlisttb">
			<tr>
				<th>주문ID</th>
				<th>상세ID</th>
				<th>수량</th>
				<th>반품상태</th>
				<th>배송비</th>
				<th>반품요청일</th>
			</tr>

			<c:forEach var="dto" items="${list }">
				<c:forEach var="order_id" items="${orderId}">
					<tr>
						<td>${order_id }</td>
						<td>${dto.detail_sq }</td>
						<td>${dto.cnt }</td>
						<td><c:if test="${dto.return_cd =='R0'}">
									반품요청
								</c:if> <c:if test="${dto.return_cd =='R1'}">
									반품수령
								</c:if> <c:if test="${dto.return_cd =='R2'}">
									반품확인중
								</c:if> <c:if test="${dto.return_cd =='R3'}">
									반품완료
								</c:if> <c:if test="${dto.return_cd =='R4'}">
									재배송
								</c:if> <c:if test="${dto.return_cd =='R5'}">
									교환요청
								</c:if></th>
						<td>${dto.delivery_fee }</td>
						<td>${dto.return_dt }</td>
					</tr>
				</c:forEach>
			</c:forEach>

		</table>
	</div>
</body>
</html>