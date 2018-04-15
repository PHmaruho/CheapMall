<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
	div{
		width : 30%;
		height : 500px;
		float : left;
		border: 2px;
		text-align: center;
	}
</style>
</head>
<body>
<h2> MY PAGE </h2>

<div id="order">
	<a href="goodsUserReturnForm.mall">
		주문내역 조회
	</a>
</div>

<div id="modify">
	<a href="UserModifyForm.mall">
		회원정보 수정
	</a>
</div>

<div id="cart">
	<a href="ordersCartList.mall">
		장바구니
	</a>
</div>
</body>
</html>