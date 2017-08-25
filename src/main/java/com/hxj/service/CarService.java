package com.hxj.service;

import com.hxj.entity.Car;

import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-8-18.
 */
public interface CarService extends BaseService<Car>{

    Integer insertList(List<Car> carList);

    List<Map<String,Object>> countCarByAll();

    List countCarByEvery(String what);

}
