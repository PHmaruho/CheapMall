<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	width : 100%;}
td {text-align :  center;}
</style>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js">

	window.onload = function(){
			var input = document.getElementsByClassName("inputText");
			for (var items = 0; items < input.length; items++){
		       input[items].disabled=true;
		    }
			document.getElementByClassName("submit").disable=true;
		}
	
	$("#checkRow").click(function() {
		var rowData = new Array();
		var tdArr = new Array();
		var checkbox = $("input[name=checkRow]:checked");
	});

</script>
</head>
<body>


<h3>삭제하려면 암호를 입력하세요</h3>
<form action="AdminDeletePro.admin">
	<input type="hidden" name="pageNum" value="${pageNum }">
	PASSWORD : <input type="text" name="pw"><p>
	<input type="submit" value="delete">

</form>

</body>
</html>