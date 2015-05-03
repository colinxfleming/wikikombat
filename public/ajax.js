$(document).ready(function() {
	$('form.remote').submit(function(e) {
		console.log('submitted form');
		$.post(
			$(this).attr('action'),
			$(this).serialize(), 
			function(data) { 
				console.log(data); 
				$('#result').html(data.msg);
				$('#result_table').empty().append('<tr><th>Wikipedia Page</th><th>More Important Than Mortal Kombat?</th></tr>');


for (i = 0; i < data.roll.length; i++) { 
	if (data.roll[i].longer_than_mk === true) { 
		longer_than_mk = 'WAY more important!'
	} else {
		longer_than_mk = 'no :-('
	}
	$('#result_table').append('<tr class="result_row"><td>' + data.roll[i].name + '</td><td>' + longer_than_mk + '</td></tr>');
};
				// $.each(data.roll, function(d) { 
					// $('#result_table').append('<tr class="result_row"><td>' + d.name + '</td><td>' + d.longer_than_mk + '</td></tr>');
				// });
			},
			"json"
		);
		return false;
	});
});
