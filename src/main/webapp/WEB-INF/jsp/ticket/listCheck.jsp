<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="티켓 목록" />
<%@ include file="../part/head.jspf"%>

<style>
	.ticket:hover {
		background-color:lightgray;
	}
</style>


<div class="con table-common">
	*티켓 목록이니까 정보 몇가지만 나열해놓은 목록으로 만들기
	
	<c:forEach items="${reservedTickets}" var="reservedTicket" varStatus="status">
		<table class="ticket ticekt-${status.count}" style="width:400px;margin:0 auto; cursor:pointer;" onclick="location.href='./check?id=${reservedTicket.id}'">
			
			<thead>
				<th>출발날짜</th>
				<th>출발지</th>
				<th>도착지</th>
				<th>출발시간</th>
			</thead>
			
			<tbody>
				<td>${reservedTicket.departureDate}</td>
				<td>${reservedTicket.extra.departure}</td>
				<td>${reservedTicket.extra.destination}</td>
				<td>${reservedTicket.extra.departureTime}</td>
			</tbody>
			
		</table>
		
		
		<c:if test="${!status.last}">
		
			<hr/>
		
		</c:if>
	</c:forEach>
	
	
</div>

<%@ include file="../part/foot.jspf"%>

	<tr>
		<th>예매번호</th>
		<td colspan="3">
			${reservedTicket.ticketCode}
		</td>
	</tr>
	<tr>
		<th>출발날짜</th>
		<td colspan="3">
			${reservedTicket.departureDate}
		</td>
	</tr>
	<tr>
		<th>출발지</th>
		<td>
			${reservedTicket.extra.departure}
		<th>도착지</th>
		<td>
			${reservedTicket.extra.destination}
		</td>
	</tr>
	<tr>
		<th>출발시간</th>
		<td>
			${reservedTicket.extra.departureTime}
		</td>
		<th>소요시간</th>
		<td>
			${reservedTicket.extra.estimatedTime}
		</td>
	</tr>
	<tr>
		<th>좌석번호</th>
		<td colspan="3">
			${reservedTicket.seatNum}
		</td>
	</tr>
	<tr>
		<th>결제자</th>
		<td>
			${reservedTicket.extra.memberName}
		</td>
		<th>결제 금액</th>
		<td>
			<fmt:formatNumber value = "${reservedTicket.charge}"  type="number" /> 원
		</td>
	</tr>