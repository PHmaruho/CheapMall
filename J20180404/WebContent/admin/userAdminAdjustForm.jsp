<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	width : 100%;}
td {text-align :  center;}
</style>
</head>
<body>

	<div id = "wrap">
	<%
              if(session.getAttribute("auth")!=null && session.getAttribute("auth").equals("A0")){
                %>
                 <jsp:include page="adminMenuList.jsp" />
      <% }
                else if(session.getAttribute("auth")!=null && session.getAttribute("auth").equals("A1")) {
        	 %>           
	<jsp:include page="adminMenuList.jsp" />
	<% } %>
	</div>
	
	<div id= "main" >
	<h2>Test Page~ </h2>
<p> test 입니다 ^^ </p> 
</div>


<div id="footer">
        <ul>
		<li><a class="a" href="#">test~!~! </a></li>
</ul>
         </div>
</body>
</html>