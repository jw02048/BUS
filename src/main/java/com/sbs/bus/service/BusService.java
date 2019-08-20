package com.sbs.bus.service;

import java.util.Map;

import com.sbs.bus.dto.Ticket;

public interface BusService {

	public Map<String, Object> doReserve(Map<String, Object> param);

	public Ticket getTicket(Map<String, Object> param);

}