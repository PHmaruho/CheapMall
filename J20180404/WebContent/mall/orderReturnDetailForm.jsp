<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript">
function checkReturnDetail(){
	var returnOrder= $("#detail_sq:checked").length;
	if (returnOrder!=0){
		 $('#submitDetail').show();
	}else{
		 $('#submitDetail').hide();
	}
}

function openReview(dSq, goods_sq){
	var popup = window.open("UserWriteReviewForm.mall?dSq="+dSq+"&goods_sq="+goods_sq,'popup', "width=500, height=500");
}
</script>
</head>
<body>
	

	<div id="main">
		<form action="orderReturnDetailPro.mall" method="post">
		<h2>상품상세</h2>
			
			<table border="1">
				<tr>
					<th>주문번호</th>
					<th>주문상세번호</th>
					<th>상품</th>
					<th>판매가</th>
					<th>수량</th>
					<th>반품체크</th>
					<th>후기등록</th>
				</tr>
				
				<c:if test="${count>0 }">
					<c:forEach var="order" items="${detailList }">
						<c:set var="checkCd" value="${order.order_cd }"/>
						<tr>
							<td><input type="hidden" name="order_sq" value="${order.order_sq }">${order.order_sq }</td>
							<td>${order.detail_sq }</td>
							<td><img src="../images/${order.gender }/${order.top_category}/${order.middle_category}/thumbnail/sm_${order.path }.png"
													height="50%" width="50%" >
							${order.nm }</td>
							<td>${order.origin_price }</td>
							<td>${order.cnt }</td>
							<td>
								<c:if test="${!fn:contains(checkCd,'R')&& !fn:contains(checkCd,'O0')&& !fn:contains(checkCd,'O5') }">
									<input type="checkbox" name="detail_sq" id="detail_sq" value=${order.detail_sq } onclick="checkReturnDetail()">
								</c:if>
								<c:if test="${fn:contains(checkCd,'R')&& fn:contains(checkCd,'O0')&& fn:contains(checkCd,'O5') }">
								</c:if>
							</td>
							<td>
								<c:if test="${checkCd eq 'O3' || checkCd eq 'O4' }">
									<input type="button" value="후기작성" onclick="openReview('${order.order_sq }', '${order.path }')">							
								</c:if>
							<td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${count==0 }">
					<tr>
						<td colspan=7>no data exists</td>
					</tr>
				</c:if>
				
			</table>
		<br>
			<span style="float: right; padding: 10 10 10 10px!important;">
				<input type="submit" value="반품" id="submitDetail" style="display:none;">
				<input type="reset" value="취소"></span>
				
		</form>
	</div>
</body>
</html>