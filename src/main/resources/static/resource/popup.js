$(function() {
	$('.popup-startPoint > .head > .btn-close').click(function() {
		$('.popup-startPoint,.popup-bg').css('display', 'none');
	});

	$('.btn-start').click(function() {
		$('.popup-startPoint,.popup-bg').css('display', 'block');
	});

	$('.popup-endPoint > .head > .btn-close').click(function() {
		$('.popup-endPoint,.popup-bg').css('display', 'none');
	});

	$('.btn-end').click(function() {
		$('.popup-endPoint,.popup-bg').css('display', 'block');
	});
});

function selectStartPoint(el) {

	var $popup = $('.pointForm');

	$popup.find('input[name="startPoint"]').val($(el).val());

	$('.popup-startPoint,.popup-bg').css('display', 'none');

}

function selectEndPoint(el) {

	var $popup = $('.pointForm');

	$popup.find('input[name="endPoint"]').val($(el).val());

	$('.popup-endPoint,.popup-bg').css('display', 'none');

}