<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="ExcelPro.admin">
		<table>
			<tr>
				<th>택배사</th>
				<td><select name="select">
						<option value="cj">cj대한통운</option>
						<option value="lozen">로젠택배</option>
						<option value="post">우체국 택배</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="엑셀파일생성"></td>
			</tr>
		</table>
	</form>
</body>
</html>