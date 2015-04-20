$(document).ready(function() {
	$('form.remote').submit(function(e) {
		console.log('submitted form');
		$.post(
			$(this).attr('action'),
			$(this).serialize(), 
			function(data) { 
				console.log(data); 
				$('#result').html(data.yolo);
			},
			"json"
		);
		return false;
	});
});