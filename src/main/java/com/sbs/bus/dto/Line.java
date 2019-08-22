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
public class Line {
	private int id;
	private String regDate;
	private String departure;
	private String destination;
	private int charge;
	private Map<String, Object> extra;
}
