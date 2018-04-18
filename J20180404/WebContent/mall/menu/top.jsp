<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">

function searchFunc(){
	var icon = document.getElementById("searchIcon");
	var search = document.getElementById("searchInput");
	var searchDiv = document.getElementById("searchDiv");
	
	searchDiv.style.width = "200px";
	icon.className = icon.className.replace("show", "none");
	search.className = search.className.replace("none", "show");
}

// JSY popup
function popAction(){
	window.open
	('../admin/popupOpen.admin','Cheap Mall','width=400px, height=500px,left='+(screen.availWidth-660)/2+',top='+(screen.availHeight-430)/2);
	location.href="cheapmall.jsp";
	}
</script>
<style type="text/css">
.topDiv{
	width:100%;
	height: 100px;
}

.logoDiv {
	float: left;
	border-width: 1px;
	width: 100px;
	height: 90px;
	background-color: green;
}

.cartDiv {
	float: right;
	border-width: 1px;
	width: 100px;
	height: 90px;
	background-color: yellow;
}

.loginDiv {
	float: right;
	border-width: 1px;
	width: 100px;
	height: 90px;
	background-color: pink;
}

.myDiv{
	float: right;
	border-width: 1px;
	width: 100px;
	height: 90px;
	background-color: purple;
}

.searchDiv {
	float: right;
	border-width: 1px;
	width: 100px;
	height: 90px;
	background-color: gray;
}
.none{
	display: none;
}

.show{
	display: block;
}

#keywordResult{
	position: relative;
	z-index: 1;
	left: 0px;
	width: 200px;
	height: 300px;
	background-color: white;
}

li{
	text-align: left;
	width: 100%;
	list-style-type: none;
	background-color: white;
}
li:hover{
	background-color: yellow;
	font-size: 20px;
}
</style>

</head>
<body>
	<div class="topDiv">
		<div class="logoDiv" onclick="popAction()">logo</div>
		<!-- Ajax로 장바구니 개수 추가 예정 -->
		<div class="cartDiv">
			<a href="ordersCartList.mall">cart</a>
		</div>
		<c:if test="${id != null}">
			<div class="myDiv">
				<a href="UserMyPageForm.mall">
					회원상세정보
				</a>
			</div>
		</c:if>
		<c:if test="${id != null}">
			<div class="loginDiv">
				<a href="Logout.mall">
					Logout
				</a>
			</div>
		</c:if>
		<!-- id == '' or id eq '' 이거 하지말 것!!!!!!! -->
		<c:if test="${id == null}">
			<div class="loginDiv">
				<a href="UserLoginForm.mall">
					login
				</a>
			</div>
		</c:if>
		<div class="searchDiv" id="searchDiv">
			<div class="show" id="searchIcon">
				<a onclick="searchFunc()" href="#">search</a>
			</div>
			<div class="none" id="searchInput" >
				<input type="text" width="15" id="search" onkeypress="searchAction1(event)"><input type="button" value="검색하기" onclick="">
				<!-- Ajax 출력 구간 -->
				<div id="keywordResult" class="keywordResult none"></div>
				
			</div>
		</div>
	</div>
</body>

</html>