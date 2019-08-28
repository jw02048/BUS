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
	BusDao busDao;
	@Autowired
	private JavaMailSender sender;
	
	public Ticket getTicket(Map<String, Object> param) {
		return busDao.getTicket(param);
	}
	
	public List<Ticket> getTicketList(Map<String, Object> param) {
		return busDao.getTicketList(param);
	}

	public Map<String, Object> doReserve(Map<String, Object> param, String[] seatNums, String[] charges) {

		// 0.인원/좌석 선택 > parameter : departureDate,serviceId,seatNum,charge
		// 1.임의 결제 진행 > parameter : email
		// 2.ticketCode 생성 * 좌석수
		// 3.DB 티켓 INSERT VALUE (ticketCode*, departureDate,serviceId,seatNum,email,charge) * 좌석수
		// 4.이메일로 티켓 정보 전송 한번에
		
		String msg = null;
		String resultCode = null;
		StringBuffer emailContent = new StringBuffer();
		
		int idx = 0;
		
		for ( String seatNum : seatNums ) {
			param.put("seatNum",Integer.parseInt(seatNum));
			
			String ticketCode = String.format("%s-%s-%s", CUtil.getTempNumKey(4),CUtil.getTempNumKey(4),CUtil.getTempNumKey(4)); //parameter
			param.put("ticketCode", ticketCode);	
			
			int charge = Integer.parseInt(charges[idx]);
			param.put("charge", charge);	
			
			System.out.println("티켓 얻는 파라미터값들 : ");
			System.out.println(param);
			
//			티켓 얻는 파라미터값들 : 
//			{departureDate=2019-08-24, 
//					seatNums=4, (String[]으로 따로 쓰는 배열 -> param 값으로 사용 가능?)
//					charges=10000, (String[]으로 따로 쓰는 배열 -> param 값으로 사용 가능?)
//					charge=10000, 
//					email=kimddub@gmail.com, 
//					serviceId=1, 
//					memberId=1, 
//					seatNum=5, 
//					ticketCode=7485-1716-8818, 
//					id=17}		
			busDao.newTicket(param); // ticket 데이터 추가 후 param에 id값 저장 
			
			Ticket reservedTicketInfo = getTicket(param); // 위 ticket의 id로 티켓 조인 정보 전부 가져옴
			
			emailContent.append("티켓코드 : " + ticketCode + "<br>")
						.append("출발날짜 : " + param.get("departureDate") + "<br>")
						.append("출발지 : " + reservedTicketInfo.getExtra().get("departure") + "<br>")
						.append("도착지 : " + reservedTicketInfo.getExtra().get("destination") + "<br>")
						.append("출발시간 : " + reservedTicketInfo.getExtra().get("departureTime") + "<br>")
						.append("도착시간 : " + reservedTicketInfo.getExtra().get("estimatedTime") + "<br>")
						.append("좌석번호 : " + seatNum + "<br>")
						.append("결제자 : " + reservedTicketInfo.getExtra().get("memberName") + "<br>")
						.append("결제금액 : " + charge +"원 <br><hr>");

			idx++;
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

	@Override
	public List<Integer> getSelectedSeatNum(Map<String, Object> param) {
		return busDao.getSelectedSeatNum(param);
	}
	
}
