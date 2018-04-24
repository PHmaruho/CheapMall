<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<link rel="stylesheet" href="../js/jquery-ui.css">
<style>
.sortUl {
	list-style-type: none;
	margin: 0;
	padding: 0;
	margin-bottom: 10px;
}

.sortLi {
	margin: 5px;
	padding: 5px;
	width: 150px;
	float: left;
}

.x {
	float: right;
	background-color: white;
}

#cDiv {
	float: left;
	width: 40%;
}
	
#rDiv {
	float: left;
	width: 30%;
}

#bDiv {
	float: right;
	width: 30%;
}
</style>
<script type="text/javascript" src="../js/chart.min.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script type="text/javascript">
	var cTemp = [];
	var rTemp = [];
	var cSort = [];
	var rSort = [];
	
	$(function() {
		<c:forEach var="c" items="${columnType }">
			cTemp.push('${c}');
		</c:forEach>
		<c:forEach var="r" items="${resultType }">
			rTemp.push('${r}');
		</c:forEach>
		
		createSortable();
		showAjax();
	});
	
	function setArray(buttonName, array) {
		if (buttonName.value == 1) {
			if (array.length > 1) {
				var index = array.indexOf(buttonName.id);
				if (index !== -1) array.splice(index, 1);
				buttonName.value = 0;
				buttonName.style.backgroundColor = "black";
			} else {
				alert("최소 한개는 있어야해")
			}
		} else {
			array.push(buttonName.id);
			buttonName.value = 1;
			buttonName.style.backgroundColor = "white";
		}
	}
	
	function setSelect(buttonName) {
		if (buttonName.id.charAt(0) == "c") {
			setArray(buttonName, cTemp);
		} else {
			setArray(buttonName, rTemp);
		}
	}
	
	function showAjax() {
		var columnType = [];
		var resultType = [];
		getItems('#cDiv', '#rDiv');
		
		for (var i = 0; i < cSort.length; i++) {
			for (var j = 0; j < cTemp.length; j++) {
				if (cSort[i] == cTemp[j]) {
					columnType.push(cSort[i]);
				}
			}
		}
		
		for (var i = 0; i < rSort.length; i++) {
			for (var j = 0; j < rTemp.length; j++) {
				if (rSort[i] == rTemp[j]) {
					resultType.push(rSort[i]);
				}
			}
		}
		
		$.ajaxSettings.traditional = true;
		$.ajax({
			type:"POST",
			url: "statisticsAdminDetailAjaxOp3Dynamic.admin",
			data:{columnType : columnType,
				resultType : resultType},
			success: function(data){
				$('#test').html("");
				$('#test').html(data);
			}
		});
	}

	function getItems(c, r) {
		var cSortTemp = []; 
		var rSortTemp = []; 
		$(c + ' ul.sortUl').each(function() {
			cSortTemp.push($(this).sortable('toArray').join(','));
			cSort = cSortTemp.toString().split(",");
		});
		$(r + ' ul.sortUl').each(function() {
			rSortTemp.push($(this).sortable('toArray').join(','));
			rSort = rSortTemp.toString().split(",");
		});
	}
	
	function createSortable() {
		$("#cSortable").sortable({
			revert : true
		});

		$('#cDiv .sortUl').sortable({
			connectWith : '#cDiv .sortUl'
		});
		
		$("#rSortable").sortable({
			revert : true
		});

		$('#rDiv .sortUl').sortable({
			connectWith : '#cDiv .sortUl'
		});
		
		$("ul, li").disableSelection();
	}
</script>
</head>
<body>
	<nav>
		<div id="cDiv">
			<ul id="cSortable" class="sortUl">
				<li class="ui-state-default ui-sortable-handle sortLi" id="cAddr">
					주소<button class="x" onclick="setSelect(this)" value="1" id="cAddr">x</button></li>
				<li class="ui-state-default ui-sortable-handle sortLi" id="cGrade">
					등급<button class="x" onclick="setSelect(this)" value="1" id="cGrade">x</button></li>
				<li class="ui-state-default ui-sortable-handle sortLi" id="cGender">
					성별<button class="x" onclick="setSelect(this)" value="1" id="cGender">x</button></li>
				<li class="ui-state-default ui-sortable-handle sortLi" id="cYear">
					연령<button class="x" onclick="setSelect(this)" value="1" id="cYear">x</button></li>
			</ul>
		</div>
		<div id="rDiv">
			<ul id="rSortable" class="sortUl">
				<li class="ui-state-default ui-sortable-handle sortLi" id="rCnt">
					회원수<button class="x" onclick="setSelect(this)" value="1" id="rCnt">x</button></li>
				<li class="ui-state-default ui-sortable-handle sortLi" id="rSsum">
					매출액<button class="x" onclick="setSelect(this)" value="1" id="rSsum">x</button></li>
				<li class="ui-state-default ui-sortable-handle sortLi" id="rRsum">
					반품액<button class="btn mini x" onclick="setSelect(this)" value="1" id="rRsum">x</button></li>
			</ul>
		</div>
		<div id="">
			<button onclick="showAjax()" class="btn mini showBtn"><h3>적용</h3></button>
		</div>
		<div id="test"></div>
	</nav>
</body>
</html>