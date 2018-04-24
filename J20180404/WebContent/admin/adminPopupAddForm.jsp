<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<link rel="stylesheet" href="style.css" type="text/css">

<style>
	#main{
		display:flex;
	}
	
</style>
</head>
<body>
	<h2>팝업 등록</h2>
	
	<div class="main">
		<form action="adminPopupAddFormPro.admin" enctype="multipart/form-data" method="post" >
		<table class="tableP" border="1">
		<tr>
			<th class="th">분류</th>
			 <td colspan="3">
			 <select name="category">
				<option value="Main">main</option>
				<option value="sub">sub</option>
				</select>
				</td>
				</tr>
				
				<tr>
				<th class="th">이름 </th>
				<td colspan="3"><input type="text" name="nm" required>
				</td>
				
				</tr>
				
				<tr>
				<th class="th">경로 </th>
				<td colspan="3"><input type="file" name="url" required>
				</td>
				</tr>
				
				<tr>
				<th class="th">시작일 </th>
				<td><input type="date" name="start_dt" required>
				</td>
				<th class="th">종료일 </th>
				<td><input type="date" name="end_dt" required>
				</td>
				</tr>
			</table>
			
				<br>
  	 <div class="mainF" >
		<input type="submit"  class="btn mini" value="등록"> 
		<input type="reset"  class="btn mini" value="초기화">
	 </div>
	 
		</form>
	</div>
</body>
</html>