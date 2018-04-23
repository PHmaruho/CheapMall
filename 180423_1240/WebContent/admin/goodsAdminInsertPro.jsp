<%@page import="com.cheapmall.dto.GoodsDto"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>

<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>

</head>
<body>
	<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("등록 성공하셨습니다.");
			location.href = "GoodsAdminInsertForm.admin";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("등록 실패하셨습니다.");
			location.href = "GoodsAdminInsertForm.admin";
		</script>
	</c:if>
</body>
</html>