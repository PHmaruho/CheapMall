<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	function searchFunc() {
		var icon = document.getElementById("searchIcon");
		var search = document.getElementById("searchInput");
		var searchDiv = document.getElementById("searchDiv");

		/* searchDiv.style.width = "200px"; */
		icon.className = icon.className.replace("show", "none");
		search.className = search.className.replace("none", "show");
	}

	// JSY popup
	function popAction() {
		window.open('../admin/popupOpen.admin', 'Cheap Mall',
				'width=400px, height=500px,left=' + (screen.availWidth - 660)
						/ 2 + ',top=' + (screen.availHeight - 430) / 2);
		location.href = "cheapmall.jsp";
	}
</script>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<style type="text/css">
.topDiv {
	position: absolute;
	width: 100%;
	height: 100%;
	border-style: none;
	background-image: url(../images/header.jpg);
	background-repeat: no-repeat;
	background-size: cover;
}

.none {
	display: none;
}

.show {
	display: block;
	border-style: none;
}

#keywordResult {
	position: relative;
	z-index: 1;
	left: 0px;
	width: 200px;
	height: 100%;
}

#b1, #b2, #b3, #b4, #b5 {
	border-style: solid;
	border-width: 1px;
	border-color: gray;
	background-color: rgba(255, 255, 255, 0);
	color: black;
}

#b1:hover, #b2:hover, #b3:hover, #b4:hover, #b5:hover, #searchIcon:hover
	{
	border-width: 2px;
}
/*home*/
#b1 {
	position: absolute;
	left: 86%;
	top: 75%;
}
/*cart*/
#b2 {
	position: absolute;
	left: 82.5%;
	top: 75%;
}
/*상세정보*/
#b3 {
	position: absolute;
	left: 70.5%;
	top: 75%;
}
/*logout*/
#b4 {
	position: absolute;
	left: 78%;
	top: 75%;
}
/*login*/
#b5 {
	position: absolute;
	left: 78.5%;
	top: 75%;
}
/*search*/
#searchDiv{
	position: absolute;
	width: 50%;
	height: 100%;
}
#searchIcon {
	position: absolute;
	left: 4.5%;
	top: 50%;
	width : 100px;
	background-color: rgba(255, 255, 255, 0);
	color: black;
}
#search{
	position: absolute;
	top: 78%;
	left: 1%;
}
#searchbtn{
	position: absolute;
	top: 75%;
	left: 47%;
}
#searchInput{
	position: absolute;
	width: 50%;
	height: 100%;
}
</style>

</head>
<body>
	<div class="topDiv">
		<button class="logoDiv btn" onclick="popAction()" id="b1">home</button>
		<!-- Ajax로 장바구니 개수 추가 예정 -->

		<button class="cartDiv btn"
			onclick="location.href='ordersCartList.mall'" id="b2">cart</button>


		<c:if test="${id != null}">
			<button class="myDiv btn"
				onclick="location.href='UserMyPageForm.mall'" id="b3">회원상세정보</button>
		</c:if>
		<c:if test="${id != null}">
			<button class="logOutDiv btn" onclick="location.href='Logout.mall'"
				id="b4">logout</button>
		</c:if>
		<!-- id == '' or id eq '' 이거 하지말 것!!!!!!! -->
		<c:if test="${id == null}">
			<button class="loginDiv btn"
				onclick="location.href='UserLoginForm.mall'" id="b5">login</button>
		</c:if>
		<div class="searchDiv" id="searchDiv">
			<button class="show btn btn-success" id="searchIcon" onclick="searchFunc()">search</button>
			<div class="none" id="searchInput">
				<input type="text" width="15" id="search"
					onkeypress="searchAction1(event)"><input type="button"
					value="검색하기" onclick="" class="btn" id="searchbtn">
				<!-- Ajax 출력 구간 -->
				<div id="keywordResult" class="keywordResult none"></div>

			</div>
		</div>
	</div>
</body>

</html>