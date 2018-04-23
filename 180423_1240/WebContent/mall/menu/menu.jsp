<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.menuDiv {
	position : absolute;
	height: 100%;
	width: 100%;
	font-size: 20px;
	border-style: none;
}

.menuDiv ul li a {
	text-decoration: none;
	color: black;
}

.menuDiv ul {
	background-color: white;
	padding-left: 0px;
	padding-top: 50px;
}

.menuDiv ul li {
	text-align: center;
	padding-bottom: 10px;
}

.menuDiv li {
	background-color: white;
}

#MEN li, #WOMEN li, #EVENT li, #BOARD li {
	font-size: small;
}

#MEN ul, #WOMEN ul, #EVENT ul, #BOARD ul {
	padding: 0px;
}

#M_OUTTER li, #M_INNER li, #M_ETC li, #W_OUTTER li, #W_INNER li, #W_ETC li
	{
	font-size: 10px;
}

.none {
	display: none
}

.show {
	display: block !important
}

.menuDiv li {
	list-style: none
}

.menuDiv li ul {
	padding-left: 20px
}

.contents {
	height: 700px;
}
</style>
<script>
	// Accordion 
	function listFunc(id) {
		var x = document.getElementById(id);
		if (x.className.indexOf("show") == -1) {
			x.className += " show";
		} else {
			x.className = x.className.replace(" show", "");
		}
	}
</script>
</head>
<body>
	<div class="menuDiv">
		<ul>
			<li><a onclick="listFunc('MEN')" href="#">MEN</a>
				<div id="MEN" class="none">
					<ul>
						<li><a href="goodsList.mall?gender=M&top_category=ALL"
							id="btn1-1">ALL</a></li>
						<li><a onclick="listFunc('M_OUTTER')" href="#">OUTTER</a>
							<div id="M_OUTTER" class="none">
								<ul>
									<li><a
										href="goodsList.mall?gender=M&top_category=O&middle_category=ALL">ALL</a></li>
									<li><a
										href="goodsList.mall?gender=M&top_category=O&middle_category=JAC">재킷</a></li>
									<li><a
										href="goodsList.mall?gender=M&top_category=O&middle_category=CAR">가디건</a></li>
								</ul>
							</div></li>
						<li><a onclick="listFunc('M_INNER')" href="#">INNER</a>
							<div id="M_INNER" class="none">
								<ul>
									<li><a
										href="goodsList.mall?gender=M&top_category=I&middle_category=ALL">ALL</a></li>
									<li><a
										href="goodsList.mall?gender=M&top_category=I&middle_category=TSH">티셔츠</a></li>
									<li><a
										href="goodsList.mall?gender=M&top_category=I&middle_category=SHI">셔츠</a></li>
									<li><a
										href="goodsList.mall?gender=M&top_category=I&middle_category=PAN">바지</a></li>
								</ul>
							</div></li>
						<li><a onclick="listFunc('M_ETC')" href="#">ETC</a>
							<div id="M_ETC" class="none">
								<ul>
									<li><a
										href="goodsList.mall?gender=M&top_category=E&middle_category=ALL">ALL</a></li>
									<li><a
										href="goodsList.mall?gender=M&top_category=E&middle_category=WAT">시계</a></li>
									<li><a
										href="goodsList.mall?gender=M&top_category=E&middle_category=SHO">신발</a></li>
									<li><a
										href="goodsList.mall?gender=U&top_category=E&middle_category=BAG">가방</a></li>
								</ul>
							</div></li>
					</ul>
				</div></li>
			<li><a onclick="listFunc('WOMEN')" href="#">WOMEN</a>
				<div id="WOMEN" class="none">
					<ul>
						<li><a href="goodsList.mall?gender=F&top_category=ALL"
							id="btn1-1">ALL</a></li>
						<li><a onclick="listFunc('W_OUTTER')" href="#">OUTTER</a>
							<div id="W_OUTTER" class="none">
								<ul>
									<li><a
										href="goodsList.mall?gender=F&top_category=O&middle_category=ALL">ALL</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=O&middle_category=JAC">재킷</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=O&middle_category=CAR">가디건</a></li>
								</ul>
							</div></li>
						<li><a onclick="listFunc('W_INNER')" href="#">INNER</a>
							<div id="W_INNER" class="none">
								<ul>
									<li><a
										href="goodsList.mall?gender=F&top_category=I&middle_category=ALL">ALL</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=I&middle_category=TSH">티셔츠</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=I&middle_category=SHI">셔츠</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=I&middle_category=PAN">바지</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=I&middle_category=SKI">치마</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=I&middle_category=ONE">원피스</a></li>
								</ul>
							</div></li>
						<li><a onclick="listFunc('W_ETC')" href="#">ETC</a>
							<div id="W_ETC" class="none">
								<ul>
									<li><a
										href="goodsList.mall?gender=F&top_category=E&middle_category=ALL">ALL</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=E&middle_category=CLI">시계</a></li>
									<li><a
										href="goodsList.mall?gender=F&top_category=E&middle_category=SHO">신발</a></li>
									<li><a
										href="goodsList.mall?gender=U&top_category=E&middle_category=BAG">가방</a></li>
								</ul>
							</div></li>
					</ul>
				</div></li>
			<li><a onclick="listFunc('EVENT')" href="#">이벤트</a>
				<div id="EVENT" class="none">
					<ul>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
					</ul>
				</div></li>
			<li><a onclick="listFunc('BOARD')" href="#">게시판</a>
				<div id="BOARD" class="none">
					<ul>
						<li><a href="boardNoticeList.mall">공지사항</a></li>
						<li><a href="boardOtherList.mall">문의사항</a></li>
					</ul>
				</div></li>
		</ul>
	</div>
</body>
</html>