<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="TimeTable" />
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
        border:1px solid black;
    }

div.left {
        width: 20%;
        height: 700px;
        float: left;
        box-sizing: border-box;
        border:1px solid gray;
    }

div.right {
        width: 80%;
        float: right;
        box-sizing: border-box;
        border:1px solid gray;
    }

div.right .head {
        height:80px;
        font-weight:bold;
        font-size:3rem;
    }
    
div.right .head span {
	display:inline-block;
}

div.right .bustime-body {
		margin-top:3px;
        width:100%; 
        height:600px; 
        overflow-y:scroll;
    }

.right .head:first-child i{
	background-color:#ddd;
	padding:5px;
}

.right .head {
	background-color:#eee;
	text-align:center
}

.infoBox {
	text-align:center;
	font-size:1.2rem;
}

.route_wrap .roundBox {
	display:block;
	font-size:22px;
	padding-left:10px;
	position:relative;
}

.route_wrap .roundBox::before {
	display:block;
	position:absolute;
	left:40px;
	top:0;
	width:40px;
	height:40px;
	border-radius:50%;
	font-size:12px;
	text-align:center;
	line-height:40px;
	background-color:pink;
}

.route_wrap div:first-child > .roundBox::after {
	display:block;
	content:"";
	position:absolute;
	left:59px;
	top:40px;
	width:1px;
	height:100%;
	border-left:1px solid #ddd;
}

.route_wrap .departure::before {
	content:"출발";
}

.route_wrap .arrive::before {
	content:"도착";
}

.bustime-head:first-child {
	width:40%;
}

.bustime-head {
	width:100%;
	padding:0 15px 0 20px;
	border-bottom:1px solid #e6e6e6;
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
					<p class="roundBox departure"><c:out value="${Info.departure}" /></p>
				</div>
				<div>
					<p class="roundBox arrive"><c:out value="${Info.destination}" /></p>
				</div>
			</div>
			<div>
				요금정보
			</div>	
		</div>
	</div>
	<div class="right">
		<div class="head">
			<span style="padding:5px 10px; float:left; font-size:2.7rem;"><i class="fas fa-redo"></i></span>
			<span><c:out value="${Info.departureDate}" /></span>
			<span style="padding:1px 10px 10px 10px; float:right; font-size:3rem;"><i class="far fa-calendar-alt"></i></span>
		</div>
		<div class="detailBox-body">
			<p class="bustime-head">
				<span class="start-time">Departure</span>
				<span class="bus-Info">Company</span>
				<span class="grade">Grade</span>
				<span class="remain">Remaining Seats</span>
			</p>
			<div class="bustime-body">
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
</div>

<%@ include file="../part/foot.jspf"%>