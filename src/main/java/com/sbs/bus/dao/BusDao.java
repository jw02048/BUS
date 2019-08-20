package com.sbs.bus.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.bus.dto.Ticket;

@Mapper
public interface BusDao {

	public Ticket getTicket(Map<String, Object> param);

	public void newTicket(Map<String, Object> param);

}
