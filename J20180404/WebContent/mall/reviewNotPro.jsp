<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
</head>
<body>
<script type="text/javascript">
	if(${result} == '2'){
		alert("등록되었습니다.");
		window.close();
		location.href = "OrderListSimpleForm.mall";
	}
	if(${result} == '1'){
		alert("이미 리뷰가 작성된 구매완료상품입니다.");
		window.close();
	} else if(${result} == '-1'){
		alert("로그인이 필요한 부분입니다.");
		window.close();
		location.href = "cheapmal.jsp";
	}
</script>
</body>
</html>