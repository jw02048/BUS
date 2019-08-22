<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="홈" />
<%@ include file="../part/head.jspf"%>

	<style>
		.searchBox.ticketCodeMode .searchFormByTicketCode {
			display:block;
		}
		
		.searchBox .searchFormByEmail {
			display:none;
		}
		
		.searchBox .searchFormByTicketCode {
			display:none;
		}
		
		.searchBox.emailMode .searchFormByEmail {
			display:block;
		}
		
		
	</style>

	<script>
		function searchByTicketCode() {
			var $searchBox = $('.searchBox');

			$searchBox.addClass('ticketCodeMode');
			$searchBox.removeClass('emailMode');
		}

		function searchByEmail() {
			var $searchBox = $('.searchBox');

			$searchBox.addClass('emailMode');
			$searchBox.removeClass('ticketCodeMode');
		}
	</script>

	<section>
		
		<div class="con searchBox">
			<div>
				<button onclick="searchByTicketCode();">티켓 코드로 찾기</button>
				<form class="searchFormByTicketCode" action="/ticket/check">
					<input type="text" name="ticketCode">
					<input type="submit" value="검색">
				</form>
			</div>
		
			<div>
				<button onclick="searchByEmail();">이메일로 찾기</button>
				<form class="searchFormByEmail" action="/ticket/listCheck">
					<input type="text" name="memberEmail">
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
	
	</section>
			

<h3 class="con">메인화면 입니다.</h3>


<%@ include file="../part/foot.jspf"%>