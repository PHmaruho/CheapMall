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
		if('${type}' == 'delete'){
			if(${result} == 1){
				alert("삭제가 완료되었습니다.");
				opener.parent.location.reload();
				window.close();
			} else {
				alert("오류가 발생하였습니다.");
				history.go(-2);
			}
		} else if('${type}' == 'warning'){
			alert("잘못된 접근입니다.");
			window.close();
		}
	</script>
</body>
</html>