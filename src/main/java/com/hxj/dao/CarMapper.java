package com.hxj.dao;

import com.hxj.entity.Car;

import java.util.List;
import java.util.Map;

public interface CarMapper extends BaseMapper<Car>{

    Integer insertList(List<Car> carList);

    List<Map<String,Object>> countCarByAll();

    List countCarByAttitude();

    List countCarByExterior();

    List countCarByTrim();

    List countCarBySpace();

}