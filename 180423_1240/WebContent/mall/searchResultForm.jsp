<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
.container {
	position: absolute;
	width: 100%;
	height: 100%;
	padding: 0;
}

.searchresultul {
	list-style: none;
	margin: 0;
	padding: 0;
	border-style: none;
	width: 100%;
	height: 300px;
}

.searchresultul li {
	width: 30%;
	height: 100%;
	margin-left: 19px;
	display: inline-block;
	/* 	border-style: solid;
	border-width: 1px; */
}

.searchresultul li img {
	width: 80%;
	height: 100%;
	margin-left: 10%;
}
</style>
</head>
<body>
	<div class="container">
		<ul class="searchresultul">
			<c:forEach var="goods" items="${list }">
				<li><a
					href="goodsDetail.mall?cd=${goods.cd}&gender=${goods.gender }&top_category=${goods.top_category}&middle_category=${goods.middle_category}">
						<img
						src="../images/${goods.gender}/${goods.top_category }/${goods.middle_category }/original/${goods.path }.png">
						<p align="center">${goods.nm }<br>${goods.price }<br>
							<c:if test="${goods.stock <= 0 }">품절</c:if>
						</p>
				</a></li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>