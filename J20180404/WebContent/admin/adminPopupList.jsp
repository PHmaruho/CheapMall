<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript">
	
</script>
</head>
<body>

	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div> 

	
	<div id="main" class="main">
	<h1>팝업</h1>
	<form action="" method="post">
	 		<div class="mainH" >
	
		<input type="button"  class="btn mini" 
		onclick="javascript:window.open('adminPopupAddForm.jsp','팝업등록','scrollbars=yes width=500 height=600')" 
		value="추가" >
		 </div>
		 <p>
		<h5>Main</h5>
		<table class="tableP" border="1">
				<tr>
					<th class="thG">분류</th>
					<th class="thG">ID</th>
					<th class="thG">이름</th>
					<th class="thG">시작일</th>
					<th class="thG">종료일</th>
					<th class="thG">게시상태</th>
				</tr>
				
					<c:if test="${mainCount==0}">
						<tr>
							<td colspan="6"> no data exists</td>
						</tr>					
					</c:if>
				
				
			 		<c:if test="${ mainCount>0 }">
						<c:forEach var="mainL" items="${mainList}">
							<c:set var="now" value="<%=new java.util.Date() %>"/>
								<tr>
									<td>Main</td>
									<td class="td">
										<input type="hidden" name="sq" value="${mainL.sq }"/>
										<a  class="td" href="#" 
										onclick="javascript:window.open('adminPopupModifyForm.admin?sq=${mainL.sq}','팝업 수정', 'scrollbars=yes width=500 height=600')">
										${mainL.sq }</a></td>
									<td>${mainL.nm }</td>
									<td>${mainL.start_dt }</td>
									<td>${mainL.end_dt }</td>
									
										<c:if test="${mainL.end_dt>now }">
											<td>Y</td>
										</c:if>
										
										<c:if test="${mainL.end_dt<now }">
											<td>N</td>
										</c:if>
								</tr>							
					</c:forEach>
			 	</c:if> 
			
			</table>
			
			<h5>Sub</h5>
		<table class="tableP" border="1">
				<tr>
					<th class="thG">분류</th>
					<th class="thG">ID</th>
					<th class="thG">이름</th>
					<th class="thG">시작일</th>
					<th class="thG">종료일</th>
					<th class="thG">게시상태</th>
				</tr>
				
					<c:if test="${mainCount==0 && subCount==0 }">
						<tr>
							<td colspan="6"> no data exists</td>
						</tr>					
					</c:if>
			 	<c:if test="${ subCount>0 }">
						<c:forEach var="subL" items="${subList}">
								<tr>
									<td>Sub</td>
									<td class="td">
										<input type="hidden" name="sq" value="${subL.sq }"/>
										<a  class="td" href="#" 
										onclick="javascript:window.open('adminPopupModifyForm.admin?sq=${subL.sq}','팝업 수정', 'scrollbars=yes width=500 height=600')">
										${subL.sq }</a></td>
									<td>${subL.nm }</td>
									<td>${subL.start_dt }</td>
									<td>${subL.end_dt }</td>
									
										<c:if test="${subL.end_dt>now }">
											<td>Y</td>
										</c:if>
										
										<c:if test="${subL.end_dt<now }">
											<td>N</td>
										</c:if>
								</tr>							
					</c:forEach>
			 	</c:if> 
			
			</table>
		</form>
	</div>
</body>
</html>