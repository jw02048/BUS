$(function() {
	$('.btn-complete-select').click(function() {
		if ( $('input[name=seat]:checked').length == 0 ) {
			alert('선택한 좌석이 없습니다.');
			return false;
		}
		
		subSelectSeat();
	});
	
	var selectableSeatsCount = 5;
	
	var remainSeat = totalSeat - seatNums.length;
	
	$('.left-box .adultCharge').text(number_format(adultCharge));
	
	$('.left-box .departureDate').text(departureDate);
	
	$('.left-box .departure').text(departure);
	
	$('.left-box .destination').text(destination);
	
	$('.middle-box .head .remain-seat').text(remainSeat);
	
	$('.middle-box .head .total-seat').text(totalSeat);
	
	for ( var i = 0; i < seatNums.length; i++ ) {
		$('input:checkbox[name="seat"]').each(function() {
			if ( this.value == seatNums[i] ) {
				$(this).attr("disabled", true);
			}
		});
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

		if (confirm('출발날짜 ' + departureDate + ', ' + cnt + ' 좌석 총 요금은 ' + number_format(total) + '원입니다.')) {
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
	
});