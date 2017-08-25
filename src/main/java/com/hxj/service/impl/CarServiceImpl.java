package com.hxj.service.impl;

import com.hxj.entity.Car;
import com.hxj.entity.Customer;
import com.hxj.service.CarService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-8-18.
 */
@Service
public class CarServiceImpl extends BaseServiceImpl<Car> implements CarService{

    public Integer insertList(List<Car> carList) {
        return carMapper.insertList(carList);
    }

    public List<Map<String, Object>> countCarByAll() {
        return carMapper.countCarByAll();
    }

    public List countCarByEvery(String what) {
        if("attitude".equals(what)){
            return carMapper.countCarByAttitude();
        }else if("exterior".equals(what)){
            return carMapper.countCarByExterior();
        }else if("trim".equals(what)){
            return carMapper.countCarByTrim();
        }else if ("space".equals(what)){
            return carMapper.countCarBySpace();
        }
        return null;
    }

}
