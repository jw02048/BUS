package com.sbs.bus.service;

import java.util.List;
import java.util.Map;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.sbs.bus.dao.BusDao;
import com.sbs.bus.dto.Ticket;
import com.sbs.bus.handler.MailHandler;
import com.sbs.bus.util.CUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BusServiceImpl implements BusService {
	@Value("${custom.emailSender}")
	private String emailSender;
	@Value("${custom.emailSenderName}")
	private String emailSenderName;
	
	@Autowired
	private JavaMailSender sender;
	@Autowired
	BusDao busDao;
	
	public Ticket getTicket(Map<String, Object> param) {
		return busDao.getTicket(param);
	}
	
	public List<Ticket> getTicketList(Map<String, Object> param) {
		return busDao.getTicketList(param);
	}

	public Map<String, Object> doReserve(Map<String, Object> param, String[] seatNums) {

		// 0.인원/좌석 선택 > parameter : departureDate,serviceId,seatNum,charge
		// 1.임의 결제 진행 > parameter : email
		// 2.ticketCode 생성 * 좌석수
		// 3.DB 티켓 INSERT VALUE (ticketCode*, departureDate,serviceId,seatNum,email,charge) * 좌석수
		// 4.이메일로 티켓 정보 전송 한번에
		
		String msg = null;
		String resultCode = null;
		StringBuffer emailContent = new StringBuffer();
		
		for ( String seatNum : seatNums ) {
			System.out.println("좌석 :");
			System.out.println(seatNum);
		
			String ticketCode = String.format("%s-%s-%s", CUtil.getTempNumKey(4),CUtil.getTempNumKey(4),CUtil.getTempNumKey(4)); //parameter
			param.put("ticketCode", ticketCode);		
			
			param.put("seatNum",Integer.parseInt(seatNum));
			busDao.newTicket(param); // ticket 데이터 추가 후 param에 id값 저장 
			
			Ticket ticketInfo = getTicket(param); // 위 ticket의 id로 티켓 조인 정보 전부 가져옴
			
			emailContent.append("티켓코드 : " + ticketCode + "<br>")
						.append("출발날짜 : " + param.get("departureDate") + "<br>")
						.append("출발지 : " + ticketInfo.getExtra().get("departure") + "<br>")
						.append("도착지 : " + ticketInfo.getExtra().get("destination") + "<br>")
						.append("출발시간 : " + ticketInfo.getExtra().get("departureTime") + "<br>")
						.append("도착시간 : " + ticketInfo.getExtra().get("estimatedTime") + "<br>")
						.append("좌석번호 : " + seatNum + "<br>")
						.append("결제자 : " + ticketInfo.getExtra().get("memberName") + "<br>")
						.append("결제금액 : " + param.get("charge") +"원 <br><hr>");

		}

		MailHandler mail;
		try {
			mail = new MailHandler(sender);
			mail.setFrom(emailSender, emailSenderName);
			mail.setTo((String) param.get("email"));
			mail.setSubject("예매 완료 알림 서비스");
			mail.setText("<h1>예매 정보</h1>" + "<hr>" +
							emailContent.toString());
			mail.send();
			msg = "예매 되었습니다.";
			resultCode = "S-2";
		} catch (Exception e) {
			msg = "예매에 실패했습니다.";
			resultCode = "F-2";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode, "memberEmail", (String) param.get("email"));
	}

}
