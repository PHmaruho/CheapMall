<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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
</head>
<body>
<%-- <div class="topLayout">
	<jsp:include page="top.jsp" />
</div>

<div class="menuLayout">
	<jsp:include page="menu.jsp" />
</div>

<div class="mainLayout">
	<div class="contentLayout">
		<jsp:include page="content.jsp" />
	</div>
	<div class="footerLayout">
		<jsp:include page="footer.jsp" />
	</div>
</div> --%>
</body>
</html>