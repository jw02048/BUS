package com.sbs.bus.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Ticket {
	private int id;
	private String regDate;
	private String ticketCode;
	private String departureDate;
	private int serviceId;
	private int seatNum;
	private int memberId;
	private String email;
	private int charge;
	private Map<String, String> extra;
}
