<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="홈" />
<%@ include file="../part/head.jspf"%>

<script src="/resource/app.js"></script>

<script>
	function sendPointForm(form) {
		form.departure.value = form.departure.value.trim();
		if (form.departure.value.length == 0) {
			alert('출발지를 선택해주세요.');
			return false;
		}
		form.destination.value = form.destination.value.trim();
		if (form.destination.value.length == 0) {
			alert('도착지를 선택해주세요.');
			return false;
		}
		form.departureDate.value = form.departureDate.value.trim();
		if (form.departureDate.value.length == 0) {
			alert('출발날짜를 선택해주세요.');
			return false;
		}
		form.submit();
	}
</script>

<div class="popup-bg"></div>

<div class="popup popup-departure">
	<div class="head">
		<div class="btn-close"></div>
	</div>
	<div>출발지를 선택해주세요.</div>
	<div class="top-bar con margin-top-size-1">
		<nav class="menu-1">
			<ul class="row">
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="서울" onclick="selectDeparture(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="인천" onclick="selectDeparture(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="대전" onclick="selectDeparture(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="대구" onclick="selectDeparture(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="부산" onclick="selectDeparture(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="울산" onclick="selectDeparture(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="광주" onclick="selectDeparture(this)"></li>
			</ul>
		</nav>
	</div>
</div>

<div class="popup popup-destination">
	<div class="head">
		<div class="btn-close"></div>
	</div>
	<div>도착지를 선택해주세요.</div>
	<div class="top-bar con margin-top-size-1">
		<nav class="menu-1">
			<ul class="row">
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="서울" onclick="selectDestination(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="인천" onclick="selectDestination(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="대전" onclick="selectDestination(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="대구" onclick="selectDestination(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="부산" onclick="selectDestination(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="울산" onclick="selectDestination(this)"></li>
				<li class="cell margin-right-size-1"><input class="block btn-a"
					type="button" value="광주" onclick="selectDestination(this)"></li>
			</ul>
		</nav>
	</div>
</div>

<h3 class="con main-text">즐거운 여행의 시작과 끝, SBS 버스와 함께!</h3>

<div class="con table-common selectForm">

	<table>
		<colgroup>
			<col>
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th>편도</th>
				<th>왕복(미구현)</th>
			</tr>
			<tr>
				<th><button class="block btn-a btn-departure">출발지 선택</button></th>
				<th><button class="block btn-a btn-destination">도착지 선택</button></th>
			</tr>
		</tbody>
	</table>

</div>

<br>

<div class="con table-common pointForm">
	<form action="../bus/schedule" method="POST"
		onsubmit="sendPointForm(this); return false;">
		<table>
			<colgroup>
				<col>
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th><input type="text" name="departure" placeholder="출발지"></th>
					<th><input type="text" name="destination" placeholder="도착지"></th>
				</tr>
			</tbody>
		</table>
		<br>
		<table>
			<colgroup>
				<col>
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th>오늘 날짜 : <span id="today"></span></th>
					<th><input type="text" id="time" name="departureDate"  size="13" /></th>
				</tr>
			</tbody>
		</table>
		<br>
		<div class="text-align-right">
			<button class="block btn-a" type="submit">조회하기</button>
		</div>
	</form>
</div>



<%@ include file="../part/foot.jspf"%>
