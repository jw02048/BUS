package com.sbs.bus.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.bus.dto.Bus;
import com.sbs.bus.dto.Line;

@Mapper
public interface BusDao {

	public Line getServiceData(Map<String, Object> param);

	public Bus getBus(int busId);

}
