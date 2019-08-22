<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					
					<c:forEach items="${param.seatNums}" var="seat" varStatus="status">
					
						<table class="ticket ticket-${status.count}" style="width:400px;margin:0 auto;">
							<tr>
								<th>출발날짜</th>
								<td colspan="3">
									${param.departureDate}
									<input type="hidden" name="departureDate" value="${param.departureDate}" />
								</td>
							</tr>
							<tr>
								<th>출발지</th>
								<td>
									${lineInfo.departure}
								</td>
								<th>도착지</th>
								<td>
									${lineInfo.destination}
								</td>
							</tr>
							<tr>
								<th>출발시간</th>
								<td>
									${lineInfo.extra.departureTime}
								</td>
								<th>소요시간</th>
								<td>
									${lineInfo.extra.estimatedTime}
								</td>
							</tr>
							<tr>
								<th>좌석번호</th>
								<td colspan="3">
									${seat}
									<input type="hidden" name="seatNums" value="${seat}"/>
								</td>
							</tr>
						</table>

						<c:if test="${!status.last}">
						
							<hr/>
						
						</c:if>
					
					</c:forEach>
					
					위 내용을 확인하셨다면 아래에서 결제를 진행해주세요
				<tr>
				<tr>
					<th>결제금액</th>
					<td>
						<c:set var="total" value="0"/>
						<c:forEach items="${param.charges}" var="charge">
							<c:set var= "total" value="${total + charge}"/>
							<input type="hidden" name="charges" value="${charge}"/>
						</c:forEach>
						
						<fmt:formatNumber value = "${total}"  type="number" /> 원
						<input type="hidden" name="charge" value="${param.charge}"/>
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
			<input type="hidden" name="serviceId" value="${param.serviceId}">
			<input class="btn-a" type="submit" value="예매완료"> 
			<input class="btn-a" type="reset" value="취소" onclick="location.href = '/';">
		</div>
	</div>
</form>

<%@ include file="../part/foot.jspf"%>