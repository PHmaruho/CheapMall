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
	
	#but{
		padding: 10 10 10 10px!important!;
		float:right;
	}
</style>
</head>
<body>
	<h2>팝업 등록</h2>
	
	<div id="main">
		
		<form action="adminPopupAddFormPro.admin" enctype="multipart/form-data" method="post" >
			분류: <select name="category">
					<option value="Main">main</option>
					<option value="sub">sub</option>
				</select>
			<p>
				이름: <input type="text" name="nm"> <p>
				경로: <input type="file" name="url"> <p>
				시작일: <input type="date" name="start_dt"> <p>
				종료일: <input type="date" name="end_dt"><p> 
					
					<div id="but">
						<input type="submit" value="등록"> 
						<input type="reset" value="취소">
					</div>
		</form>
	</div>
</body>
</html>