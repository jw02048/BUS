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
			maxDate : "+3D",

			onSelect: function() {
				
			}
		});
	});
});

function replaceUrlParam(url, paramName, paramValue)
{
    if (paramValue == null) {
        paramValue = '';
    }
    var pattern = new RegExp('\\b('+paramName+'=).*?(&|#|$)');
    if (url.search(pattern)>=0) {
        return url.replace(pattern,'$1' + paramValue + '$2');
    }
    url = url.replace(/[?#]$/,'');
    return url + (url.indexOf('?')>0 ? '&' : '?') + paramName + '=' + paramValue;
}

function getNoDomainUrl() {
    var url = window.location.href;
    var protocol = window.location.protocol;
    var hostname = window.location.hostname;
    var port = window.location.port;
    
    var prefix = protocol + "//" + hostname;
    url = url.replace(prefix, '');
    url = url.replace(':' + port, '');
    
    return url;
}

