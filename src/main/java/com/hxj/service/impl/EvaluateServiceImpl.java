package com.hxj.service.impl;

import com.hxj.entity.Evaluate;
import com.hxj.service.EvaluateService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-8-18.
 */
@Service
public class EvaluateServiceImpl extends BaseServiceImpl<Evaluate> implements EvaluateService{


    public Map<String, Object> selectBycusId(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Integer total = evaluateMapper.selectTotalRows(paramMap);
        List<Map<String,Object>> rows = evaluateMapper.selectBycusId(paramMap);
        resultMap.put("total",total);
        resultMap.put("rows",rows);
        return resultMap;
    }

    public Map<String, Object> selectStarBycusId(Integer cusId, Integer cId) {
        return evaluateMapper.selectStarBycusId(cusId,cId);
    }
}
