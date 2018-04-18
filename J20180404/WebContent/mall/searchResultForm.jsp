<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
	ul {
	    list-style:none;
	    margin:0;
	    padding:0;
	    border : 1px solid black;
	}

	li {
	    margin: 20 20 20 20;
	    padding: 20 20 20 20;
	    float: left;
	    border : 1px solid black;
	}
	
	a{ }
</style>
</head>
<body>

	<ul>
		<c:forEach var="goods" items="${list }">
			<li><a href="goodsDetail.mall?cd=${goods.cd}&gender=${goods.gender }&top_category=${goods.top_category}&middle_category=${goods.middle_category}">
				<img src="../images/${goods.gender}/${goods.top_category }/${goods.middle_category }/original/${goods.path }.png">
			<p align="center">${goods.nm }<br>${goods.price }<br>
				<c:if test="${goods.stock <= 0 }">품절</c:if>
			</p></a></li>
		</c:forEach>
	</ul>
</body>
</html>