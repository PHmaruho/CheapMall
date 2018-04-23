<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		$('#check').click(function(){
			var id=$('#code').val();
			var sendData="id="+id;
			$.post('CodeCheck.admin',sendData,function(msg){
				$('#msg').html(msg);
			});
			return false;
		});
	});
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<form action="CodeInsertPro.admin?pageNum=${pageNum }" method="post">
			<table>
				<tr>
					<th>코드</th>
					<td>
					<input type="text" name="code" id="code" required="required">
					<input type="button" name="check" id="check" value="중복확인"> 
					</td>
					<td>
						<span id="msg"></span>
					</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td><input type="text" name="category" required="required">
					</td>
					<td></td>
				</tr>
				<tr>
					<th>의미</th>
					<td><input type="text" name="meaning" required="required">
					</td>
					<td></td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td><input type="radio" name="used" value="Y">Y</td>
					<td><input type="radio" name="used" value="N" checked="checked">N</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2">
					<input type="submit" value="등록">
					<input type="button" value="취소" onclick="location.href='CodeList.admin'"></td>
					<td></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>