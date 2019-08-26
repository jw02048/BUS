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

import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;
import com.sbs.bus.dto.Member;
import com.sbs.bus.dto.Service;
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

	@RequestMapping("/bus/schedule")
	public String schedule(Model model, @RequestParam Map<String, Object> param) {
		
		//input : 출발날짜, 출발지, 도착지
		//output : serviceId, 출발날짜
		
		//lineId 가져옴
		int lindId = busService.getLineId(param);
		
		//lineId와 날짜에 맞는 시간표리스트 가져옴;
		param.put("lineId", lindId);
		List<Service> timeList = busService.getServiceList(param);
		
		model.addAttribute("Info",param);
		model.addAttribute("TimeList", timeList);
		
		return "bus/schedule";
	}

	@RequestMapping("/bus/seat")
	public String seat(@RequestParam Map<String, Object> param, Model model) {
				
		//input : 출발날짜, 서비스아이디
		//output : 출발날짜, 서비스아이디, 좌석번호(배열), 요금
		
		// 서비스데이터 경로값으로 받아옴
		Line line = busService.getServiceData(param);
		System.out.println("==================================================" + param.get("departureDate"));
		// 버스데이터 받아옴
		int busId = Integer.parseInt((String)line.getExtra().get("busId"));
		
		Bus bus = busService.getBus(busId);
		
		model.addAttribute("line", line);
		model.addAttribute("bus", bus);
		model.addAttribute("param", param);
		
		return "bus/seat";
	}
	
	// String[]들 param map에 담겨오고 그대로 사용 가능한지 알아볼 것
	@RequestMapping("bus/reservation")
	public String payment(String[] seatNums, String[] charges,@RequestParam Map<String,Object> param, Model model, HttpSession session) {
				
		// param : serviceId, departureDate, totalCharge, selectSeat
		
		Line lineInfo = busService.getServiceData(param);
		
//		lineInfo : departure, destination, (extra)departureTime, (extra)estimatedTime
		
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");
		Member member = memberService.getOne(loginedMemberId);
		
		model.addAttribute("member", member);
		
		model.addAttribute("param", param);
		model.addAttribute("lineInfo", lineInfo);
		
		return "bus/reservation";
	}
		
	@RequestMapping("bus/doReserve")
	public String doReserve(String[] seatNums, String[] charges,Model model, @RequestParam Map<String, Object> param,HttpServletRequest request ) {
				
		// parameter
		// departureDate, serviceId, seatNums[], email, charges[]
		long memberId = (long)request.getAttribute("loginedMemberId");
		param.put("memberId", memberId);
		
		Map<String, Object> rs = busService.doReserve(param,seatNums,charges);

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