<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../js/bootstrap.min.css">
<title>Cheap Mall</title>
<style type="text/css">
.h {
	text-align: center;
}

.container {
	position: absolute;
	width: 100%;
	height: 1500px;
}

#bb1, #bb2, #bb3, #bb4, #bb5 {
	background-color: rgba(255, 255, 255, 0);
	color: gray;
}

#bb1:hover, #bb2:hover, #bb3:hover, #bb4:hover, #bb5:hover {
	border-width: 2px;
}

#order {
	display: inline-block;
	position: absolute;
	left: 27%;
	top: 100px;
}

#modify {
	display: inline-block;
	position: absolute;
	left: 37%;
	top: 100px;
}

#cart {
	display: inline-block;
	position: absolute;
	left: 47%;
	top: 100px;
}

#cancel {
	display: inline-block;
	position: absolute;
	left: 55%;
	top: 100px;
}

#memberCancel {
	display: inline-block;
	position: absolute;
	left: 63%;
	top: 100px;
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="h">MY PAGE</h2>
		<div id="order">
			<button onclick="location.href='OrderListSimpleForm.mall'"
				class="btn btn-primary btn-hover" id="bb1">주문내역 조회</button>
		</div>

		<div id="modify">
			<button onclick="location.href='UserModifyForm.mall'"
				class="btn btn-success" id="bb2">회원정보 수정</button>
		</div>

		<div id="cart">
			<button onclick="location.href='ordersCartList.mall'"
				class="btn btn-info" id="bb3">장바구니</button>
		</div>
		<div id="cancel">
			<button onclick="location.href='OrderUserCancleForm.mall'"
				class="btn btn-warning" id="bb4">주문취소</button>
		</div>
		<div id="memberCancel">
			<button onclick="location.href='userRemoveForm.mall'"
				class="btn btn-danger" id="bb5">회원탈퇴</button>
		</div>
	</div>
</body>
</html>