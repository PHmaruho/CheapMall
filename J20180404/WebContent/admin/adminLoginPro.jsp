<%@page import="com.cheapmall.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css" type="text/css">
<style type="text/css">
table {
	width : 100%;
}
</style>

</head>
<body>

 <%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auth = (String)request.getAttribute("auth");
//	String result = request.getParameter("result");
	
	MemberDao md = MemberDao.getInstance();
//	int result = (int)request.getAttribute("result");
//	System.out.println(result);
	if(auth != "no") {
		session.setAttribute("id", id);
	//	session.setAttribute("pw", pw);
		session.setAttribute("auth",auth);
		response.sendRedirect("AdminMenuList.admin");
	} else 
	{ %> <!-- 1도 아니고 0도 아니고 아이디 자체가 맞지 않으면 -1로 보내줌 -->
	<script type="text/javascript">
		alert("ID나 PASSWORD가 불일치 합니다.확인 후 재시도 해주세요");
		history.back();
	</script>
<% } %>


</body>
</html>