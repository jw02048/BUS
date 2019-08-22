package com.sbs.bus.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.bus.dto.Member;
import com.sbs.bus.dto.Ticket;
import com.sbs.bus.service.BusService;
import com.sbs.bus.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BusController {

	@Autowired
	BusService busService;

	@Autowired
	MemberService memberService;

	@RequestMapping("bus/reservation")
	public String payment(@RequestParam Map<String,Object> param, Model model, HttpSession session) {
		
		Map<String,Object> reservationInfo = new HashMap<>();
		
		// parameter
		// departureDate, serviceId, seatNum, charge
		String departureDate = "2019-00-00"; 
		String[] seatNums = {"7","8","10","11"}; 
		int charge = 10000; 
		int serviceId = 1;  
		
		String departure = "서울"; //serviceId-lineId
		String destination = "대전"; //serviceId-lineId
		String departureTime = "12:00"; //serviceId
		String estimatedTime = "2시간"; //serviceId
		reservationInfo.put("departureDate",departureDate);
		reservationInfo.put("seatNums",seatNums);
		reservationInfo.put("charge",charge);
		reservationInfo.put("departure",departure);
		reservationInfo.put("destination",destination);
		reservationInfo.put("departureTime",departureTime);
		reservationInfo.put("estimatedTime",estimatedTime);
		reservationInfo.put("serviceId",serviceId);
		
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");
		Member member = memberService.getOne(loginedMemberId);
		
		model.addAttribute("member", member);
		
		model.addAttribute("reservationInfo", reservationInfo); // 앞에서 넘어온 param 넣으면 된다.
		
		return "bus/reservation";
		
	}

	@RequestMapping("bus/doReserve")
	public String doReserve(String[] seatNums, Model model, @RequestParam Map<String, Object> param,HttpServletRequest request ) {
				
		// parameter
		// departureDate, serviceId, seatNum, email, charge
		long memberId = (long)request.getAttribute("loginedMemberId");
		param.put("memberId", memberId);
		
		Map<String, Object> rs = busService.doReserve(param,seatNums);

		String msg = (String) rs.get("msg");
		
		model.addAttribute("alertMsg", msg);
		
		String resultCode = (String) rs.get("resultCode");

		if (resultCode.startsWith("F-")) {
			
			model.addAttribute("historyBack", true);

			return "common/redirect";
		}
		
		String redirectUrl = (String) param.get("redirectUrl");

		// 방금!!! 결제가 끝난 애들의 묶음을 보여주기 위한 페이지
		// 어떤 정보를 기준으로 여러 티켓을 보여주나? 우선은 이메일
		// 비회원일 경우를 대비해 여러 티켓의 공통정보는 이메일
		// 티켓에 유효 무효 나눠야 할 듯!!!
		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "../ticket/listCheck?memberEmail=" + rs.get("memberEmail");
			
			// redirectUrl = "../ticket/check?id=" + rs.get("ticketId");
		}

		model.addAttribute("redirectUrl", redirectUrl);

		// 결제 후 바로 jsp이동
		return "common/redirect";

	}
	
	// 결제 후 또는 마이페이지 티켓리스트로 접속
	@RequestMapping("ticket/listCheck") 
	public String showTicketList(@RequestParam Map<String,Object> param, Model model,HttpServletRequest request) {
		
		// 접속 가능한 파라미터 : email, session(마이페이지)
		
		List<Ticket> reservedTickets = null;
		
		if (param.containsKey("memberEmail")) {

			reservedTickets = busService.getTicketList(param);
			
		} else if ((boolean)request.getAttribute("isLogined") ) {
						
			param.put("memberId", (long)request.getAttribute("loginedMemberId"));
			
			reservedTickets = busService.getTicketList(param);
		}
		
		if (reservedTickets.size() == 0) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "예매된 티켓 정보가 없습니다");
			
			return "common/redirect";
		}
		
		model.addAttribute("reservedTickets", reservedTickets);
		
		return "ticket/listCheck";
	}
	
	// 티켓리스트나 예매번호 검색에서 경로 접속
	@RequestMapping("ticket/check") //티켓 하나씩
	public String showTicket(@RequestParam Map<String,Object> param, Model model) {

		// 접속 가능한 파라미터 : id(ticket), ticketCode
		
		Ticket reservedTicket = new Ticket();
		if (param.containsKey("id")) {
			reservedTicket = busService.getTicket(param);
		} else if (param.containsKey("ticketCode")) {
			reservedTicket = busService.getTicket(param);
		}
		
		if (reservedTicket == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "예매된 티켓 정보가 없습니다");
			
			return "common/redirect";
		}
		
		model.addAttribute("reservedTicket", reservedTicket);
		
		return "ticket/check";
	}
}