package com.hxj.dao;

import com.hxj.entity.Evaluate;

import java.util.List;
import java.util.Map;

public interface EvaluateMapper extends BaseMapper<Evaluate>{

    Integer selectTotalRows(Map<String,Object> paramMap);

    List<Map<String,Object>> selectBycusId(Map<String,Object> paramMap);

    Map<String,Object> selectStarBycusId(Integer cusId,Integer cId);
}