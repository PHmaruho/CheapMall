<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	function updateOpener(cd) {
		window.opener.document.getElementById("suggestText").value = cd;
		window.close();
	}
	
	function check() {
		var nm = $('#txtInput').val();
		
		if(nm.length < 1){
			alert("검색어를 입력해주세요.");
			nm.focus();
			return false;
		} else {
			$.ajax({
				type:"POST",
				url: "boardWriteFormPopupAjax.mall",
				data:{nm : nm},
				success: function(data){
					$('#goods').html("");
					$('#goods').html(data);
				}
			});
		}
	}
</script>
</head>
<body>
	<h1>상품 선택</h1>
	<input type="text" id="txtInput" value="">
	<input type="button" onClick="check()" value="검색">
	<input type="button" onClick="window.close();" value="닫기">
	<div id="goods"></div>
</body>
</html>