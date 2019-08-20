$(function() {
	$(function() {
		$("#testDatepicker").datepicker({});
	});

	$(function() {
		$("#testDatepicker").datepicker(
				{
					changeMonth : true,
					dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일',
							'일요일' ],
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
					monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
							'9', '10', '11', '12' ],
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ]
				});
	});

	$(function() {
		$("#testDatepicker").datepicker({
			showOn : "both",
			buttonImage : "button.png",
			buttonImageOnly : true
		});
	});

	$(function() {
		$("#testDatepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달'
		});
	});

	$(function() {
		$("#testDatepicker").datepicker({
			numberOfMonths : [ 2, 2 ]
		});
	});

	$(function() {
		$("#testDatepicker").datepicker({
			showButtonPanel : true,
			currentText : '오늘 날짜',
			closeText : '닫기',
			dateFormat : "yymmdd"
		});
	});

	$(function() {
		$("#testDatepicker").datepicker({
			minDate : -20,
			maxDate : "+3D"
		});
	});
});
$(function() {
	// 오늘 날짜를 출력
	$("#today").text(new Date().toLocaleDateString());

	// datepicker 한국어로 사용하기 위한 언어설정
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$('#time').datepicker({
		minDate : 0,
		maxDate : '+1m'
	});
});