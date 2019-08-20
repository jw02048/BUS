package com.sbs.bus.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Service {
	
	private int id;
	private String regDate;
	private String departureTime;
	private String estimatedTime;
	private int busId;
	private int lineId;
	private Map<String, Object> extra;
}
