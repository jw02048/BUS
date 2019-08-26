<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="좌석선택" />
<!-- 
<c:set var="serviceId" value="${param.serviceId}"/>
<c:set var="departureDate" value="${param.departureDate}"/>
<c:set var="departure" value="${line.departure}"/>
<c:set var="destination" value="${line.destination}"/>
<c:set var="adultCharge" value="${line.charge}"/>
 -->
<%@ include file="../part/head.jspf"%>
<link rel="stylesheet" href="/resource/seat.css">
<script src="/resource/seat.js"></script>
<script>
$('.btn-complete-select').click(function() {
	subSelectSeat();
});

function subSelectSeat() {
	var cnt = $("input:checkbox[name=seat]:checked").length;
	var serviceId = ${param.serviceId};
	var departureDate = ${param.departureDate};
	var seatNums = [];
	var cnt = 0;
	var charges = [];
	var total = 0;
	$('input[name=seat]').each(function(index, el) {
	    var $checkBox = $(el);
	    if ( $checkBox.is(":checked") == true ) {
		    
	    	seatNums[cnt] = $checkBox.val();
	    	if ($checkBox.attr('data-person-type') == 'adult') {
	    		charges[cnt] = 10000;
		    }
		    total += charges[cnt];
		    cnt++;
	    }
	});
	
	if ( confirm('출발날짜는 ' + departureDate + ', ' + cnt + ' 좌석 총 요금은 ' + number_format(total) + '원입니다.') ) {
		location.replace('./reservation?serviceId=' + serviceId + '&departureDate=' + departureDate + '&charges=' + charges + '&seatNums=' + seatNums);
		return ;
	}
}
var adultPrice = 10000;
var selectableSeatsCount = 5;

function number_format(num) {
    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    return num.toString().replace(regexp, ',');
}
function Seat__getTotalSelected(personType) {
    if ( !personType ) {
        personType = 'adult';
    }
    
    var selcted = $('.seat-box input[type="checkbox"][name="seat"][data-person-type="' + personType + '"]:checked').length;
    return selcted;
}
function Seat__getTotalPrice() {
    return adultPrice * Seat__getTotalSelected('adult');
}
function Seat__updateUi() {
    var totalPrice = Seat__getTotalPrice();
    $('.right-box .total-charge').text(number_format(totalPrice));
    
    var totalSelected = Seat__getTotalSelected();
    $('.right-box .total-select').text(number_format(totalSelected));
}

$(function() {
	$('.seat-box input[type="checkbox"][name="seat"]').click(function() {
		if (Seat__getTotalSelected() > selectableSeatsCount) {
			alert('좌석선택은 5석까지 가능합니다.');
			return false;
		}
	});
	
	$('.seat-box input[type="checkbox"][name="seat"]').change(function() {
		Seat__updateUi();
	});
	
	$('.left-box > div > .adultCharge').text(number_format(adultPrice));
});
</script>

<h3 class="con main-text">즐거운 여행의 시작과 끝, SBS 버스와 함께!</h3>

<div class="con table-common seat-page">
	<div class="left-box table-common con">

		<div class="con">출발날짜 : ${departureDate}</div>

		<div class="con">출발지 : ${departure}</div>

		<div class="con">출발지 : ${destination}</div>
		
		<div class="con">성인요금 : <span class="adultCharge"></span>원</div>

	</div>

	<div class="middle-box con">
		<div class="selectSeat_box">
			<div class="bg_seatBox seat28">
				<div class="seatList">
					<div class="seat-box">
						<ul>
						<c:forEach var="num" begin="1" end="28" step="1" >
							<li>
								<div>
									<span>${num}</span>
									<input type="checkbox" name="seat" data-person-type="adult" value="${num}" />
									<div></div>
								</div>
							</li>
						</c:forEach>	
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="right-box con">
		<div>선택좌석 수 : <span class="total-select">0</span>좌석</div> 
		<div>총 금액 : <span class="total-charge">0</span>원</div>
	</div>
	<div>
		<button class="btn-complete-select btn-a" onclick="subSelectSeat(); return false;">선택완료</button>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>