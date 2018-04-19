<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
<h3>주문 내역 간략보기 </h3>
<form action="orderReturnDetailForm.mall" method="post">
<table border="1" align="center" style="border-collapse:collapse; border:1px pink solid;">

			<tr>
				<th>주문일자</th>
				<th><p>주문번호
				<p> 상품명</th>
				<th>총 결제금액</th>
				<th>주문상태</th>
			</tr>
		
			<c:forEach var="list" items="${list }" varStatus="status">
				<c:set var="rowCount" value="${status.count }"/>
			</c:forEach>
			
			<c:forEach var="list" items="${list }">
				<c:choose>
					<c:when test="${list.origin_price < 30000 }">
						<c:set var="delivery_fee" value="2500"/>
					</c:when>
					<c:otherwise>
						<c:set var="delivery_fee" value="0"/>
					</c:otherwise>
				</c:choose>
				
				<tr>
					<td width="30%" align="center" >${list.order_dt }
					<p><img src="../images/${list.gender }/${list.top_category}/${list.middle_category}/thumbnail/${list.path }.png"
													height="50%" width="50%" >
					</td>
					<td width="15%" align="center">
					<input type="hidden" name="order_sq" value="${list.order_sq }">
						${list.order_sq }<p>
						<br>
							${list.nm }
							<c:if test="${list.cnt > 1 }">
								 외 ${list.cnt - 1 }건
							</c:if>	
						</td>
					<td width="400" align="center" >
						총 ${list.origin_price + delivery_fee } 원
					</td>
					<td width="10%" align="center" >
						${list.order_cd }
					</td>
					<td width="10%" align="center">
					<input type="submit" value="상세보기" >
					</td>
				</tr>
			</c:forEach>
	</table>
</form>
</body>
</html>