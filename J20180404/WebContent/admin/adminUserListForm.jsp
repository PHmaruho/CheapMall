<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	width: 100%;
}
td{
	text-align: center;
}
#id{
	display: none;
}
</style>
<script type="text/javascript">
	function detail(ids, pageNum){
		var popup = window.open('AdminUserModifyPopUp.admin?id='+ids+'&pageNum='+pageNum,'popup', "width=500, height=500");
		/* var id = ids;
		alert(id); */
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<h2> 회원 리스트 </h2>
		<table>
			<tr>
				<th>회원ID</th>
				<th>회원이름</th>
				<th>생년월일</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>성별</th>
				<th>등급</th>
				<th>가입일</th>
				<th>비밀번호변경일</th>
			</tr>
			<c:if test="${totCnt > 0 }">
				<c:forEach var="usersDto" items="${list }">
					<tr>
						<td>
							<a href="#" onclick="detail('${usersDto.id}', '${pageNum }')"> ${usersDto.id } </a>
						</td>
						<td> ${usersDto.nm } </td>
						<td> ${usersDto.birth } </td>
						<td> ${usersDto.tel } </td>
						<td> ${usersDto.email } </td>
						<td> ${usersDto.gender } </td>
						<td> ${usersDto.grade } </td>
						<td> ${usersDto.reg_dt } </td>
						<td> ${usersDto.pw_dt } </td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${totCnt == 0 }">
				<tr>
					<td colspan="9">데이터가 없습니다.</td>
				</tr>
			</c:if>
		</table>
	
		<div style="text-align: center;">
			<c:if test="${startPage > blockSize }">
				<a href='AdminUserListForm.admin?pageNum=${startPage-blockSize}'>[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a href='AdminUserListForm.admin?pageNum=${i}'>[${i}]</a>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				<a href='AdminUserListForm.admin?pageNum=${startPage+blockSize}'>[다음]</a>
			</c:if>
		</div>
	</div>
</body>

</html>