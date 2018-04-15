<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Cheap Mall</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script type="text/javascript">
	(function(){
		if('${result}' == '0'){
			alert("로그인 정보를 알 수 없습니다!");
			location.href="UserLoginForm.mall";
		} else if('${result}' == '1'){
			
			// list에서 왔으면 list페이지로 보여준다.
			if('${returnList}' == 'list'){
				location.href="goodsList.mall?gender='${gender}'&top_category='${top_category}'&middle_category=${middle_category}";
			} else if('${returnList}' == 'main'){
				location.href="Cheap.mall";
			}
		}
	})()
</script>
</body>
</html>