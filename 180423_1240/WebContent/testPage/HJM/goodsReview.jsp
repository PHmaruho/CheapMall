<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

		<!-- if photoReview / SimpleReview -->
		<c:choose>
			<c:when test="${reviewType == 'photoReview' }">
				<h2>포토 리뷰</h2>
					<table border="1">
						<c:forEach var="reviews" items="${list }">
							<tr>
								<td>
									<!-- 추천도 star에 따라서 이미지가 다른 것을 보여주게 한다. -->
									<c:choose>
										<c:when test="${reviews.star >= 5 }">
											<img src="images/review/star/5.jpg">
										</c:when>
										<c:when test="${reviews.star >= 4 }">
											<img src="images/review/star/4.jpg">
										</c:when>
										<c:when test="${reviews.star >= 3 }">
											<img src="images/review/star/3.jpg">
										</c:when>
										<c:when test="${reviews.star >= 2 }">
											<img src="images/review/star/2.jpg">
										</c:when>
										<c:when test="${reviews.star >= 1 }">
											<img src="images/review/star/1.jpg">
										</c:when>
									</c:choose>
								</td>
								<td>
									<!-- img -->
									<img alt="pic" src="/images/review/thumb/${reviews.path }.jpg">
								</td>
								<td>
									<!-- 글 내용/ 20자 미만만 보여지고 나머지는 ...으로 표기한다. -->
									<c:choose>
										<c:when test="${fn:length(reviews.content) >= 20 }">
											<c:out value="${fn:substring(reviews.content,0, 20) }" /> ...
										</c:when>
										<c:when test="${fn:length(reviews.content) < 20 }">
											<c:out value="${review.content }"></c:out>
										</c:when>
									</c:choose>
								</td>
								<td>
									<!-- 신고기능 추가할 것 -->
									${reviews.user_id }
								</td>
								<td>
									<!-- up/down 버튼 A href -->
									<p>
										<img src="/images/review/icon/up.jpg">UP
										(${reviews.up })
									</p>
									<p>
										<img src="/images/review/icon/down.jpg">DOWN
										(${reviews.down })
									</p>
								</td>
								<td>
									${reviews.write_dt }
								</td>
								<td>
									${reviews.cnt}
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:when>
				<c:when test="${reviewType == 'simpleReview' }">
					<h2>한줄 리뷰</h2>
					<table border="1">
						<c:forEach var="reviews" items="${list }">
							<tr>
								<td>
									<!-- 추천도 star에 따라서 이미지가 다른 것을 보여주게 한다. -->
									<c:choose>
										<c:when test="${reviews.star >= 5 }">
											<img src="images/review/star/5.jpg">
										</c:when>
										<c:when test="${reviews.star >= 4 }">
											<img src="images/review/star/4.jpg">
										</c:when>
										<c:when test="${reviews.star >= 3 }">
											<img src="images/review/star/3.jpg">
										</c:when>
										<c:when test="${reviews.star >= 2 }">
											<img src="images/review/star/2.jpg">
										</c:when>
										<c:when test="${reviews.star >= 1 }">
											<img src="images/review/star/1.jpg">
										</c:when>
									</c:choose>
								</td>
								<td>
									<!-- 글 내용/ 20자 미만만 보여지고 나머지는 ...으로 표기한다. -->
									<c:choose>
										<c:when test="${fn:length(reviews.content) >= 20 }">
											<c:out value="${fn:substring(reviews.content,0, 20) }" /> ...
										</c:when>
										<c:when test="${fn:length(reviews.content) < 20 }">
											<c:out value="${review.content }"></c:out>
										</c:when>
									</c:choose>
								</td>
								<td>
									<!-- 신고기능 추가할 것 -->
									${reviews.user_id }
								</td>
								<td>
									<!-- up/down 버튼 A href -->
									<p>
										<img src="/images/review/icon/up.jpg">UP
										(${reviews.up })
									</p>
									<p>
										<img src="/images/review/icon/down.jpg">DOWN
										(${reviews.down })
									</p>
								</td>
								<td>
									${reviews.write_dt }
								</td>
								<td>
									${reviews.cnt}
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:when>
		</c:choose>
</body>
</html>