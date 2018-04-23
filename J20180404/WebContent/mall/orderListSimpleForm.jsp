<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		var id="<%=(String) session.getAttribute("id")%>"
		$.ajax({ 
			type:"post",
			url:'goodsUserReturnForm.mall?id='+id+'&order_sq='+order_sq, 
			data:{order_sq:order_sq,id:id},
			success:function(detail){
				$('#main2').html("");
				$('#main2').html(detail);
			}	
		});
	}
</script>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<style type="text/css">
	#main2{
		position: absolute;
		width: 100%;
		height: 100%;
		padding: 0;
	}
	.h {
	position: relative;
	border-style: none;
	left: 42%;
}
.orderlistsimpletb {
	position: relative;
	width : 100%;
	border-style: none;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
}

.orderlistsimpletb img{
	width: 30px;
	height: 30px;
}

.orderlistsimpletb tr td, th {
	text-align: center;
	border-top-style: none;
}

.orderlistsimpletb td {
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: #E5E1E1;
}

.orderlistsimpletb th {
	background-color: #E5E1E1;
	border-bottom-style: none;
}
#simpleformbtn {
 	position : relative;
	border-style: solid;
	border-width: 1px;
	margin-bottom : 10px;
	background-color: rgba(255, 255, 255, 0);
	color: black;
	width: 100px;
}

#simpleformbtn:hover {
	border-width: 2px;
	padding: 5px 11px;
}
#simpleformbtn2 {
 	position : relative;
	border-style: solid;
	border-width: 1px;
	border-color : gray;
	background-color: rgba(255, 255, 255, 0);
	color: black;
	width: 100px;
}

#simpleformbtn2:hover {
	border-width: 2px;
	padding: 5px 11px;
}
</style>
</head>
<body>
	<div id="main2">
	<div class="h"><h2>주문 내역 간략보기 </h2></div>
	<input type="button" onclick="javascript:window.open('goodsReturnList.mall?id=${id}','반품목록','width=500, height=500, scrollbar=yes' )" value="반품목록" class="btn btn-warning" id="simpleformbtn">
	<form action="orderReturnDetailForm.mall" method="post">
	<table align="center" class="orderlistsimpletb">

			<tr>
				<th>주문일자</th>
				<th><p>주문번호
				<p> 상품명</th>
				<th>총 결제금액</th>
				<th>주문상태</th>
				<th></th>
			</tr>
		
			<c:forEach var="list" items="${list }" varStatus="status">
				<c:set var="rowCount" value="${status.count }"/>
			</c:forEach>
			
			<c:forEach var="list" items="${list }" varStatus="i">
				<tr>
					<td width="30%" align="center" >${list.order_dt }
					<p><img src="../images/${list.gender }/${list.top_category}/${list.middle_category}/thumbnail/${list.path }.png"
													height="50%" width="50%" >
					</td>
					<td width="15%" align="center">
					<input type="hidden" name="order_sq" value="${list.order_sq }" id="order_sq${i.index }">
						${list.order_sq }<p>
						<br>
							${list.nm }
							<c:if test="${list.cnt > 1 }">
								 외 ${list.cnt - 1 }건
							</c:if>	
						</td>
						<c:choose>
							<c:when test="${list.origin_price < 30000 }">
								<c:set var="delivery_fee" value="2500" />
							</c:when>
							<c:otherwise>
								<c:set var="delivery_fee" value="0" />
							</c:otherwise>
						</c:choose>

						<td width="400" align="center" >
						총 ${list.origin_price+ delivery_fee} 원
					</td>
					<td width="10%" align="center" >
						${list.order_cd }
					</td>
					<td width="10%" align="center">
					<input type="button" value="상세보기" onclick="getDetail('order_sq${i.index }');" class="btn" id="simpleformbtn2">
					</td>
				</tr>
			</c:forEach>
	</table>
</form>
</div>
</body>
</html>