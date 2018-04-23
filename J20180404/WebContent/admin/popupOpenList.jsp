<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>

<style>
img {
	max-width: 100%;
	width: 400px;
}
</style>

</head>
<body>

	<c:if test="${result>0 }">
		<img src='/J20180404/images/popup/${url }.jpg'>
	</c:if>
	
	<c:if test="${result==0 }">
		<img src='/J20180404/images/popup/noPopup.jpg'>
	</c:if>
</body>
</html>