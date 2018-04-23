<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style>
	#main{
		display:flex;
	}
</style>
<script type="text/javascript">
	document.getElementById('nowDate').valueAsDate=new Date();
</script>
</head>
<body>
	<h2>팝업 수정</h2>
	
	<div id="main">
		<form action="adminPopupModifyPro.admin" enctype="multipart/form-data" method="post">
			
			Id: 	<input type="text" name="sq" 		value="${sq }" 		readonly><p>
			이름: 	<input type="text" name="nm" 		value="${nm }" 		required="required"><p>
			시작일: 	<input type="date" name="start_dt" 	value="${start_dt }"required="required"><p>
			종료일: 	<input type="date" name="end_dt" 	value="${end_dt }"	required="required"><p>
			
			<input type="submit" value="수정" style="float:right;">
		</form>
	</div>
</body>
</html>