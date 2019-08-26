<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="TimesTable" />
<%@ include file="../part/head.jspf"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" 
crossorigin="anonymous">
<script src="/resource/app.js"></script>
<script>
	var departureDate = '${Info.departureDate}';

	function submitSelectTime(el) {
		var $tr = $(el);
		var serviceId = $tr.attr('data-id');

		if(confirm('선택하신 날짜가 ${Info.departureDate}이 맞습니까?')) {
			location.replace('./seat?serviceId=' + serviceId + '&departureDate=' + departureDate);
		}
		return;
	}
</script>
<style>
.time-list {
	margin-top:100px;
    width: 100%;
    height: 700px;
    border:1px solid red;
}

div.left {
    width: 20%;
    height: 700px;
    float: left;
    box-sizing: border-box;
    border:1px solid pink;
}

div.right {
    width: 80%;
    float: right;
    box-sizing: border-box;
    border:1px solid pink;
}

div.right .head {
    height:80px;
    font-weight:bold;
    font-size:3rem;
}
    
div.right .head span {
	display:inline-block;
}

div.right .body {
	margin-top:3px;
    width:100%; 
    height:600px; 
    overflow-y:scroll;
}
    
.head-menu .head-common{
	display:inline-block;
	width:150px;
}

</style>

<div class="time-list table-common con">
	<div class="left">
		<div>
			날짜 :
			<c:out value="${Info.departureDate}" /><br>
			출발 :
			<c:out value="${Info.departure}" /><br>
			도착 :
			<c:out value="${Info.destination}" /><br>
		</div>
	</div>
	<div class="right">
		<div class="head">
			<span style="padding:0 10px;"><i class="fas fa-redo"></i></span>
			<c:out value="${Info.departureDate}" />
			<span style="padding:0 15px; float:right"><i class="far fa-calendar-alt"></i></span>
		</div>
		<div class="head-menu">
			<div class="head-common">Departure</div>
			<div class="head-common">Company</div>
			<div class="head-common">Grade</div>
			<div class="head-common">Remaining Seats</div>
		</div>
		<div class="body">
		<table>	
			<colgroup>
				<col width="150">
				<col>
				<col width="300">
			</colgroup>
			<tbody>
				<c:forEach var="timeList" items="${TimeList}">
					<tr data-id="${timeList.id}" onclick="submitSelectTime(this); return false;">
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

<%@ include file="../part/foot.jspf"%>
