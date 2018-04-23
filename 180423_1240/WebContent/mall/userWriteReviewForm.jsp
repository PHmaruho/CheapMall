<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script src="../js/jquery.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
	window.onload= function(){
		$("#simpleReview").css("display","block");
		//$("#photoReview").css("display","none");
	}
	function swt(r){
		var id = $('#'+r);
		if(id.attr('value') == 'simple'){
			$('#simpleReview').css("display", "block");
			$('#photoReview').css("display", "none");
		} else {
			$('#simpleReview').css("display", "none");
			$('#photoReview').css("display", "block");
		}
		
	}
	function chk(){
		// 파일 확장자 체크
		var id = document.getElementById('file').value;
		var end = ['jpg', 'jpeg', 'png'];
		var result = 0;
		for(var i=0 ; i < end.length ; i++){
			if(id.indexOf(end[i]) != -1){
				alert(id); /////////////////
				result = 1;
				return true;
			}
		}
		if(result == 0){
			alert("확장자 또는 파일을 다시 확인해주세요");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<div id="select">
	<input type="radio" name="selected" id="r_simple"  value="simple" checked="checked" onclick="swt('r_simple')">간편리뷰 작성하기
	<input type="radio" name="selected" id="r_photo"  value="photo" onclick="swt('r_photo')">포토리뷰 작성하기
</div>
<div id="simpleReview">
	<h2>간단리뷰</h2>
	<form action="UserWriteReviewPro.mall?method=simple" method="post">
		<!-- hidden -->
		<input type="hidden" name="id" value="${id }">
		<input type="hidden" name="goods_sq" value="${goods_sq }">
		<input type="hidden" name="ip" value="${ip }">
		<input type="hidden" name="goods_cd" value="${goodsDto.cd }">
		
		<table border="1">
			<tr>
				<th>상품명</th>
				<td>${goodsDto.nm }</td>
			</tr>
			<tr>
				<th>옵션</th>
				<td>
					<c:if test="${goodsDto.color ne ''}">
						${goodsDto.color }
					</c:if>
					<c:if test="${goodsDto.color ne '' && goodsDto.goods_size ne ''}">
						&nbsp; / &nbsp;
					</c:if>
					<c:if test="${goodsDto.goods_size ne ''}">
						${goodsDto.goods_size }
					</c:if>
				</td>
				
				
			</tr>
			<tr>
				<th>작성자</th>
				<td>${id }</td>
			</tr>
			<tr>
				<th>별점 주기</th>
				<td>
					<input type="radio" name="star" value="5" checked="checked">★★★★★ / 
					<input type="radio" name="star" value="4">★★★★ / 
					<input type="radio" name="star" value="3">★★★ / 
					<input type="radio" name="star" value="2">★★ / 
					<input type="radio" name="star" value="1">★
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="30" cols="50" name="content" required="required"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="작성하기">
					<input type="reset" value="초기화">
					<input type="button" value="작성취소" id="cancle">
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="photoReview" style="display:none;">
	<h2>사진 리뷰</h2>
	<form action="UserWriteReviewPro.mall?method=photo" method="post" enctype="multipart/form-data" onsubmit="return chk()">
		<!-- hidden -->
		<input type="hidden" name="id" value="${id }">
		<input type="hidden" name="goods_sq" value="${goods_sq }">
		<input type="hidden" name="ip" value="${ip }">
		<input type="hidden" name="goods_cd" value="${goodsDto.cd }">
		
		<table border="1">
			<tr>
				<th>상품명</th>
				<td>${goodsDto.nm }</td>
			</tr>
			<tr>
				<th>옵션</th>
				<td>
					<c:if test="${goodsDto.color ne ''}">
						${goodsDto.color }
					</c:if>
					<c:if test="${goodsDto.color ne '' && goodsDto.goods_size ne ''}">
						&nbsp; / &nbsp;
					</c:if>
					<c:if test="${goodsDto.goods_size ne ''}">
						${goodsDto.goods_size }
					</c:if>
				</td>
				
				
			</tr>
			<tr>
				<th>작성자</th>
				<td>${id }</td>
			</tr>
			<tr>
				<th>별점 주기</th>
				<td>
					<input type="radio" name="star" value="5" checked="checked">★★★★★ / 
					<input type="radio" name="star" value="4">★★★★ / 
					<input type="radio" name="star" value="3">★★★ / 
					<input type="radio" name="star" value="2">★★ / 
					<input type="radio" name="star" value="1">★
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="30" cols="50" name="content" required="required"></textarea>
				</td>
			</tr>
			<tr>
				<th>첨부 사진</th>
				<td><input type="file" name="pic" id="file"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="작성하기">
					<input type="reset" value="초기화">
					<input type="button" value="작성취소" id="cancle">
					<input type="button" value="test" onclick="chk()">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>