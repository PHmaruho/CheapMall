<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$('#check').click(function() {
			var id = $('#cd').val();
			var sendData = "id=" + id;
			$.post('CodeCheckAdmin.admin', sendData, function(msg) {
				$('#msg').html(msg);
			});
			return false;
		});
	});
</script>
<script type="text/javascript">
	function check1() {
		var result = $('#result').val();
		var cd = $('#cd').val();
		if (result != 3) {
			alert("중복확인을 해주세요");
			return false;
		}
		if (cd == null) {
			alert("공백은 못넣습니다");
		}
		var result1 = $('#result1').val();
		if (result1 == 1) {
			var con = confirm("존재하는 코드를 사용하시겠습니까?");
			if (con == true) {
				return true;
			} else if (con == false) {
				return false;
			}
		} else if (result1 == 2) {
			return true;
		}
	}
</script>
</head>
<body>
	<form action="GoodsAdminInsertPro.admin" enctype="multipart/form-data"
		method="post" onsubmit="return check1()">
		<table>
			<tr>
				<td>상품명</td>
				<td colspan="2"><input type="text" name="nm"
					required="required"></td>
			</tr>
			<tr>
				<td>상품코드</td>
				<td><input type="text" name="cd" id="cd" required="required">
					<input type="button" name="check" id="check" value="중복확인"></td>
				<td><span id="msg"></span></td>
			</tr>
			<tr>
				<td>시작일</td>
				<td colspan="2"><input type="date" name="start_dt"
					required="required"></td>
			</tr>
			<tr>
				<td>종료일</td>
				<td colspan="2"><input type="date" name="end_dt"
					required="required"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td colspan="2"><input type="text" name="price"
					required="required"></td>
			</tr>

			<tr>
				<td>성별</td>
				<td colspan="2"><select name="gender">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='GT' && board.used == 'Y'}">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>대분류</td>
				<td colspan="2"><select name="top_category">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='0T' && board.used=='Y' }">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>소분류</td>
				<td colspan="2"><select name="middle_category">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='1T' && board.used=='Y' }">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>색</td>
				<td colspan="2"><c:forEach var="board" items="${list }">
						<c:if test="${board.category=='CT' && board.used=='Y' }">
							<input type="checkbox" name="color" value="${board.meaning }">${board.meaning }
							</c:if>
					</c:forEach></td>
			</tr>
			<tr>
				<td>사이즈</td>
				<td colspan="2"><select name="size">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='ST' && board.used=='Y' }">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>사진등록</td>
				<td colspan="2"><input type="file" name="upload"></td>
			</tr>
			<tr>
				<td>재고</td>
				<td colspan="2"><input type="text" name="stock"
					required="required"></td>
			</tr>
			<tr>
				<td>노출여부</td>
				<td colspan="2"><select name="display">
						<option value="Y">Y
						<option value="N" selected="selected">N
				</select></td>
			</tr>
			<tr>
				<td colspan="3"><input type="submit" value="등록"> <input
					type="button" value="취소" onclick=""></td>
			</tr>
		</table>
	</form>
</body>
</html>