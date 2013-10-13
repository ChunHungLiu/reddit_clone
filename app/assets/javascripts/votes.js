// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var upvote = function(postNumber) {
	var $el = $('#post-' + postNumber);
	var number = parseInt($el.text()) + 2;
	$el.text(number);
}

