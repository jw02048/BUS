$(function() {
	$('.popup-departure > .head > .btn-close').click(function() {
		$('.popup-departure,.popup-bg').css('display', 'none');
	});

	$('.btn-departure').click(function() {
		$('.popup-departure,.popup-bg').css('display', 'block');
	});

	$('.popup-destination > .head > .btn-close').click(function() {
		$('.popup-destination,.popup-bg').css('display', 'none');
	});

	$('.btn-destination').click(function() {
		$('.popup-destination,.popup-bg').css('display', 'block');
	});
});

function selectDeparture(el) {

	var $popup = $('.pointForm');

	$popup.find('input[name="departure"]').val($(el).val());

	$('.popup-departure,.popup-bg').css('display', 'none');

}

function selectDestination(el) {

	var $popup = $('.pointForm');

	$popup.find('input[name="destination"]').val($(el).val());

	$('.popup-destination,.popup-bg').css('display', 'none');

}