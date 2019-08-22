package com.sbs.bus.service;

import java.util.List;
import java.util.Map;
import com.sbs.bus.dto.Service;
import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;

import com.sbs.bus.dto.Ticket;

public interface BusService {
	public Map<String, Object> doReserve(Map<String, Object> param, String[] seatNums, String[] charges);

	public Ticket getTicket(Map<String, Object> param);

	public  List<Ticket> getTicketList(Map<String, Object> param);

	public int getLineId(Map<String, Object> reservationInfo);

	public List<Service> getServiceList(Map<String,Object> reservationInfo);

	public Line getServiceData(Map<String, Object> param);

	public Bus getBus(int busId);
}