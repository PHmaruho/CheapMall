<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
// HJM
window.onload = function(){
		photoReview(1);
		simpleReview(1);
	}
	// simple review
	function simpleReview(page){
		// Hard Coding!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		var cd = '${cd}';
		var pageNum = page;
		
		$.ajax({
			type: "POST",
			url: "GoodsReviewPro.mall",
			data: {goods_cd:cd,
				   pageNum:pageNum,
				   reviewType:'simple'},
			success: function(data){
				// json 파싱작업
				var list = JSON.parse(data);
				var simple = $('#simpleReview');
				
				var str = "";
				//alert(data);
				simple.html("");
				
				str += "<table border='1'>";
					if(list.totCnt != 0){
						$.each(list.review, function(){
							// good or bad image
							str += "<tr><td><img src='../images/review/icon/";
								if(this.star == '5'){
									str += "5.png'>"
								} else if(this.star == '4'){
									str += "4.png'>"
								} else if(this.star == '3'){
									str += "3.png'>"
								} else if(this.star == '2'){
									str += "2.png'>"
								} else if(this.star == '1'){
									str += "1.png'>"
								}
							str += "</td>";
							
							// content
							if(this.content.length >= 30){
								str += "<td>" + this.content.substring(0, 30) + "</td>";
							} else {
								str += "<td>" + this.content + "</td>";
							}
							
							// userid // a href 추가 예정
							str += "<td>" + this.user_id +"</td>";
							
							// up/down button a href
							str += "<td><img src='../images/review/icon/up.png'>UP("+this.up+") / ";
							str += "<td><img src='../images/review/icon/down.png'>DOWN("+this.down+")";
							
							//write_dt
							str += "<td>"+this.write_dt+"</td>";
							str += "<td>"+this.cnt+"</td>";
							str += "</tr>";
						});
					} else {
						simple.append("<tr><td> 데이터가 없습니다.</td></tr>");
					}
					str += "</table>";
					simple.append(str);
				
				// blockSize
				var str2 = "";
				str2 += "<div style='text-align: center;background-color: pink;'>";
					if(list.startPage > list.blockSize){
						str2 += "<a href='javascript:simpleReview("+(list.startPage - list.blockSize)+");'>[이전]</a>";
					}
					for(var i = list.startPage ; i <= list.endPage ; i++){
						str2 += "<a href='javascript:simpleReview("+i+");'>["+i+"]</a>";
					}
					if(list.endPage < list.pageCnt){
						str2 += "<a href='javascript:simpleReview("+(list.startPage + list.blockSize)+");'>[다음]</a>"
					}
				str2 += "</div>";
				simple.append(str2);
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
	function photoReview(page){
		// Hard Coding!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		//var cd = '${cd}';
		var cd = 'TSH0000001';
		var pageNum = page;
		
		$.ajax({
			type: "POST",
			url: "GoodsReviewPro.mall",
			data: {goods_cd:cd,
				   pageNum:pageNum,
				   reviewType:'photo'},
			success: function(data){
				var list = JSON.parse(data);
				var simple = $('#photoReview');
				
				
				var str = "";
				//alert(data);
				simple.html("");
				
				str += "<table border='1'>";
					if(list.totCnt != 0){
						$.each(list.review, function(){
							// good or bad image
							str += "<tr><td><img src='../images/review/icon/";
								if(this.star == '5'){
									str += "5.png'>"
								} else if(this.star == '4'){
									str += "4.png'>"
								} else if(this.star == '3'){
									str += "3.png'>"
								} else if(this.star == '2'){
									str += "2.png'>"
								} else if(this.star == '1'){
									str += "1.png'>"
								}
							str += "</td>";
							// image
							str += "<td><img src='../images/review/thumb/sm_"+this.path+".png'></td>";
							
							// content
							if(this.content.length >= 30){
								str += "<td>" + this.content.substring(0, 30) + "</td>";
							} else {
								str += "<td>" + this.content + "</td>";
							}
							
							// userid // a href 추가 예정
							str += "<td>" + this.user_id +"</td>";
							
							// up/down button a href
							str += "<td><img src='../images/review/icon/up.png'>UP("+this.up+") / ";
							str += "<td><img src='../images/review/icon/down.png'>DOWN("+this.down+")";
							
							//write_dt
							str += "<td>"+this.write_dt+"</td>";
							str += "<td>"+this.cnt+"</td>";
							str += "</tr>";
						});
					} else {
						simple.append("<tr><td> 데이터가 없습니다.</td></tr>");
					}
					str += "</table>";
					simple.append(str);
				
				// blockSize
				var str2 = "";
				str2 += "<div style='text-align: center;background-color: pink;'>";
					if(list.startPage > list.blockSize){
						str2 += "<a href='javascript:photoReview("+(list.startPage - list.blockSize)+");'>[이전]</a>";
					}
					for(var i = list.startPage ; i <= list.endPage ; i++){
						str2 += "<a href='javascript:photoReview("+i+");'>["+i+"]</a>";
					}
					if(list.endPage < list.pageCnt){
						str2 += "<a href='javascript:photoReview("+(list.startPage + list.blockSize)+");'>[다음]</a>"
					}
				str2 += "</div>";
				simple.append(str2);
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
	
	//CWI
	$(function() {
		$(document).ready(function() {
			var cd = $('#cd').attr('value');
			var color = $('#0').attr('value');
			var sendData = "cd=" + cd + "&color=" + color;
			$.post('goodsDetailSizeAjax.mall', sendData, function(size) {
				$('#sizePanel').html(size); 
			});
			$.post('goodsDetailPictureAjax.mall', sendData, function(picture) {
				$('#picture').html(picture); 
			});
			return false;
		});
	});
	
 	$(function() {
		$('.colorButton').click(function() {
			var cd = $('#cd').attr('value');
			var color = $(this).attr('value');
			var sendData = "cd=" + cd + "&color=" + color;
			$.post('goodsDetailSizeAjax.mall', sendData, function(size) {
				$('#sizePanel').html(size); 
			});
			$.post('goodsDetailPictureAjax.mall', sendData, function(picture) {
				$('#picture').html(picture); 
			});
			return false;
		});
	});
 	
 	$(function() {
		$('#askCart').click(function() {
			var e = document.getElementById("size");
			
			var cd = $('#cd').attr('value');
			var price = $('#price').attr('value');
			var color = $('#selectedColor').attr('value');
			var size = e.options[e.selectedIndex].value;
			var cnt = document.getElementById("cnt").value;
			
			if (size != "") {
				if (cnt > 0) {
					var sendData = "cd=" + cd + "&color=" + color + "&size=" + size + "&cnt=" + cnt+ "&price=" + price;
					$.post('ordersAddCart.mall', sendData, function(cart) {
						$('#cart').html(cart);}
					);
				} else {
					alert("수량을 선택해주세요.")
				}
			} else {
				alert("사이즈가 선택되지 않았습니다.");
			}
			return false;
		});
	});
 	
 	function askCart() {
 		if (confirm("장바구니에 추가되었습니다.\n장바구니로 이동하시겠습니까?")) {
			location.href="ordersCartList.mall";
 		}
 	}
 	
 	function toPay() {
 		var e = document.getElementById("size");
		var cd = $('#cd').attr('value');
		var price = $('#price').attr('value');
		var color = $('#selectedColor').attr('value');
		var size = e.options[e.selectedIndex].value;
		var cnt = document.getElementById("cnt").value;
		if (size != "") {
			if (cnt > 0) {
		 		location.href="ordersDetailToPay.mall?cd="+cd+"&price="+price+"&color="+color+"&size="+size+"&cnt="+cnt;
			} else {
				alert("수량을 선택해주세요.")
			}
		} else {
			alert("사이즈가 선택되지 않았습니다.");
		}
 	}

</script>
<style type="text/css">
	.colorButton {
	    border: none;
	    padding: 20px;
	    display: inline-block;
	    margin: 4px 2px;
	    border-radius: 50%;
	}
	.sold{
		opacity: 0.1;
	}
</style>
</head>
<body>
	${gender } > ${top_category } > ${middle_category }
	
	<div class="price">
	<p>${detailDto.nm }<br>${detailDto.price }</p>
		
	</div>
	
	<div class="colorPanel">
		<input type="hidden" value="${cd }" id="cd">
		<input type="hidden" value="${detailDto.price }" id="price">
		<c:forEach var="color" items="${colorList }" varStatus="status">
			<c:choose>
				<c:when test="${color.stock >= 1 }">
					<button class="colorButton" style="background-color: ${color.color};"
						value="${color.color}" id="${status.index }"></button>${status.index }
				</c:when>
				<c:otherwise>
					<button class="colorButton sold" style="background-color: ${color.color};"
						value="${color.color }" id="${status.index }"></button>${status.index }
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div><p>
	<div>
		<input type="button" value="장바구니" id="askCart"><p>
		<input type="button" value="바로구매" onclick="toPay()">
		<input type="number" id="cnt" value="1" min="1" >
	</div>
	<div id="sizePanel">
	</div>
	<div id="picture">
	</div>
	<div id="cart">
	</div>
	
	<div id="simpleReview">
	</div>
	<div id="photoReview">
	</div>
</body>
</html>