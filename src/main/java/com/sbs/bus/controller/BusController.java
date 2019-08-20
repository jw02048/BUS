package com.sbs.bus.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.bus.dto.Member;
import com.sbs.bus.service.BusService;
import com.sbs.bus.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BusController {

	@Autowired
	BusService BusService;

	@Autowired
	MemberService memberService;

	@RequestMapping("/bus/order-step-payment")
	public String payment(Model model, HttpSession session) {
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");
		Member member = memberService.getOne(loginedMemberId);
		model.addAttribute("member", member);
		return "bus/order-step-payment";
	}

	@RequestMapping("/bus/order-step-time")
	@ResponseBody
	public  Map<String, Object> time(Model model, HttpSession session, @RequestParam Map<String, Object> param) {
		return param;
	}

	@RequestMapping("bus/doReserve")
	public String doJoin(Model model, @RequestParam Map<String, Object> param, HttpSession session) {

		Map<String, Object> rs = BusService.doReserve(param);

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