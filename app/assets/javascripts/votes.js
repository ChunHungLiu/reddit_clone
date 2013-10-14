// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var change_vote = function(postNumber, action) {
	// The elements to update
	
	var postId = '#post-' + postNumber;
	var currentState = ($(postId + ' .selected').text().trim().toLowerCase());
	var $votesDiv = $(postId + ' .votes');
	$newState = $(postId + ' .'+ action);
	var voteChange = 0;	

	// Add one or two votes?
	switch (action) {
		case 'upvote':
			switch(currentState) {
				case 'sidevote':
					voteChange = 1;
					break;
				case 'downvote':
					voteChange = 2;
					break;
			}
		break;
		case 'sidevote':
			switch(currentState) {
				case 'upvote':
					voteChange = -1;
					break;
				case 'downvote':
					voteChange = 1;
					break;
			}
		break;
		case 'downvote':
			switch(currentState) {
				case 'upvote':
					voteChange = -2;
					break;
				case 'sidevote':
					voteChange = -1;
					break;
			}
		break;
	}

	// Update the votes.
	var number = parseInt($votesDiv.text()) + voteChange;
	$votesDiv.text(number);	
	var voteChange = 0;

	// Update the selected state.
	$(postId + ' .selected').removeClass('selected');
	$(postId + ' .' + action).addClass('selected');

}

