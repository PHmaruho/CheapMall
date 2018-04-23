<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<form action="GoodsAdminInsertPro.admin" enctype="multipart/form-data" method="post">
		<table>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="nm" required="required"></td>
			</tr>
			<tr>
				<td>시작일</td>
				<td><input type="date" name="start_dt" required="required"></td>
			</tr>
			<tr>
				<td>종료일</td>
				<td><input type="date" name="end_dt" required="required"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price" required="required"></td>
			</tr>

			<tr>
				<td>성별</td>
				<td><select name="gender">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='GT' && board.used == 'Y'}">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>대분류</td>
				<td><select name="top_category">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='0T' && board.used=='Y' }">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>소분류</td>
				<td><select name="middle_category">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='1T' && board.used=='Y' }">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>색</td>
				<td><select name="color">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='CT' && board.used=='Y' }">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>사이즈</td>
				<td><select name="size">
						<c:forEach var="board" items="${list }">
							<c:if test="${board.category=='ST' && board.used=='Y' }">
								<option value="${board.cd }">${board.meaning }</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>사진등록</td>
				<td>
					<input type="file" name="upload">
				</td>
			</tr>
			<tr>
				<td>재고</td>
				<td>
					<input type="text" name="stock" required="required">
				</td>
			</tr>
			<tr>
				<td>노출여부</td>
				<td>
					<select name="display">
						<option value="Y">Y
						<option value="N" selected="selected">N
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록">
					<input type="button" value="취소" onclick="">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>