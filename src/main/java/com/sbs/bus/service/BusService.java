package com.sbs.bus.service;

import java.util.Map;

import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;

public interface BusService {

	public Map<String, Object> doReserve(Map<String, Object> param);

	public Line getServiceData(Map<String, Object> param);

	public Bus getBus(int busId);

}