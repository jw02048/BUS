package com.sbs.bus.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.bus.dto.Service;

@Mapper
public interface BusDao {

	public int getLineId(Map<String, Object> reservationInfo);

	public List<Service> getServiceList(Map<String, Object> reservationInfo);

}
