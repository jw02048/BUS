<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="좌석선택" />
<%@ include file="../part/head.jspf"%>
<style>
/* 폰트 */
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

/* 노말라이즈 */
html {
    font-family: "Noto Sans KR", sans-serif;
}

body, ul, li {
    margin:0;
    padding:0;
    list-style:none;
}
/* 커스텀 */
.left-box {
	width: 25%;
	height: 520px;
	border: 1px solid;
	float: left;
	font-size: 1.5rem;
}
.left-box > *, .right-box > * {
	margin-left: 10px;
}
.middle-box {
	width: 269px;
	height: 520px;
	border: 1px solid;
	float: left;
	
}
.right-box {
	float:left;
	width: 25%;
	height: 520px;
	border: 1px solid;
	font-size: 1.5rem;
}
/* 백그라운드 이미지 적용중 생각대로 안되서 뺌
.bg_seatBox {
	background-image:url(https://www.kobus.co.kr/images/common/bg_bus28.png);
	z-index: -2;
	position: relative;
	background-position: 5px -30px;
}
*/
.seat-box {
    width:200px;
    margin:0 auto;
}

.seat-box > ul::after {
    content:"";
    display:block;
    clear:both;
}
.seat-box > ul {
	margin-top: 50px;
}
.seat-box > ul > li {
    float:left;
    width:25%;
    text-align:center;
}

.seat-box > ul > li:nth-child(3n) {
    margin-left:25%;
}

.seat-box > ul > li:nth-last-child(2) {
    margin-left:0;
}

.seat-box > ul > li > div {
    position:relative;
    display:inline-block;
}

.seat-box > ul > li > div > div {
    width:40px;
    height:45px;
    background-image:url(https://www.kobus.co.kr/images/common/bg_busSeat_s.png);
    background-position:0 0;
    position:relative;
    z-index:-1;
}

.seat-box > ul > li > div > input {
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:100%;
    border:0;
    outline:0;
    opacity:0;
    cursor:pointer;
}

.seat-box > ul > li > div > input:checked + div {
    background-position:0 -48.4px;
}

.seat-box > ul > li > div > input:checked + div::after {
    content:"";
    display:block;
    width:20px;
    height:21px;
    background-image:url(https://www.kobus.co.kr/images/common/ico_busChecked.png);
    position:absolute;
    top:0;
    right:0;
}

.seat-box > ul > li > div > input:disabled + div {
    background-position:0 -144px;
}

.seat-box > ul > li > div > span {
    position:absolute;
    top:50%;
    left:50%;
    transform:translate(-50%, -70%);
    font-size:0.8rem;
}
</style>
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
		
		if ( confirm(cnt + ' 좌석 총 요금은 ' + number_format(total) + '원입니다.') ) {
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
	    if ( Seat__getTotalSelected() > selectableSeatsCount ) {
		    alert('좌석선택은 5석까지 가능합니다.');
	        return false;
	    }
	});

	$('.seat-box input[type="checkbox"][name="seat"]').change(function() {
	    Seat__updateUi();
	});

	$('.left-box > div > .charge').text(number_format(adultPrice));
});
	

</script>

<h3 class="con main-text">즐거운 여행의 시작과 끝, SBS 버스와 함께!</h3>

<div class="con table-common seat-page">
	<div class="left-box table-common con">

		<div class="con">출발날짜 : ${param.departureDate}</div>

		<div class="con">출발지 : ${line.departure}</div>

		<div class="con">출발지 : ${line.destination}</div>
		
		<div class="con">성인요금 : <span class="charge"></span> 원</div>

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
						<!--
						<span class="seatBox">
							<input age="adult" type="checkbox" name="seatBoxDt1" id="seatNum_30_${num}" value="${num}" />
							<label for="seatNum_30_${num}">${num}</label>
						</span> 
						-->
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


				
<!-- 	<div> -->
<!-- 		<span class="seatBox"> -->
<!-- 			<input type="checkbox" name="seatBoxDt1" id="seatNum_30_01" value="1" /> -->
<!-- 			<label for="seatNum_30_01">1</label> -->
<!-- 		</span>  -->
		
<!-- 		<span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_02" value="2" /><label -->
<!-- 			for="seatNum_30_02">2</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_03" value="3" /><label -->
<!-- 			for="seatNum_30_03">3</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_04" value="4" /><label -->
<!-- 			for="seatNum_30_04">4</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_05" value="5" /><label -->
<!-- 			for="seatNum_30_05">5</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_06" value="6" /><label -->
<!-- 			for="seatNum_30_06">6</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_07" value="7" /><label -->
<!-- 			for="seatNum_30_07">7</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_08" value="8" /><label -->
<!-- 			for="seatNum_30_08">8</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_09" value="9" /><label -->
<!-- 			for="seatNum_30_09">9</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_10" value="10" /><label -->
<!-- 			for="seatNum_30_10">10</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_11" value="11" /><label -->
<!-- 			for="seatNum_30_11">11</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_12" value="12" /><label -->
<!-- 			for="seatNum_30_12">12</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_13" value="13" /><label -->
<!-- 			for="seatNum_30_13">13</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_14" value="14" /><label -->
<!-- 			for="seatNum_30_14">14</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_15" value="15" /><label -->
<!-- 			for="seatNum_30_15">15</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_16" value="16" /><label -->
<!-- 			for="seatNum_30_16">16</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_17" value="17" /><label -->
<!-- 			for="seatNum_30_17">17</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_18" value="18" /><label -->
<!-- 			for="seatNum_30_18">18</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_19" value="19" /><label -->
<!-- 			for="seatNum_30_19">19</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_20" value="20" /><label -->
<!-- 			for="seatNum_30_20">20</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_21" value="21" /><label -->
<!-- 			for="seatNum_30_21">21</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_22" value="22" /><label -->
<!-- 			for="seatNum_30_22">22</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_23" value="23" /><label -->
<!-- 			for="seatNum_30_23">23</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_24" value="24" /><label -->
<!-- 			for="seatNum_30_24">24</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_25" value="25" /><label -->
<!-- 			for="seatNum_30_25">25</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_26" value="26" /><label -->
<!-- 			for="seatNum_30_26">26</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_27" value="27" /><label -->
<!-- 			for="seatNum_30_27">27</label></span> -->
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<span class="seatBox"><input type="checkbox" -->
<!-- 			name="seatBoxDt1" id="seatNum_30_28" value="28" /><label -->
<!-- 			for="seatNum_30_28">28</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_29" value="29" /><label -->
<!-- 			for="seatNum_30_29">29</label></span> <span class="seatBox"><input -->
<!-- 			type="checkbox" name="seatBoxDt1" id="seatNum_30_30" value="30" /><label -->
<!-- 			for="seatNum_30_30">30</label></span> -->
<!-- 	</div> -->
