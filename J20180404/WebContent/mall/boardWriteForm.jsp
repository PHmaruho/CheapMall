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
<script type="text/javascript" src="../js/jquery.js"></script>
<script>
	window.onload = function(){
		if ('${board_cd}' == 'B3') {
			var report = document.getElementById(3);
			var board_cd = '${board_cd}';
			var report_id = '${report_id}';
			$("#select").val(board_cd);
			report.className += " show";
			$("#reportText").val(report_id);
		}
	}
	
	function list() {
		var index = document.getElementById("select").selectedIndex;
		var suggest = document.getElementById(1);
		var report = document.getElementById(3);
		
		if (index == 3) {
			document.getElementById("suggestDiv").value="";
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
		var suggestDiv = document.getElementById("suggestDiv");

		if (check == 1) {
			suggestDiv.className += " show";
		} else {
			suggestDiv.className = suggestDiv.className.replace(" show", "");
		}
	}
	
	function check() {
		var index = document.getElementById("select").selectedIndex;
		var suggestDiv = document.getElementById("suggestDiv");
		var reportText = document.getElementById("reportText");
		var hidden = document.getElementById("hidden");
		var object = document.getElementById("object");
		var board_cd = "B" + index;
		
		if (index == 1 || index == 2) {
			if (!suggestDiv.disabled) {
				if (suggestDiv.value == "") {
					alert("대상 상품을 입력해주세요.")
					return false;
				}
			}
			hidden.value = "B" + index;
			object.value = suggestDiv.value;
		} else if (index == 3) {
			if (reportText.value == "") {
				alert("대상자 ID를 입력해주세요.")
				return false;
			}
			if (reportText.value == ('${id}')) {
				alert("자기 자신을 신고할순 없습니다.")
				return false;
			}
			if ($('#checkId').val() != "1") {
				alert("대상자 ID가 확인되지 않았습니다.")
				return false;
			}
			hidden.value = "B" + index;
			object.value = reportText.value;
		} else {
			alert("분류를 선택하세요.")
			return false;
		}
	}
	
	function winop() { // 2018-04-16 userRegistForm.jsp 적용
		var v_id = document.getElementById("reportText")
		if (!v_id.value) {
			alert("ID를 입력 후 대상자 확인을 눌러주세요.");
			v_id.focus();
			return false;
		}
		if(v_id.value.length < 4 || !v_id.value.length > 16){
			alert("4자이상 16미만으로 작성해주세요.");
			v_id.focus();
			return false;
		}
		
		// ajax
		$.ajax({
			type:"POST",
			url: "UserIdCompareAjax.mall",
			data:{id:v_id.value},
			success: function(data){
				var json = JSON.parse(data);
				if(json.result == 'yes'){
					$('#idChk').html("");
					$('#idChk').html("확인되었습니다.");
					$('#checkId').val("1"); // 0은 중복체크 미완료, 아이디변경됨
				} else {
					$('#idChk').html("");
					$('#idChk').html("존재하지 않는 사용자입니다.");
					$('#checkId').val("0"); // 1은 중복체크 완료
				}
			}
		});
	}
	
	function popUp() {
		window.open('boardWriteFormPopup.mall', '상품찾기', 'width=500, height=500');
	}
</script>
</head>
<body>
	<label>구분</label>
	<select id="select" onchange="list()">
		<option selected disabled="disabled">분류를 선택하세요.</option>
		<option value="B1">문의</option>
		<option value="B2">건의</option>
		<option value="B3">신고</option>
	</select>
	
	<div id="1" class="none">
		<label>일반</label><input type="radio" name="radio" onclick="radio(0)" checked="checked">
		<label>상품</label><input type="radio" name="radio" onclick="radio(1)">
		<div id="suggestDiv" class="none">
			<input type="text" disabled="disabled" id="suggestText" name="suggestText">
			<input type="button" value="상품찾기" onclick="popUp()">
		</div>
	</div>
	<div id="3" class="none">
		<label>대상자 ID</label>
		<input type="text" id="reportText" oninput="javascript : $('#checkId').val('0');" placeholder="ID를 입력하세요" autofocus>
		<input type="button" onclick="winop()" style="background-color:#EDCE7A" value="아이디 확인" id="idBtn">
		<input type="hidden" value="0" id="checkId">
		<div id="idChk"></div>
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