<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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

.keywordResult{
	position: absolute;
	z-index: 100;
	top: 50px;
	left: 0px;
	width: 200px;
}
</style>
<script type="text/javascript" src="./js/jquery.js"></script>
<script type="text/javascript">
	function searchFunc(){
		var icon = document.getElementById("searchIcon");
		var search = document.getElementById("searchInput");
		var searchDiv = document.getElementById("searchDiv");
		
		//searchDiv.style.width = "200px";
		icon.className = icon.className.replace("show", "none");
		search.className = search.className.replace("none", "show");
	}
	
</script>
</head>
<body>
	<div class="topDiv">
		<div class="logoDiv">logo</div>
		<div class="cartDiv">cart</div>
		<div class="loginDiv">login</div>
		<div class="searchDiv">
			<div class="show" id="searchIcon">
				<a onclick="searchFunc()" href="#">search</a>
			</div>
			<div class="none" id="searchInput">
				<input type="text" width="15" id="search" onkeyup="key()">
				<div id="keywordResult" class="keywordResult none">
					
				</div>
				<input type="button" value="검색하기" onclick="">
			</div>
		</div>
	</div>
	
	<div id="div">
	
	</div>
</body>
<script>
	function key(){
		var keyword = $("#search").val();
		$("#keywordResult").addClass(" show");
		
		//alert("keyword.length = " + keyword.length);
		if(keyword.length != 0){
			$.ajax({
				type:"POST",
				url: "SearchPro.mall",
				data:{keyword:keyword},
				dataType: "JSON",
				success:function(data){
					//var list = $.parseJSON(data);
					$("#div").html(data);
				}
			});
		}
		//$("#div").html("");
		//$("#div").html($("#search").val());
	}
</script>
</html>