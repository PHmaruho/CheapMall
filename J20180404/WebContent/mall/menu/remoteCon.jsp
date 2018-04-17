<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Cheap Mall</title>
<link rel="stylesheet" href="../../js/jquery-ui.css">
<style>
	#remoteCon {
		width: 150px;
		height: 150px;
		padding: 0.5em;
		background-color: red;
	}
</style>
<script src="../../js/jquery.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script>
	$( function() {
		$("#remoteCon").draggable();
	});
</script>
</head>
<body>
	<div id="remoteCon" class="ui-widget-content">
		<p>Drag me around</p>
	</div>


</body>
</html>