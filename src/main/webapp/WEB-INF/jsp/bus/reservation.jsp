<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="예매" />
<%@ include file="../part/head.jspf"%>

<script>
	function submitReserveForm(form) {
		var emailP = /\w+@\w+\.\w+\.?\w*/;
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		var email = form.email.value;
		
		if (!email.match(emailP)) {
			alert("이메일 형식에 맞지 않습니다.");
			return false;
		}
		form.submit();
	}
</script>


<form action="./doReserve" method="POST"
		onsubmit="submitReserveForm(this); return false;">
	<div class="con table-common">
		<table>
			<colgroup>
				<col width="150">
			</colgroup>
			<tbody>
				<tr>
					<th>예매정보<th>
					<table style="width:300px;margin:0 auto;">
						<tr>
							<th>출발날짜</th>
							<td colspan="3">
								${reservationInfo.departureDate}
								<input type="hidden" name="departureDate" value="${reservationInfo.departureDate}" />
							</td>
						</tr>
						<tr>
							<th>출발지</th>
							<td>
								${reservationInfo.departure}
								<input type="hidden" name="departure" value="${reservationInfo.departure}"/>
							</td>
							<th>도착지</th>
							<td>
								${reservationInfo.destination}
								<input type="hidden" name="destination" value="${reservationInfo.destination}"/>
							</td>
						</tr>
						<tr>
							<th>출발시간</th>
							<td>
								${reservationInfo.departureTime}
								<input type="hidden" name="departureTime" value="${reservationInfo.departureTime}"/>
							</td>
							<th>소요시간</th>
							<td>
								${reservationInfo.estimatedTime}
								<input type="hidden" name="endTime" value="${reservationInfo.estimatedTime}" />
						</tr>
						<tr>
							<th>좌석번호</th>
							<td colspan="3">
								${reservationInfo.seatNum}
								<input type="hidden" name="seatNum" value="${reservationInfo.seatNum}"/>
							</td>
						</tr>
					</table>
					위 내용을 확인하셨다면 아래에서 결제를 진행해주세요
				<tr>
				<tr>
					<th>결제금액</th>
					<td>
						${reservationInfo.charge}원
						<input type="hidden" name="charge" value="${reservationInfo.charge}"/>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" value="${member.email}"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<div class="text-align-center">
			<input type="hidden" name="serviceId" value="${reservationInfo.serviceId}">
			<input class="btn-a" type="submit" value="예매완료"> 
			<input class="btn-a" type="reset" value="취소" onclick="location.href = '/';">
		</div>
	</div>
</form>

<%@ include file="../part/foot.jspf"%>