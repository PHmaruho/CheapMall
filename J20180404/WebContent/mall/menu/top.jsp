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
.topDiv {
	width: 100%;
	height: 120px;
	border-style: none;
	background-image: url(../images/main2.jpg);
	background-repeat: no-repeat;
}

.searchDiv {
	float: left;
	width: 100px;
	height: 20px;
	background-color: white;
	border-style: none;
	margin-left: 20px;
	margin-top: 40px;
	background-color: rgba(255, 255, 255, 0);
}

.cartDiv {
	float: right;
	width: 100px;
	height: 20px;
	background-color: white;
	margin-right: 145px;
	border-style: none;
	margin-top: 70px;
	background-color: rgba(255, 255, 255, 0);
}

.loginDiv {
	float: right;
	width: 100px;
	height: 20px;
	background-color: white;
	border-style: none;
	margin-top: 70px;
	background-color: rgba(255, 255, 255, 0);
}

.myDiv {
	float: right;
	width: 100px;
	height: 20px;
	background-color: white;
	border-style: none;
	margin-top: 70px;
	margin-right: 15px;
	background-color: rgba(255, 255, 255, 0);
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
	background-color: white;
}

li {
	text-align: left;
	width: 100%;
	list-style-type: none;
	background-color: white;
}

li:hover {
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
				<input type="text" width="15" id="search" onkeypress="searchAction1(event)"><input type="button" value="검색하기" onclick="MsearchAction1(event)">
				<!-- Ajax 출력 구간 -->
				<div id="keywordResult" class="keywordResult none"></div>
				
			</div>
		</div>
	</div>
</body>

</html>