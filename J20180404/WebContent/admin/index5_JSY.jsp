<html lang="en"><head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>jQuery UI Draggable + Sortable</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<style>
	ul { list-style-type: none; margin: 0; padding: 0; margin-bottom: 10px; }
	li { margin: 5px; padding: 5px; width: 150px; }
	</style>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
	$( function() {
		$( "#sortable" ).sortable({
			revert: true
		});
		$( "#draggable" ).draggable({
			connectToSortable: "#sortable",
			helper: "clone",
			revert: "invalid"
		});
		$( "ul, li" ).disableSelection();
		
	
		
		// Example 2.1: Get items
		$('#example-2-1 .ui-sortable').sortable({
			connectWith: '#example-2-1 .ui-sortable'
		});

		$('#btn-get').click(function(){
			alert(getItems('#example-2-1'));
		});
	} );
	
	function getItems(exampleNr)
	{
		var columns = [];

		$(exampleNr + ' ul.ui-sortable').each(function(){
			columns.push($(this).sortable('toArray').join(','));
		});

		return columns;
	}
	</script>
</head>
<body>
<div id="example-2-1">
<ul>
		<li id="draggable" class="ui-state-highlight ui-draggable ui-draggable-handle">Drag me down</li>
	</ul>
	
	<ul id="sortable" class="ui-sortable">
		<li class="ui-state-default ui-sortable-handle" id="1">Item 1</li>
		<li class="ui-state-default ui-sortable-handle" id="2">Item 2</li>
		<li class="ui-state-default ui-sortable-handle" id="3">Item 3</li>
		<li class="ui-state-default ui-sortable-handle" id="4">Item 4</li>
		<li class="ui-state-default ui-sortable-handle" id="5">Item 5</li>
	</ul>
<button id="btn-get">adsfadsf</button>
</div>

</body></html>


