<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sbs.bus.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="예매완료" />
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
		if (!email.match(emailP)) {
			alert("이메일 형식에 맞지 않습니다.");
			return false;
		}
		form.submit();
	}
</script>

<div class="con table-common">
	<form action="./doReserve" method="POST"
		onsubmit="submitReserveForm(this); return false;">
		<table>
			<colgroup>
				<col width="150">
			</colgroup>
			<tbody>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" value="${member.email}"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<div class="text-align-center">
			<input class="btn-a" type="submit" value="예매완료"> <input
				class="btn-a" type="reset" value="취소" onclick="location.href = '/';">
		</div>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>