<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	
	<div id="main">
		<h2>반품 목록</h2>
		<table>
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
						<th>${order_id }</th>
						<th>${dto.detail_sq }</th>
						<th>${dto.cnt }</th>
						<th>${dto.return_cd }</th>
						<th>${dto.delivery_fee }</th>
						<th>${dto.return_dt }</th>
					</tr>
				</c:forEach>
			</c:forEach>
			
		</table>
	</div>
</body>
</html>