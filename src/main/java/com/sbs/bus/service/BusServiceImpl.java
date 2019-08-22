package com.sbs.bus.service;

import java.util.List;
import java.util.Map;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.sbs.bus.dao.BusDao;
import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;
import com.sbs.bus.handler.MailHandler;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BusServiceImpl implements BusService {
	@Value("${custom.emailSender}")
	private String emailSender;
	@Value("${custom.emailSenderName}")
	private String emailSenderName;
	
	@Autowired
	BusDao busDao;

	@Autowired
	private JavaMailSender sender;

	public Map<String, Object> doReserve(Map<String, Object> param) {

		String msg = null;
		String resultCode = null;

		MailHandler mail;
		try {
			mail = new MailHandler(sender);
			mail.setFrom(emailSender, emailSenderName);
			mail.setTo((String) param.get("email"));
			mail.setSubject("예매 완료 알림 서비스");
			mail.setText(new StringBuffer().append("<h1>예매 정보</h1>").append("티켓코드 : 0000-0000-0000<br>")
					.append("출발날짜 : 2019-00-00<br>").append("출발지 : @@<br>").append("도착지 : @@<br>")
					.append("출발시간 : 12:00<br>").append("도착시간 : 14:00<br>").append("결제자 : 홍길동<br>")
					.append("결제금액 : 10,000원<br>").toString());
			mail.send();
			msg = "예매 되었습니다.";
			resultCode = "S-2";
		} catch (Exception e) {
			msg = "예매에 실패했습니다.";
			resultCode = "F-2";
			e.printStackTrace();
		}

		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public int getLineId(Map<String, Object> reservationInfo) {
		
		return busDao.getLineId(reservationInfo);
	}


	public List<com.sbs.bus.dto.Service> getServiceList(Map<String,Object> reservationInfo) {
		
		return busDao.getServiceList(reservationInfo);
	}
	
	@Override
	public Line getServiceData(Map<String, Object> param) {
		return busDao.getServiceData(param);
	}
	
	@Override
	public Bus getBus(int busId) {
		return busDao.getBus(busId);
	}
	
}
