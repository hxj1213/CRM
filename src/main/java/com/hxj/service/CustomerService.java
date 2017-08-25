package com.hxj.service;

import com.hxj.entity.Customer;
import com.hxj.entity.Manager;

import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-8-18.
 */
public interface CustomerService extends BaseService<Customer>{

    Integer insertList(List<Customer> customerList);

    Map<String,Integer> countProvince();

    Map<String,Integer> countAge();

    List<Integer> countGender();

}
