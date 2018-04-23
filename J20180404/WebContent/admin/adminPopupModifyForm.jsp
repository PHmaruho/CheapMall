<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<link rel="stylesheet" href="style.css" type="text/css">

<style>
	
</style>
<script type="text/javascript">
	document.getElementById('nowDate').valueAsDate=new Date();
</script>
</head>
<body>
	<h3>팝업 수정</h3>
	<div id="main" class="main">
		<form action="adminPopupModifyPro.admin" enctype="multipart/form-data" method="post">
			<table class="tableP" border="1">
			<tr>
		<th class="th">Id</th>
		<td> <input type="text" name="sq" 		value="${sq }" 		readonly></td></tr>
		<tr>
		<th class="th">이름</th>
		<td><input type="text" name="nm" 		value="${nm }" 		required="required"></td></tr>
		<tr>
		<th class="th">시작일</th>
		<td><input type="date" name="start_dt" 	value="${start_dt }"required="required"></td></tr>
		<tr>
		<th class="th">종료일</th>
		<td><input type="date" name="end_dt" 	value="${end_dt }"	required="required"></td></tr>
  	 		</table>
  	 
  	 <br>
  	 <div class="mainF" >
			<input type="submit" class="btn mini" value="수정" >
				</div>
		</form>
	</div>
</body>
</html>