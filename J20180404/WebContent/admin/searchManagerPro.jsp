<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
	<head>
		<title>123</title>
		<style type="text/css">
			li{
				width: 100%;
				list-style-type: none;
			}
			li:hover {
				background-color: yellow;
			}
		</style>
	</head>
	<script type="text/javascript">
		
	</script>
	<body>
		<c:if test="${jsonObject.overlap eq 'overlap' }">
			${jsonObject.result }
		</c:if>
		
		<c:if test="${jsonObject.overlap eq 'search' }">
			<ul>
				<c:forEach var="keywordList" items="${jsonObject.keywords }">
					<li id="li" ondblclick="selectKeyword(this)">
						${keywordList }
					</li>
				</c:forEach>		
			</ul>
		</c:if>
		
		<c:if test="${jsonObject.overlap eq 'regist' }">
			${jsonObject.result }
		</c:if>
		<c:if test="${jsonObject.overlap eq 'modify' }">
			${jsonObject.tag } @ ${jsonObject.tag2 }
		</c:if>
		
	</body>
</html>