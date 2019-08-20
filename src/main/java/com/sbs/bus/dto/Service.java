package com.sbs.bus.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class Service {
	private int id;
	private String regDate;
	private String startTime;
	private String endTime;
	private int busId;
	private int lineId;
	private Map<String, Object> extra;
}
