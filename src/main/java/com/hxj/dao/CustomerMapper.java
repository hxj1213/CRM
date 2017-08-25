package com.hxj.dao;

import com.hxj.entity.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerMapper extends BaseMapper<Customer>{

    public Integer insertList(List<Customer> customerList);

    public Map<String,Integer> countProvince();

    public Map<String,Integer> countAge();

    public List<Integer> countGender();

}