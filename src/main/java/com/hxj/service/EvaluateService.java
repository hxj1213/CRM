package com.hxj.service;

import com.hxj.entity.Evaluate;

import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-8-18.
 */
public interface EvaluateService extends BaseService<Evaluate>{

    Map<String,Object> selectBycusId(Map<String,Object> paramMap);

    Map<String,Object> selectStarBycusId(Integer cusId,Integer cId);
}
