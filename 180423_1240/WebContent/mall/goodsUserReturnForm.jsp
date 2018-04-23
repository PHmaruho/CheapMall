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

function checkReturnOrder(){
	var returnOrder= $("#returnOrder_sq:checked").length;
	if (returnOrder!=0){
		 $('#submitButton').show();
	}else{
		 $('#submitButton').hide();
	}
}

function getDetail(){
	var order_sq = $('#order_sq').val();
	$.ajax({ 
		type:"post",
		url:'orderReturnDetailForm.mall?order_sq='+order_sq, 
		data:{"order_sq":order_sq},
		success:function(detail){
			$('#detailOrder').html(detail);
		}	
	});
}


</script>
<style>
	#main{
		display:flex;
	}
</style>
</head>
<body>
	
	<div id="main">
		<form action="goodsUserReturnPro.mall" method="post" name="all">
		<h2>주문상세</h2>
			<table border="1">
			<c:forEach var="order" items="${list }">
				<tr>
					<c:set var="checkCd" value="${order.meaning }"/>
					<th>주문번호</th>
					<td>
						<c:if test="${!fn:contains(checkCd,'반품')}">
						     <a href="javascript:getDetail('order_sq');" id="selectDetail">
						 	 <input type="hidden" id="order_sq" name="order_sq" value="${order.order_sq}">
						     ${order.order_sq }</a>
						</c:if>
						<c:if test="${fn:contains(checkCd,'반품')}">
						     ${order.order_sq }
						</c:if>
					</td>
				</tr>
				<tr>
					<th>상품</th>
					<td><img src="../images/${order.gender }/${order.top_category}/${order.middle_category}/thumbnail/${order.path }.png"
													height="50%" width="50%" >
					${order.nm }</td>
				</tr>
				<tr>	
					<th>원가</th>
					<td>${order.origin_price }</td>
				</tr>
				<tr>
					<th>결제수단</th>
					<td>${order.pay_method }</td>
				</tr>
				<tr>
					<th>사용포인트</th>
					<td>${order.use_point }</td>
				</tr>
				<tr>
					<th>배송비</th>
					<td>${order.delivery_fee }</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${order.addr }</td>
				</tr>
				<tr>
					<th>주소상세</th>
					<td>${order.addr_detail }</td>
				</tr>
				<tr>
					<th>주문상태</th>
					<td>${order.meaning }</td>
				</tr>
				<tr>
					<th>주문일</th>
					<td>${order.order_dt }</td>
				</tr>
				<tr>
					<th>반품체크</th>
					<td>
						<c:if test="${!fn:contains(checkCd,'반품')}">
							<c:if test="${order.origin_price!=0}">
								<input type="checkbox" name="returnOrder_sq" id="returnOrder_sq" value=${order.order_sq } onclick="checkReturnOrder()">
							</c:if>
					
							<c:if test="${order.origin_price==0}">
							</c:if>
						</c:if>
								
						<c:if test="${fn:contains(checkCd,'반품') }">
						</c:if>
					</td>
					</c:forEach>
				</tr>
			</table>
			<%-- 
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
			</div> --%>
				<div style="float: right; padding: 10 10 10 10px!important;">
					<input type="submit" value="반품" id="submitButton" style="display:none;">
					<%-- <input type="button" onclick="javascript:window.open('goodsReturnList.mall?id=${id}','반품목록','width=500, height=500, scrollbar=yes' )" value="반품목록"> --%>
				</div>
		</form>
		<p>
		<div id="detailOrder">
		
		</div>
	</div>
</body>

</html>