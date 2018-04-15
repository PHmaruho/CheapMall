<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Cheap Mall</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.topLayout{
		width: 100%;
		height: 100px;
		background-color: green;
	}
	.menuLayout{
		width: 10%;
		height: 1000px;
		float: left;
		background-color: pink;
	}
	.mainLayout{
		width: 85%;
		height: 1000px;
		float: left;
		background-color: yellow;
	}
	
	.contentLayout{
		width: 1000px;
		height: 1000px;
		float: left;
	}
	
	.footerLayout{
		width: 1000px;
		height: 50px;
	}
</style>
<script type="text/javascript">
	// 동일한 cheapmall.jsp를 쓰기위해서 Cheap.mall를 접속했는지 확인하기 위한 일종의 Checker
	(function(){
		if('${main}' != "yes"){
			// 이제 content 영역에 작업한 내용을 보여주기 위해서 이렇게 설정함
			if('${pageSet}' == null || '${pageSet}' == ''){
				location.href="Cheap.mall";
			}
		}
		if('${warning}' == "notLogin"){
			alert("Login이 필요한 곳 입니다.");
			location.href="UserLoginForm.mall";
		}
	})()
</script>
</head>
<body>
<div class="topLayout">
	<jsp:include page="top.jsp" />
</div>

<div class="menuLayout">
	<jsp:include page="menu.jsp" />
</div>

<div class="mainLayout">
	<div class="contentLayout">
		<c:if test="${pageSet != null }">
			<jsp:include page="${pageSet }" />
		</c:if>
		<c:if test="${pageSet == null }">
			<jsp:include page="content.jsp" />
		</c:if>
	</div>
	<div class="footerLayout">
		<jsp:include page="footer.jsp" />
	</div>
</div>
</body>
</html>