<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	<br><br><br><br>
	<div class="main">
		<h1>�ù�纰 ��۸��</h1>
		<form action="ExcelPro.admin">
			<table class="table">
				<tr>
					<th class="th">�ù��</th>
					<td class="th"><select name="select">
							<option value="cj">cj�������</option>
							<option value="lozen">�����ù�</option>
							<option value="post">��ü�� �ù�</option>
					</select></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="�������ϻ���"></td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>