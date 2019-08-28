package com.sbs.bus.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.bus.dto.Service;
import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;
import com.sbs.bus.dto.Ticket;

@Mapper
public interface BusDao {

	public int getLineId(Map<String, Object> reservationInfo);

	public List<Service> getServiceList(Map<String, Object> reservationInfo);
	
	public Line getServiceData(Map<String, Object> param);

	public Bus getBus(int busId);
	
	public Ticket getTicket(Map<String, Object> param);

	public void newTicket(Map<String, Object> param);

	public List<Ticket> getTicketList(Map<String, Object> param);

	public List<Integer> getSelectedSeatNum(Map<String, Object> param);
}
