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
	var totalSeat = ${bus.totalSeat};
</script>
<script src="/resource/seat.js"></script>
<h3 class="con main-text">즐거운 여행의 시작과 끝, SBS 버스와 함께!</h3>

<div class="con table-common seat-page">
	<div class="left-box table-common con">

		<div class="date"><span class="departureDate"></span></div>
		
		<div class="vertical-line">
		
			<div class="round-relative">
				<p class="departure round"></p>
			</div>

			<div class="round-relative">
				<p class="destination round"></p>
			</div>
			
		</div>
		
		<hr/>
		
		<div class="round-relative"><p class="adultCharge round"></p></div>

	</div>

	<div class="middle-box con">
		<div class="bg_seatBox"></div>
		<div class="head">
			<div class="remain-info">
				잔여 <span class="remain-seat"></span>석 / 전체 <span class="total-seat"></span>석
			</div>
		</div>
		<div class="selectSeat_box">
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
	<div class="right-box con">
		<div>결제금액 : <span class="total-charge">0</span> 원</div>
		
		<div class="container con">
			<div class="row">
				<div class="col">
					<a href="#" class="btn btn-concrete btn-complete-select">선택완료</a>
				</div>
			</div>
		</div>
	</div>
	
</div>


<%@ include file="../part/foot.jspf"%>