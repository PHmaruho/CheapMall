<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
#ssumChart {
	float: left;
}

#rsum-chart {
	display: inline-block;
	margin-left: 10px;
}

#op2Table {
	display: inline-block;
	margin-left: 10px;
}

#op2Table th {
	border: solid 1px black;
	background: black;
	color: white;
}

#op2Table td {
	border: solid 1px black;
}
</style>
<script type="text/javascript" src="../js/chart.min.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	var g = [];
	var ssum = [];
	var rsum = [];

	$(function() {
		<c:forEach var="list" items="${list }" varStatus="i">
		if (!${i.first}) {
			g.push('${list.g}')
			ssum.push('${list.ssum}')
			rsum.push('${list.rsum}')
		}
		</c:forEach>
			
		createChart();
	});

	
	function createChart() {
		var sChart = new Chart($('#ssumChart'), {
			type : 'pie',
			data : {
				labels : g,
				datasets : [ {
					label : "Population (millions)",
					backgroundColor : [ "yellow", "#8e5ea2", "#3cba9f", "#e8c3b9",
							"#c45850", "black" ],
					data : ssum
				} ]
			},
			options : {
				responsive : false,
				title : {
					display : true,
					text : '구매비율'
				}
			}
		});
	
		var rChart = new Chart($('#rsumChart'), {
			type : 'pie',
			data : {
				labels : g,
				datasets : [ {
					label : "Population (millions)",
					backgroundColor : [ "yellow", "#8e5ea2", "#3cba9f", "#e8c3b9",
							"#c45850", "black" ],
					data : rsum
				} ]
			},
			options : {
				responsive : false,
				title : {
					display : true,
					text : '반품비율'
				}
			}
		});
	}
</script>
</head>
<body>
	<br>
	<canvas id="ssumChart" width="400" height="400"></canvas>
	<canvas id="rsumChart" width="400" height="400"></canvas>
	<br><br>
	<table id="op2Table">
		<tr>
			<th class="th">구분</th><th class="th">회원수</th><th class="th">구매</th><th class="th">반품</th><th class="th">반품률</th>
			<c:forEach var="list" items="${list }">
				<tr>
					<td>${list.g }</td>
					<td><fmt:formatNumber value="${list.cnt }" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${list.ssum }" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${list.rsum }" pattern="#,###" /></td>
					<td>
						<c:if test="${list.rsum == 0}">
							0.00%
						</c:if>
						<c:if test="${list.rsum != 0}">
							<fmt:formatNumber value="${list.rsum / (list.ssum + list.rsum) }"
								 type="percent" pattern="0.00%"/>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tr>
	</table>
</body>
</html>