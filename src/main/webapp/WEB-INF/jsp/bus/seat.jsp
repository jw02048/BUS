<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="좌석선택" />
<%@ include file="../part/head.jspf"%>
<link rel="stylesheet" href="/resource/seat.css">
<script>
	var serviceId = ${param.serviceId};
	var departureDate = '${param.departureDate}';
	var departure = '${line.departure}';
	var destination = '${line.destination}';
	var adultCharge = ${line.charge};
	var seatNums = ${seatNums};
</script>
<script src="/resource/seat.js"></script>
<h3 class="con main-text">즐거운 여행의 시작과 끝, SBS 버스와 함께!</h3>

<div class="con table-common seat-page">
	<div class="left-box table-common con">

		<div class="con">출발날짜 : <span class="departureDate"></span></div>

		<div class="con">출발지 : <span class="departure"></span></div>

		<div class="con">출발지 : <span class="destination"></span></div>
		
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