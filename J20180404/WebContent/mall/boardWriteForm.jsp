<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
	.none {
		display: none
	}
	.show {
		display: block
	}
</style>
<script>
	function list() {
		var index = document.getElementById("select").selectedIndex;
		var suggest = document.getElementById(1);
		var report = document.getElementById(3);
		
		if (index == 3) {
			document.getElementById("suggestText").value="";
			report.className = report.className.replace(" show", "");
			suggest.className = suggest.className.replace(" show", "");
			report.className += " show";
		} else {
			document.getElementById("reportText").value="";
			report.className = report.className.replace(" show", "");
			suggest.className = suggest.className.replace(" show", "");
			suggest.className += " show";
		}
	}
	
	function radio(check) {
		var suggestText = document.getElementById("suggestText");

		if (check == 1) {
			suggestText.disabled = false;
		} else {
			suggestText.disabled = true;
			suggestText.value="";
		}
	}
	
	function check() {
		var index = document.getElementById("select").selectedIndex;
		var suggestText = document.getElementById("suggestText");
		var reportText = document.getElementById("reportText");
		var hidden = document.getElementById("hidden");
		var object = document.getElementById("object");
		var board_cd = "B" + index;
		
		if (index == 1 || index == 2) {
			if (!suggestText.disabled) {
				if (suggestText.value == "") {
					alert("대상 상품을 입력해주세요.")
					return false;
				}
			}
			hidden.value = "B" + index;
			object.value = suggestText.value;
		} else if (index == 3) {
			if (reportText.value == "") {
				alert("대상자 ID를 입력해주세요.")
				return false;
			}
			hidden.value = "B" + index;
			object.value = reportText.value;
		} else {
			alert("분류를 선택하세요.")
			return false;
		}
	}
</script>
</head>
<body>
	<label>구분</label>
	<select id="select" onchange="list()">
		<option selected disabled="disabled">분류를 선택하세요.</option>
		<option>문의</option>
		<option>건의</option>
		<option>신고</option>
	</select>
	
	<div id="1" class="none">
		<label>일반</label><input type="radio" name="radio" onclick="radio(0)" checked="checked">
		<label>상품</label><input type="radio" name="radio" onclick="radio(1)">
		<input type="text" id="suggestText" disabled="disabled">
	</div>
	<div id="3" class="none">
		<label>대상자 ID</label>
		<input type="text" id="reportText">
	</div><br>
	<form action="boardWritePro.mall" method="post" onsubmit="return check()">
		<label>제목</label><input type="text" required="required" name="subject"><br>
		<textarea rows="20" cols="50" required="required" id="content" name="content"></textarea><br>
		<input type="hidden" id="hidden" name="board_cd">
		<input type="hidden" id="object" name="object">
		<input type="submit" value="확인">
	</form>
</body>
</html>