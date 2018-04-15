<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<h2>팝업</h2>
	<form action="" method="post">
		<input type="button" 
		onclick="javascript:window.open('adminPopupAddForm.jsp','팝업등록','scrollbars=yes width=500 height=600')" 
		value="추가">
		
		<table border="1">
				<tr>
					<th>분류</th>
					<th>ID</th>
					<th>이름</th>
					<th>시작일</th>
					<th>종료일</th>
					<th>게시상태</th>
				</tr>
				
					<c:if test="${count==0 }">
						<tr>
							<td colspan="6"> no data exists</td>
						</tr>					
					</c:if>
				
				
			 		<c:if test="${ count>0 }">
						<c:forEach var="popData" items="${listP }">
							<c:set var="sqContain" value="${popData.sq }"/>
								<c:set var="now" value="<%=new java.util.Date() %>"/>
								<tr>
									<c:if test="${!fn:contains(sqContain,'S') }">
										<td>Main</td>
									</c:if>
									
									<c:if test="${fn:contains(sqContain,'S') }">
										<td>Sub</td>
									</c:if>
									
										<td>
										<input type="hidden" name="sq" value="${popData.sq }"/>
										<a href="#" 
										onclick="javascript:window.open('adminPopupModifyForm.admin?sq=${popData.sq}','팝업 수정', 'scrollbars=yes width=500 height=600')">
										${popData.sq }</a></td>
										<td>${popData.nm }</td>
										<td>${popData.start_dt }</td>
										<td>${popData.end_dt }</td>
										
									<c:if test="${popData.end_dt>now }">
										<td>N</td>
									</c:if>
									
									<c:if test="${popData.end_dt<now }">
										<td>Y</td>
									</c:if>
								</tr>							
					</c:forEach>
			 	</c:if> 
			
		</table>
		
	</form>
</body>
</html>