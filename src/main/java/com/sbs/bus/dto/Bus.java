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
public class Bus {
	private int id;
	private String regDate;
	private int totalSeat;
	private Map<String, Object> extra;
}
