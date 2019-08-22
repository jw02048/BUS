<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="좌석선택" />
<%@ include file="../part/head.jspf"%>
<style>
.seatBox {
	width: 60px;
	height: 55px;
	display: inline-block;
	border: 1px solid;
	margin: 1.5px 1px;
}
.seatBox:nth-child(3n) {
	margin-left: 60px;
}
.seatBox:nth-child(3n+1) {
	margin-right: 2px;
	margin-left: 3px;
}
.seat-page {
	width: 1000px;
	margin-top: 50px;
}

label {
	font-size: 1.3rem;
}
.left-box {
	width: 29%;
	height: 600px;
	border: 1px solid;
	float: left;
	font-size: 1.5rem;
}
.left-box > *, .right-box > * {
	margin-left: 10px;
}
.middle-box {
	width: 30%;
	height: 600px;
	border: 1px solid;
	float: left;
	
}
.right-box {
	float:left;
	width: 29%;
	height: 600px;
	border: 1px solid;
	font-size: 1.5rem;
}
</style>
<script>
	$('.btn-complete-select').click(function() {
		subSelectSeat();
	});
	function subSelectSeat() {
		var cnt = $("input:checkbox[name=seatBoxDt1]:checked").length;

		var totalCharge = ${line.charge} * cnt;

		var serviceId = ${param.serviceId};

		var departureDate = ${param.departureDate};
		
		var checkBoxSelect = $('input[name=seatBoxDt1]');

		var sendArr = [];

		var sendCnt = 0;

		for( var i = 0; i < checkBoxSelect.length; i++ ) {
		    if ( checkBoxSelect[i].checked == true ) {
		    	sendArr[sendCnt] = checkBoxSelect[i].value;
		    	sendCnt++;
		    }
		}
		
		if ( confirm(cnt + ' 좌석 총 요금은' + totalCharge + '원입니다.') ) {
			location.replace('./reservation?serviceId=' + serviceId + '&departureDate=' + departureDate + '&totalCharge=' + totalCharge + '&selectSeat=' + sendArr);
			return ;
		}

	}
</script>

<h3 class="con main-text">즐거운 여행의 시작과 끝, SBS 버스와 함께!</h3>

<div class="con table-common seat-page">
	<div class="left-box table-common con">

		<div class="con">출발날짜 : ${param.departureDate}</div>

		<div class="con">출발지 : ${line.departure}</div>

		<div class="con">출발지 : ${line.destination}</div>
		
		<div class="con charge">요금 : ${line.charge} 원</div>

	</div>

	<div class="middle-box con">
		<div class="selectSeat_box">
			<div class="bg_seatBox seat30">
				<div class="seatList">
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_01" value="1" /><label
							for="seatNum_30_01">1</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_02" value="2" /><label
							for="seatNum_30_02">2</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_03" value="3" /><label
							for="seatNum_30_03">3</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_04" value="4" /><label
							for="seatNum_30_04">4</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_05" value="5" /><label
							for="seatNum_30_05">5</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_06" value="6" /><label
							for="seatNum_30_06">6</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_07" value="7" /><label
							for="seatNum_30_07">7</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_08" value="8" /><label
							for="seatNum_30_08">8</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_09" value="9" /><label
							for="seatNum_30_09">9</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_10" value="10" /><label
							for="seatNum_30_10">10</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_11" value="11" /><label
							for="seatNum_30_11">11</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_12" value="12" /><label
							for="seatNum_30_12">12</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_13" value="13" /><label
							for="seatNum_30_13">13</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_14" value="14" /><label
							for="seatNum_30_14">14</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_15" value="15" /><label
							for="seatNum_30_15">15</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_16" value="16" /><label
							for="seatNum_30_16">16</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_17" value="17" /><label
							for="seatNum_30_17">17</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_18" value="18" /><label
							for="seatNum_30_18">18</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_19" value="19" /><label
							for="seatNum_30_19">19</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_20" value="20" /><label
							for="seatNum_30_20">20</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_21" value="21" /><label
							for="seatNum_30_21">21</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_22" value="22" /><label
							for="seatNum_30_22">22</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_23" value="23" /><label
							for="seatNum_30_23">23</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_24" value="24" /><label
							for="seatNum_30_24">24</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_25" value="25" /><label
							for="seatNum_30_25">25</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_26" value="26" /><label
							for="seatNum_30_26">26</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_27" value="27" /><label
							for="seatNum_30_27">27</label></span>
					</div>
					<div>
						<span class="seatBox"><input type="checkbox"
							name="seatBoxDt1" id="seatNum_30_28" value="28" /><label
							for="seatNum_30_28">28</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_29" value="29" /><label
							for="seatNum_30_29">29</label></span> <span class="seatBox"><input
							type="checkbox" name="seatBoxDt1" id="seatNum_30_30" value="30" /><label
							for="seatNum_30_30">30</label></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="right-box con">
		총 금액 : <span class="total-charge"></span>
	</div>
	<div>
		<button class="btn-complete-select btn-a" onclick="subSelectSeat(); return false;">선택완료</button>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>