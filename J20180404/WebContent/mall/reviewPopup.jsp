<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<style type="text/css">
	.reviewTd{
		width:70px;
	}
</style>
<script type="text/javascript">

	// 리뷰 삭제
	function deleteReview(){
		var warning = confirm("삭제하시겠습니까?");
		var sq = '${reviewDto.sq}';
		var writer = '${reviewDto.user_id}';
		if(warning == true){
			location.href="ReviewDetailPro.mall?type=delete&sq="+sq+"&writer="+writer;
		} else {
			return false;
		}
	}
	
	// 창닫기
	function close(){
		close();
	}
</script>
</head>
<body>
<h3 class="h3">포토리뷰</h3>
<table class="table table-bordered" style="width: 500px;">
	<tr>
		<td class="reviewTd">회원 ID</td>
		<td colspan="3" style="width:300px;">
			${reviewDto.user_id }
		</td>
	</tr>
	<tr>
		<td class="reviewTd">평점 : </td>
		<td style="width:150px;">
			<c:forEach begin="1" end="${reviewDto.star }">
				★
			</c:forEach>
		</td>
		<td style="width:100px;"><img src="../images/review/icon/up.png">UP(${reviewDto.up })</td>
		<td style="width:100px;"><img src="../images/review/icon/down.png">DOWN(${reviewDto.down })</td>
	</tr>
	<tr>
		<td class="reviewTd">작성일</td>
		<td>
			${reviewDto.write_dt }
		</td>
		<td class="reviewTd">클릭수</td>
		<td>
			${reviewDto.cnt }
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="../images/review/origin/${reviewDto.path }.png">
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td colspan="3">
			<div style="overflow-y: scroll; height:400px;">
				${reviewDto.content }
			</div>
			
		</td>
	</tr>
	<tr>
		<c:choose>
			<c:when test="${id ne null }">
				<td colspan="4">
					<input type="button" value="삭제하기" onclick="deleteReview()">
					<!-- <input type="button" value="수정하기" onclick="">  -->
					<input type="button" value="닫기" onclick="close()">
				</td>
			</c:when>
			<c:when test="${id eq null }">
				<td colspan="4">
					<input type="button" value="닫기" onclick="close()">
				</td>
			</c:when>
		</c:choose>
	</tr>
</table>
</body>
</html>