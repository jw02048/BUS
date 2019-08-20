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
	width: 50px;
	height: 50px;
	display: inline-block;
}
</style>
<script>
function subSelectSeatForm(form) {
	form.submit();
}

</script>

<div>${bus}</div>

<div>${line}</div>

<div>${boardingDate}</div>

<form action="./test" method="GET" onsubmit="subSelectSeatForm(this); return false;">
	<input type="hidden" name="boardingDate" value="${boardingDate}">
	<input type="hidden" name="serviceId" value="${serviceId}">
	<input type="hidden" name="charge" value="${line.charge}">


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
	<div>
		<input type="submit" value="선택" name="btn-complete-select" />
		<input type="reset" value="취소" />
	</div>
</form>
<%@ include file="../part/foot.jspf"%>