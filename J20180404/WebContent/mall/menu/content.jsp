<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Cheap Mall</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.a {
	position: absolute;
	width: 100%;
	height: 100%;
	border-style: none;
}

.sec2 {
	margin-top: 30px;
	width: 100%;
	height: 450px;
}

.sec3 {
	margin-top: 30px;
	width: 100%;
	height: 450px;
}

.sec2 img {
	width: 30%;
	height: 100%;
	margin-left: 19px;
}

.sec3 img {
	width: 30%;
	height: 100%;
	margin-left: 19px;
}
</style>
<script type="text/javascript">
	function subP(){
		var v="sub";
		window.open('../admin/popupOpen.admin?sub='+v, 'Cheap Mall',
				'width=400px, height=500px,left=' + (screen.availWidth - 660)
						/ 2 + ',top=' + (screen.availHeight - 430) / 2);
	}
</script>
</head>
<body>
	<div class="a">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner">
				<div class="item active">
					<a href="#" onclick="subP()">
					<img src="../images/main1.jpg" alt="Los Angeles"></a>
				</div>

				<div class="item">
					<a href="#" onclick="subP()">
					<img src="../images/main2.jpg" alt="Chicago"></a>
				</div>

				<div class="item">
					<a href="#" onclick="subP()">
					<img src="../images/main3.jpg" alt="New York"></a>
				</div>
			</div>

			<!-- Left and right controls -->
			<!-- <a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span> <span
				class="sr-only">Next</span>
			</a> -->
		</div>
		<div class="sec2">
			<img alt="" src="../images/1.png"> <img alt=""
				src="../images/1.png"> <img alt="" src="../images/1.png">
		</div>
		<div class="sec3">
			<img alt="" src="../images/2.png"> <img alt=""
				src="../images/2.png"> <img alt="" src="../images/2.png">
		</div>
	</div>
</body>
</html>