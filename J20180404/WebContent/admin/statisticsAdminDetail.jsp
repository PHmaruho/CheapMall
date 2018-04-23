<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	var showFlag = 1;
	
	$(function () {
		show();
	});
	
	function setFlag (flag) {
		showFlag = flag;
	}
	
	function show() {
		if (showFlag) {
			var type = $("#showSelect").val();
			$.ajax({
				type:"POST",
				url: "statisticsAdminDetailAjax.admin",
				data:{type : type},
				success: function(data){
					$('#graph').html("");
					$('#graph').html(data);
				}
			});
		}
		
		setFlag(0);
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	
	<div id="main">
		<select id="showSelect" onchange="setFlag(1)">
			<option value="op2">가격대별 판매액, 반품액, 구매자수</option>
			<option value="op3">주소별, 등급별, 성별, 언령별 회원수, 매출액, 반품액</option>
		</select>
		<button onclick="show()">조회</button>
		
		<div id="graph"></div>
	</div>
</body>
</html>