<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="TimeTable" />
<%@ include file="../part/head.jspf"%>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/resource/schedule.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="/resource/app.js"></script>
<style>
.ui-datepicker-calendar .selected a {
    color:white;
    background-image:none;
    background-color:#afafaf;
}
</style>
<script>
	$(function() {
		// datepicker 한국어로 사용하기 위한 언어설정
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$('#time2')
				.datepicker(
						{
							minDate : 0,
							maxDate : '+1m',
							dateFormat : 'yy-mm-dd',
							defaultDate : '${Info.departureDate}',
							beforeShowDay : function(date) {

								var selectedDateStr = $(this).attr(
										'data-selected-date');
								var selectedDateStrBits = selectedDateStr
										.split('-');

								for (var i = 0; i < selectedDateStrBits.length; i++) {
									selectedDateStrBits[i] = parseInt(selectedDateStrBits[i]);
								}

								if (date.getFullYear() == selectedDateStrBits[0]
										&& date.getMonth() + 1 == selectedDateStrBits[1]
										&& date.getDate() == selectedDateStrBits[2]) {
									return [ true, 'selected', '' ];
								} else {
									return [ true, '', '' ];
								}
							},
							onSelect : function() {

								var date = $(this).val();

								var newDateUrl = replaceUrlParam(
										getNoDomainUrl(), 'departureDate', date);

								location.href = newDateUrl;
							}
						});
	});

	var departureDate = '${Info.departureDate}';
	function submitSelectTime(el) {
		var $tr = $(el);
		var serviceId = $tr.attr('data-id');
		if (confirm('선택하신 날짜가 ${Info.departureDate}이 맞습니까?')) {
			location.replace('./seat?serviceId=' + serviceId
					+ '&departureDate=' + departureDate);
		}
		return;
	}
</script>
<style>
.table-type-1 {
	width: 100%;
	border-collapse: collapse;
}

.table-type-1 td, .table-type-1 th {
	text-align: left;
	border: 1px solid black;
}

.con {
	width: 1000px;
}
/* 커스텀 */
.table-box .table-1 {
	width: 100%;
}

.body .table-box-body {
	height: 570px;
	overflow-y: scroll;
	overflow-x: hidden;
}

.body {
	border: 1px solid gray;
}

.body .table-box-head tr th:nth-child(2) {
	text-align: center;
}

.body>*>table>*>tr>*:first-child {
	border-left-width: 0;
}

.body>*>table>*>tr>*:last-child {
	border-right-width: 0;
}

.body>*>table>*>tr:first-child>* {
	border-top-width: 0;
}

.body>.table-box-body>table>*>tr:last-child>* {
	border-bottom-width: 0;
}
</style>

<div class="time-list table-common con">
	<div class="left">
		<div class="infoBox">
			<p class="date">
				<c:out value="${Info.departureDate}" />
			</p>
			<div class="route_wrap">
				<div>
					<p class="roundBox departure">
						<c:out value="${Info.departure}" />
					</p>
				</div>
				<div>
					<p class="roundBox arrive">
						<c:out value="${Info.destination}" />
					</p>
				</div>
			</div>
			<div>요금정보</div>
		</div>
	</div>
	<div class="right">
		<div class="head">
			<span
				style="padding: 5px 10px; float: left; font-size: 2.7rem; cursor: pointer;"><i
				class="fas fa-redo" onclick="window.location.reload();"></i></span> <span><c:out
					value="${Info.departureDate}" /></span> <span class="btn-date"
				style="padding: 1px 10px 10px 10px; float: right; font-size: 3rem;"><i
				class="far fa-calendar-alt"></i><input id="time2"
				name="departureDate" class="datepicker-a1" readonly data-selected-date="${Info.departureDate}"></span>
		</div>
		<div class="body">
			<div class="table-box table-box-head">
				<table class="table-type-1">
					<colgroup>
						<col width="150">
						<col>
						<col width="250">
					</colgroup>
					<thead>
						<tr>
							<th><span class="start-time">Departure</span></th>
							<th><span class="bus-Info">Company / </span> <span
								class="grade">Grade</span></th>
							<th><span class="remain">Remaining Seats</span></th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="table-box table-box-body">
				<table class="table-type-1">
					<colgroup>
						<col width="150">
						<col>
						<col width="250">
					</colgroup>
					<tbody>
						<c:forEach var="timeList" items="${TimeList}">
							<tr data-id="${timeList.id}"
								onclick="submitSelectTime(this); return false;">
								<td>${timeList.departureTime}</td>
								<td>${timeList.busId}</td>
								<td>${timeList.extra.remainingSeats}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div>
		<ul class="desc-list">
			<li>심야고속 및 심야우등의 할증 요금은 당일 02:00부터 04:00 사이 출발차량</li>
			<li>노선에 따라 심야요금과 심야할증요금이 동일할 수도 있음</li>
			<li>마일리지 구매 승차권은 프리미엄/편도 노선(일부노선 제외)에 한정하며 각 1매씩 예매 가능(*회원대상)</li>
			<li>유아 카시트 가능( ) 표시된 차량에만 유아 카시트 장착 가능 (본인 소유의 유아 카시트 준비)</li>
			<li>소요(도착)시간은 도로 사정에 따라 지연될 수 있음</li>
		</ul>
	</div>
</div>


<%@ include file="../part/foot.jspf"%>