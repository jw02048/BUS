package com.sbs.bus.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Line {
	private int id;
	private String regDate;
	private String departure;
	private String destination;
	private int charge;
}
