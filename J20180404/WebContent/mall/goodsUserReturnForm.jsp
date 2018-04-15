<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">


function getDetail(r){
	var order_sq = $('#'+r).val();
	$.ajax({ 
		type:"post",
		url:'orderReturnDetailForm.mall?order_sq='+order_sq, 
		data:{"order_sq":order_sq},
		success:function(detail){
			$('#detailOrder').html(detail);
			page();
		}	
	});
}


</script>
</head>
<body>
	
	<div id="main">
		<h2>상품반품</h2>
		<form action="goodsUserReturnPro.mall" method="post">
			<table border="1">
				<tr>
					<th>주문ID</th>
					<th>최종가격</th>
					<th>사용포인트</th>
					<th>결제수단</th>
					<th>주문상태</th>
					<th>주문일</th>
					<th>반품체크</th>
				</tr>
				
				<c:if test="${count>0 }">
					<c:forEach var="order" items="${list }" varStatus="i">
						<tr>
							<td>
								<c:set var="checkCd" value="${order.order_cd }"/>
									
									<c:if test="${!fn:contains(checkCd,'R')}">
									     <a href="javascript:getDetail('order_sq${i.index }');" id="selectDetail">
									 	 <input type="hidden" id="order_sq${i.index }" name="order_sq" value="${order.order_sq}">
									     ${order.order_sq }</a>
									</c:if>
						
									<c:if test="${fn:contains(checkCd,'R') }">
										${order.order_sq }
									</c:if>
							</td> 
							<td>${order.dc_price }</td>
							<td>${order.use_point }</td>
							<td>${order.pay_method }</td>
							<td>${order.order_cd }</td>
							<td>${order.order_dt }</td>
							<td>
								<c:if test="${!fn:contains(checkCd,'R')}">
									<c:if test="${order.origin_price!=0}">
										<input type="checkbox" name="returnOrder_sq" value=${order.order_sq }>
									</c:if>
									
									<c:if test="${order.origin_price==0}">
									</c:if>
								</c:if>
								<c:if test="${fn:contains(checkCd,'R') }">
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${count==0 }">
					<tr>
						<td colspan=7>no data exists</td>
					</tr>
				</c:if>
				
			</table>
			
			<div style="text-align: center">
	
					<c:if test="${ currentPage>1 }">
						<a href='goodsUserReturnForm.mall?pageNum=${currentPage-1 }&id=${id}'>
							[이전] </a>
					</c:if>
		
					<c:forEach var="i" begin="${startPage }" end="${endPage }">
						<a href='goodsUserReturnForm.mall?pageNum=${i}&id=${id}'> [${i }] </a>
					</c:forEach>
		
					<c:if test="${endPage<pageCnt }">
						<a href='goodsUserReturnForm.mall?pageNum=${startPage+blockSize }&id=${id}'>
							[다음] </a>
					</c:if>
			</div>
				<span style="float: right; padding: 10 10 10 10px!important;">
					<input type="submit" value="반품">
					<input type="reset" value="취소">
					<input type="button" onclick="javascript:window.open('goodsReturnList.mall?id=${id}','반품목록','width=500, height=500, scrollbar=yes' )" value="반품목록">
				</span>
		</form>
		
		<div id="detailOrder">
		
		</div>
	</div>
</body>

</html>