package com.sbs.bus.dto;

import java.util.Map;

public class Ticket {
	private int id;
	private String regDate;
	private String ticketCode;
	private String boardingDate;
	private int serviceId;
	private int seatNum;
	private String email;
	private int charge;
	private Map<String, Object> extra;
}
