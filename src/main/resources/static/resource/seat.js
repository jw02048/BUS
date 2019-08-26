/*
$(function() {
	$('.btn-complete-select').click(function() {
		subSelectSeat();
	});
		
	var selectableSeatsCount = 5;
	
	alert(departureDate);
	if (isNaN(adultCharge)) {
		adultCharge = 0;
		
		alert(adultCharge);
	}
	
	function subSelectSeat() {

		
		var seatNums = [];
		var cnt = 0;

		var charges = [];
		var total = 0;

		$('input[name=seat]').each(function(index, el) {
			var $checkBox = $(el);

			if ($checkBox.is(":checked") == true) {

				seatNums[cnt] = $checkBox.val();

				if ($checkBox.attr('data-person-type') == 'adult') {
					charges[cnt] = adultCharge;
				}

				total += charges[cnt];
				cnt++;
			}
		});

		if (confirm(cnt + ' 좌석 총 요금은 ' + number_format(total) + '원입니다.')) {
			location.replace('./reservation?serviceId=' + serviceId
					+ '&departureDate=' + departureDate + '&charges=' + charges
					+ '&seatNums=' + seatNums);
			return;
		}

	}
	
	function number_format(num) {
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}

	function Seat__getTotalSelected(personType) {
		if (!personType) {
			personType = 'adult';
		}

		var selcted = $('.seat-box input[type="checkbox"][name="seat"][data-person-type="'
				+ personType + '"]:checked').length;
		return selcted;
	}

	function Seat__getTotalCharge() {
		return adultCharge * Seat__getTotalSelected('adult');
	}

	function Seat__updateUi() {
		var totalCharge = Seat__getTotalCharge();
		$('.right-box .total-charge').text(number_format(totalCharge));

		var totalSelected = Seat__getTotalSelected();
		$('.right-box .total-select').text(number_format(totalSelected));
	}

	$('.seat-box input[type="checkbox"][name="seat"]').click(function() {
		if (Seat__getTotalSelected() > selectableSeatsCount) {
			alert('좌석선택은 5석까지 가능합니다.');
			return false;
		}
	});

	$('.seat-box input[type="checkbox"][name="seat"]').change(function() {
		Seat__updateUi();
	});
	
	$('.left-box .adultCharge').text(number_format(adultCharge));
});

*/