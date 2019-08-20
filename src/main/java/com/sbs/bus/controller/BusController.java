package com.sbs.bus.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;
import com.sbs.bus.dto.Member;
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

	@RequestMapping("/bus/order-step-payment")
	public String showMain2(Model model, HttpSession session) {
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");
		Member member = memberService.getOne(loginedMemberId);
		model.addAttribute("member", member);
		return "bus/order-step-payment";
	}

	@RequestMapping("/bus/order-step-seat")
	public String showSelectSeatPage(Model model, HttpSession session) {
		Map<String, Object> param = new HashMap<>();
		int serviceId = 1;
		param.put("serviceId", serviceId);
		Line line = busService.getServiceData(param);
		int busId = Integer.parseInt((String)line.getExtra().get("busId"));
		System.out.println("================================================" + busId);
		Bus bus = busService.getBus(busId);
		model.addAttribute("line", line);
		model.addAttribute("bus", bus);
		model.addAttribute("serviceId", serviceId);
		model.addAttribute("boardingDate", "2019-08-21");
		return "bus/order-step-seat";
	}
	
	@RequestMapping("/bus/test")
	public String showTestPage(@RequestParam Map<String, Object> param, String[] seatBoxDt1, Model model) {
		
		log.info("param : " + param);
		String serviceId = (String) param.get("serviceId");
		String boardingDate = (String) param.get("boardingDate");
		int charge = Integer.parseInt((String)param.get("charge"));
		List<Integer> seatNum = new ArrayList<>();
		
		for (String seat : seatBoxDt1) {
			System.out.println(seat);
		}
		
		return "bus/test";
	}

	@RequestMapping("bus/doReserve")
	public String doJoin(Model model, @RequestParam Map<String, Object> param, HttpSession session) {

		Map<String, Object> rs = busService.doReserve(param);

		String resultCode = (String) rs.get("resultCode");

		String redirectUrl = (String) param.get("redirectUrl");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "/";
		}

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);

		if (resultCode.startsWith("S-")) {
			model.addAttribute("redirectUrl", redirectUrl);
		} else {
			model.addAttribute("historyBack", true);
		}

		return "common/redirect";

	}
}