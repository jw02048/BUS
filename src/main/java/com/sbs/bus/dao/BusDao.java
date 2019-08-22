package com.sbs.bus.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


import com.sbs.bus.dto.Service;
import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;

@Mapper
public interface BusDao {

	public int getLineId(Map<String, Object> reservationInfo);

	public List<Service> getServiceList(Map<String, Object> reservationInfo);
	
	public Line getServiceData(Map<String, Object> param);

	public Bus getBus(int busId);

}
