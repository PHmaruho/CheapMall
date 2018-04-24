<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../js/bootstrap.min.css">
<title>Cheap Mall</title>
<style type="text/css">
.a {
	position: absolute;
	width: 100%;
	height: 100%;
	border-style: none;
}

.glul {
	list-style: none;
	margin: 0;
	padding: 0;
	border-style: none;
	width: 100%;
	height: 300px;
}

.glul li {
	width: 30%;
	height: 100%;
	margin-left: 19px;
	display: inline-block;
	/* 	border-style: solid;
	border-width: 1px; */
}

.glul li img {
	width: 60%;
	height: 100%;
	margin-left: 10%;
}
</style>
</head>
<body>
	<div class="a">
		<ul class="glul">
			<c:forEach var="goods" items="${list }">
				<li><a
					href="goodsDetail.mall?cd=${goods.cd}&gender=${gender }&top_category=${goods.top_category}
						&middle_category=${goods.middle_category}">
						<img align="middle"
						src="../images/${gender}/${goods.top_category }/${goods.middle_category }/thumbnail/sm_${goods.path }.png">
						<p align="center">${goods.nm }<br>${goods.price }<br>
							<c:if test="${goods.stock <= 0 }">품절</c:if>
						</p>
				</a></li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>