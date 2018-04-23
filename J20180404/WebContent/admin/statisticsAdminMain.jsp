<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/Chart.bundle.js"></script>
<style type="text/css">
	.mainDiv{
		width: 1600px;
		height: 1000px;
		margin: 20 auto 0 auto;
		padding-left: 10%;
		padding-right: 10px;
		border: solid black 0px;
	}
	
	.statisDiv{
		border: solid black 1px;
	}
	.statistics1{
		width: 100%;
		height: 40%;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	.subStatisDiv{
		width: 31%;
		height: 50%;
		float: left;
		margin-right:18px;
	}
</style>
<script type="text/javascript">
	window.onload = function(){
		statistics1();
		statistics2();
		statistics3();
		statistics4();
	}
	
	function statistics1(){
		var labels = [];
		var data = [];
		var canvas = document.getElementById("statistics1");
		var ctx = canvas.getContext("2d");
		$.ajax({
			type:"POST",
			url: "StatisticsAdminMain.admin",
			data: {type:"statis1"},
			success: function(data){
				var str = JSON.parse(data);
				if(str.result == 'yes'){
					labels = Object.keys(str.data);
					data = Object.values(str.data);
					var charts = new Chart(ctx, {
						type: 'line',
						data: {
							labels: labels,
							datasets: [{
						         label: 'My first dataset',
						         lineTension: 0,
						         backgroundColor: "rgba(75,192,192,0.4)",
						         borderColor: "rgba(75,192,192,1)",
						         data: data
						    }]
						},
						option:{
							maintainAspectRatio: false,
							responsive: false
						}
					});
				}
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
	
	function statistics2(){
		var labels = [];
		var data = [];
		var canvas = document.getElementById("statistics2");
		var ctx = canvas.getContext("2d");
		$.ajax({
			type:"POST",
			url: "StatisticsAdminMain.admin",
			data: {type:"statis2"},
			success: function(data){
				var str = JSON.parse(data);
				if(str.result == 'yes'){
					labels = Object.keys(str.data);
					data = Object.values(str.data);
					var charts = new Chart(ctx, {
						type: 'doughnut',
						data: {
							labels: labels,
							datasets: [{
						         label: 'My first dataset',
						         lineTension: 0,
						         backgroundColor: [
						        	 'rgba(75,192,192,0.4)',
						        	 'rgba(255,0,0,0.4)'
						         ],
						         data: data
						    }]
						},
						option:{
							maintainAspectRatio: false,
							responsive: false
						}
					});
					
				}
			}
		});
		  var cx = canvas.width / 2;
		  var cy = canvas.height / 2;
		  ctx.textAlign = 'center';
		  ctx.textBaseline = 'middle';
		  ctx.fillStyle = 'black';
		  ctx.fillText("Text Here", cx, cy);
	}
	function statistics3(){
		var labels = [];
		var data = [];
		var canvas = document.getElementById("statistics3");
		var ctx = canvas.getContext("2d");
		$.ajax({
			type:"POST",
			url: "StatisticsAdminMain.admin",
			data: {type:"statis3"},
			success: function(data){
				var str = JSON.parse(data);
				if(str.result == 'yes'){
					labels = Object.keys(str.data);
					data = Object.values(str.data);
					var charts = new Chart(ctx, {
						type: 'doughnut',
						data: {
							labels: labels,
							datasets: [{
						         label: 'My first dataset',
						         lineTension: 0,
						         backgroundColor: [
						        	 'rgba(75,192,192,0.4)',
						        	 'rgba(255,0,0,0.4)'
						         ],
						         data: data
						    }]
						},
						option:{
							cutoutPercentage: 30,
							maintainAspectRatio: false,
							responsive: false
						}
					});
					
				}
			}
		});
	}
	function statistics4(){
		var labels = [];
		var data = [];
		/* var color = {
				red: 'rgb(255, 99, 132)',
				orange: 'rgb(255, 159, 64)',
				yellow: 'rgb(255, 205, 86)',
				green: 'rgb(75, 192, 192)',
				blue: 'rgb(54, 162, 235)',
				purple: 'rgb(153, 102, 255)',
				grey: 'rgb(201, 203, 207)'
		};
		var getColor = Object.keys(color);
		var colorList = []; */
		var canvas = document.getElementById("statistics4");
		var ctx = canvas.getContext("2d");
		$.ajax({
			type:"POST",
			url: "StatisticsAdminMain.admin",
			data: {type:"statis4"},
			success: function(data){
				var str = JSON.parse(data);
				if(str.result == 'yes'){
					labels = Object.keys(str.data);
					data = Object.values(str.data);
					var charts = new Chart(ctx, {
						type: 'horizontalBar',
						data: {
							labels: labels,
							datasets: [{
								 label: '가입자',
						         lineTension: 0,
						         backgroundColor: "rgb(54, 162, 235)",
						         borderColor: "rgba(75,192,192,1)",
						         data: data
						    }]
						},
						option:{
							maintainAspectRatio: false,
							responsive: false
						}
					});
				}
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
</script>
</head>
<body>
<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
</div>
<br>
<div class="mainDiv">
	<div class="statisDiv statistics1">
		<canvas id="statistics1" style="float:left; height:0px; width:1px;"></canvas>
		<div style="float:right;">
			<input type="button" class="btn mini" onclick="" value="Excel 추출">
		</div>
	</div>
	<br><br>
	<div class="statisDiv subStatisDiv statistics2">
		<canvas id="statistics2" width="500" height="500" margin-left="10%"></canvas>
		<div>
			<input type="button" class="btn mini"  onclick="" value="상세보기">
		</div>
	</div>
	<div class="statisDiv subStatisDiv statistics3">
		<canvas id="statistics3" width="500" height="500"></canvas>
		<div>
			<input type="button"  class="btn mini" onclick="" value="상세보기">
		</div>
	</div>
	<div class="statisDiv subStatisDiv statistics4">
		<canvas id="statistics4" width="0px" height="0px"></canvas>
		<div>
			<input type="button" class="btn mini"  onclick="" value="상세보기">
		</div>
	</div>
</div>
</body>
</html>