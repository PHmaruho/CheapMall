<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style>

</style>
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
						<th>
								<c:if test="${dto.return_cd =='R0'}">
									반품요청
								</c:if>
								
								<c:if test="${dto.return_cd =='R1'}">
									반품수령
								</c:if>
								
								<c:if test="${dto.return_cd =='R2'}">
									반품확인중
								</c:if>
								
								<c:if test="${dto.return_cd =='R3'}">
									반품완료
								</c:if>
								
								<c:if test="${dto.return_cd =='R4'}">
									재배송
								</c:if>
								
								<c:if test="${dto.return_cd =='R5'}">
									교환요청
								</c:if>
						</th>
						<th>${dto.delivery_fee }</th>
						<th>${dto.return_dt }</th>
					</tr>
				</c:forEach>
			</c:forEach>
			
		</table>
	</div>
</body>
</html>