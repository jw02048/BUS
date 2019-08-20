package com.sbs.bus.service;

import java.util.List;
import java.util.Map;

import com.sbs.bus.dto.Service;

public interface BusService {

	public Map<String, Object> doReserve(Map<String, Object> param);

	public int getLineId(Map<String, Object> reservationInfo);

	public List<Service> getServiceList(Map<String,Object> reservationInfo);

}