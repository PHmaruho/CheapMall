<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
</head>
<body>
 	<table>
	<tr><th>상품코드</th><th>상품명</th></tr>
		<c:forEach var="goods" items="${list }">
				<tr>
					<td><a href="#" onclick="updateOpener('${goods.cd }')">${goods.cd }</a></td>
					<td><a href="#" onclick="updateOpener('${goods.cd }')">${goods.nm }</a></td>
				</tr>
			
		</c:forEach>
	</table>
</body>
</html>