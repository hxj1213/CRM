package com.hxj.service.impl;

import com.hxj.entity.Customer;
import com.hxj.service.CustomerService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-8-18.
 */
@Service
public class CustomerServiceImpl extends BaseServiceImpl<Customer> implements CustomerService{


    public Integer insertList(List<Customer> customerList) {
        return customerMapper.insertList(customerList);
    }

    public Map<String,Integer> countProvince() {
        return customerMapper.countProvince();
    }

    public Map<String, Integer> countAge() {
        return customerMapper.countAge();
    }

    public List<Integer> countGender() {
        return customerMapper.countGender();
    }

}
