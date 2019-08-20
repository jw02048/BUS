package com.sbs.bus.controller;

import java.util.HashMap;
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
import com.sbs.bus.util.CUtil;

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
		String seatNum = "10"; 
		int charge = 10000; 
		int serviceId = 1;  
		
		String departure = "서울"; //serviceId-lineId
		String destination = "대전"; //serviceId-lineId
		String departureTime = "12:00"; //serviceId
		String estimatedTime = "2시간"; //serviceId
		
		reservationInfo.put("departureDate",departureDate);
		reservationInfo.put("seatNum",seatNum);
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
	public String doReserve(Model model, @RequestParam Map<String, Object> param,HttpServletRequest request ) {
				
		// parameter
		// departureDate, serviceId, seatNum, email, charge
		long memberId = (long)request.getAttribute("loginedMemberId");
		param.put("memberId", memberId);
		
		Map<String, Object> rs = busService.doReserve(param);

		String msg = (String) rs.get("msg");
		
		model.addAttribute("alertMsg", msg);
		
		String resultCode = (String) rs.get("resultCode");

		if (resultCode.startsWith("F-")) {
			
			model.addAttribute("historyBack", true);

			return "common/redirect";
		}
		
		String redirectUrl = (String) param.get("redirectUrl");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "../ticket/check?id=" + rs.get("ticketId");
		}

		model.addAttribute("redirectUrl", redirectUrl);

		// 1.결제 후 바로 jsp이동
		return "common/redirect";

	}
	
	// 2.마이페이지나 예매번호 검색에서 경로 접속
	@RequestMapping("ticket/check") 
	public String showTicket(@RequestParam Map<String,Object> param, Model model) {
		
		Ticket reservedTicket = new Ticket();
		if (param.containsKey("id")) {
			reservedTicket = busService.getTicket(param);
		} else if (param.containsKey("ticketCode")) {
			reservedTicket = busService.getTicket(param);
		}
		// 2-1.티켓 번호로 경로 요청 
		// 2-2.마이페이지에서 예매한 티켓 목록 리스트 중 클릭해서 접속 (티켓 아이디로)
		// 두 경우 다 티켓 객체 불러와서 모델 삽입
		
		if (reservedTicket == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "예매된 티켓 정보가 없습니다");
			
			return "common/redirect";
		}
		
		model.addAttribute("reservedTicket", reservedTicket);
		
		return "ticket/check";
	}
}