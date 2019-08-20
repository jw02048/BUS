package com.sbs.bus.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.bus.dto.Member;
import com.sbs.bus.dto.Service;
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

	@RequestMapping("/bus/reservation")
	public String payment(Model model, HttpSession session) {
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");
		Member member = memberService.getOne(loginedMemberId);
		model.addAttribute("member", member);
		return "bus/reservation";
	}

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