<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	function show() {
		var type = $("#showSelect").val();
		
		$.ajax({
			type:"POST",
			url: "UserIdCompareAjax.mall",
			data:{type : type},
			success: function(data){
				$('#graph').html("");
			}
		});
	}
</script>
</head>
<body>
	<select id="showSelect">
		<option value="op1">종합</option>
		<option value="op2">가격대별 판매액, 반품액, 구매자수</option>
		<option value="op3">상품별 달린 리뷰 수</option>
		<option value="op4">등급별 사용자 수</option>
	</select>
	<button onclick="show()">조회</button>
	
	<div id="graph"></div>
</body>
</html>