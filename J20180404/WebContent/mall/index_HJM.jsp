<%@page import="com.cheapmall.dto.CartDto"%>
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
	window.onload = function(){
		photoReview(1);
		simpleReview(1);
	}
	// simple review
	function simpleReview(page){
		// Hard Coding!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		//var cd = '${cd}';
		var cd = 'TSH0000001';
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
</script>
</head>
<body>

	<form action="UserMyPageForm.mall">
		<input type="submit" value="mypage">
	</form>

#################################################################

	<div>
		<form action="OrderDetailForm.mall" method="post">
			<!-- 
				List<CartDto> <-- cart면 sq번호가 있따.
				int total
				int delivery_pay
				session id;
			 -->
			<input type="hidden" value="" name="selectMenu"> 
			<input type="submit" value="orderDetail">
		</form>
	</div>
#################################################################
	<div id="review">
		<div id="photoReview">
			<!-- Ajax 출력 -->
			
		</div>
		-----------------------------------------------------------
		<div id="simpleReview">
			<!-- Ajax 출력 -->
			
		</div>
	</div>
#################################################################

	<div id="SimpleWriteReview">
		<form action="UserWriteReviewForm.mall">
			<input type="text" value="G000000001" name="goods_sq">
			<input type="text" value="imgroot" name="id">
			<input type="hidden" value="127.0.0.1" name="ip">
			<input type="submit" value="리뷰작성하기" onclick="" id="btnWriteReview">
		</form>
	</div>

</body>
</html>