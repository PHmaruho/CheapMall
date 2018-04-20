<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<style type="text/css">
	.review{
		font-size: 20px;	
	}
	.reviewStar{
		width: 100px;
	}
	.reviewContent{
		width: 450px;
	}
	.reviewContents{
		width: 670px;
	}
	.reviewId{
		width: 150px;
	}
	.reviewImg{
		width:200px;
	}
	.reviewUp .reviewDown{
		width: 100px;
	}
	.reviewDt{
		width: 150px;
	}
	#simpleReview #photoReview{
		line-height: 200px;
		vertical-align: middle;
	}
	
</style>

<script type="text/javascript">
// HJM
window.onload = function(){
		photoReview(1);
		simpleReview(1);
	}
	// simple review
	function simpleReview(page){
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
				var list = jQuery.parseJSON(data);
				var simple = $('#simpleReview');
				
				var str = "";
				//alert(data);
				simple.html("");
				
				str += "<table class='table table-hover'>";
				str += "<tr class=''><td colspan='7' class='review' style='text-align:left;'>간편리뷰</td></tr>"
				str += "<tr class=''><td colspan='7' class='review'>평균평점" + list.totalStar + "/5</td></tr>";
					if(list.totCnt != 0){
						$.each(list.review, function(){
							// good or bad image
							str += "<tr><td class='review reviewStar'><img src='../images/review/icon/";
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
								str += "<td class='review reviewContents'>" 
										+ "<a href='#' onclick='open'"
											+ this.content.substring(0, 30)
										+ ""
									+ "</td>";
							} else {
								str += "<td class='review reviewContents'>" + this.content + "</td>";
							}
							
							// userid // a href 추가 예정
							str += "<td class='review reviewId'>"
										+ this.user_id +
										"<input type='button' value='신고' onclick='reportUser(\""+this.user_id+"\")'>"
								   "</td>";
							
							// up/down button a href
							str += "<td class='review reviewUp'><img src='../images/review/icon/up.png'>UP("+this.up+")</td>";
							str += "<td class='review reviewDown'><img src='../images/review/icon/down.png'>DOWN("+this.down+")</td>";
							
							//write_dt
							str += "<td class='review reviewDt'>"+this.write_dt+"</td>";
							str += "<td class='review reviewDt'>"+this.cnt+"</td>";
							str += "</tr>";
						});
					} else {
						simple.append("<tr class='review reviewNot'><td> 데이터가 없습니다.</td></tr>");
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
		var cd = '${cd}';
		var pageNum = page;
		
		$.ajax({
			type: "POST",
			url: "GoodsReviewPro.mall",
			data: {goods_cd:cd,
				   pageNum:pageNum,
				   reviewType:'photo'},
			success: function(data){
				var list = jQuery.parseJSON(data);
				var simple = $('#photoReview');
				
				
				var str = "";
				//alert(data);
				simple.html("");
				
				str += "<table class='table table-hover center-block'>";
				str += "<tr class=''><td colspan='7' class='review' style='text-align:left;'>포토리뷰</td></tr>"
				str += "<tr class=''><td colspan='7' class='review'>평균평점" + list.totalStar + "/5</td></tr>";
					if(list.totCnt != 0){
						$.each(list.review, function(){
							// good or bad image
							str += "<tr><td class='review reviewStar'><img src='../images/review/icon/";
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
							str += "<td class='review reviewImg'><img src='../images/review/thumb/sm_"+this.path+".png'></td>";
							
							
							// content
							if(this.content.length >= 30){
								str += "<td class='review reviewContent'><a href='#' onclick='viewContent(\""+this.sq+"\")'>" + this.content.substring(0, 30) + "</a></td>";
							} else {
								str += "<td class='review reviewContent'><a href='#' onclick='viewContent(\""+this.sq+"\")'>" + this.content + "</a></td>";
							}
							
							// userid // a href 추가 예정
							str += "<td class='review reviewId'>"
										+ this.user_id +
										"<input type='button' value='신고' onclick='reportUser(\""+this.user_id+"\")'>"
								   "</td>";
							
							// up/down button a href
							str += "<td class='review reviewUp'><img src='../images/review/icon/up.png'>UP("+this.up+")</td>";
							str += "<td class='review reviewDown'><img src='../images/review/icon/down.png'>DOWN("+this.down+")</td>";
							
							//write_dt
							str += "<td class='review reviewDt'>"+this.write_dt+"</td>";
							str += "<td class='review reviewDt'>"+this.cnt+"</td>";
							str += "</tr>";
						});
					} else {
						simple.append("<tr><td reviewNot> 데이터가 없습니다.</td></tr>");
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
	
	function viewContent(sq){
		//var popup = window.open('ReviewPopUp.mall?sq='+sq,'popup', "width=500, height=500");
		alert(sq);
	}
	
	function reportUser(id){
		// 여기부분은 알아서 수정하시오!
		
		alert(id);
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