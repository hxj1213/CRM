package com.hxj.action;

import com.hxj.entity.Car;
import com.hxj.entity.Evaluate;
import com.hxj.page.PageBean;
import com.hxj.service.EvaluateService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-8-18.
 */
@Controller
@RequestMapping("/evaluate")
public class EvaluateAction extends BaseAction{

    @Resource
    private EvaluateService evaluateService;

    @RequestMapping("/save")
    @ResponseBody
    public String save(Evaluate evaluate){
        System.out.println("-------EvaluateAction------save-----------");

        System.out.println("您保存的evaluate为："+evaluate);

        Integer insert = evaluateService.insert(evaluate);
        System.out.println("添加："+insert);

        return "success";
    }

    @RequestMapping("/update")
    @ResponseBody
    public String update(Evaluate evaluate){
        System.out.println("-------EvaluateAction------update-----------");

        System.out.println("您修改的内容为："+evaluate);

        Integer update = evaluateService.update(evaluate);
        System.out.println("修改："+update);

        return "success";
    }

    @RequestMapping("/delete")
    public String delete(Integer id){
        System.out.println("-------EvaluateAction------delete-----------");

        Integer delete = evaluateService.delete(id);
        System.out.println("删除："+delete);

        return "success";
    }

    @RequestMapping("/selectById")
    @ResponseBody
    public Evaluate selectById(Integer id){
        System.out.println("-------EvaluateAction------selectById-----------");
        return evaluateService.selectById(id);
    }

    @RequestMapping("/selectPage")
    @ResponseBody
    public Map<String,Object> selectPage(Integer pageNow){
        System.out.println("-------EvaluateAction------selectPage-----------");
        PageBean<Evaluate> pageBean = new PageBean<Evaluate>();
        if(pageNow!=null){
            pageBean.setPageNow(pageNow);
        }
        return evaluateService.selectPage(pageBean).getMap();
    }

    @RequestMapping("/selectMaxId")
    @ResponseBody
    public Integer selectMaxId(){
        System.out.println("-------EvaluateAction------selectMaxId-----------");
        return evaluateService.selectMaxId();
    }

    @RequestMapping("/selectBycusId")
    @ResponseBody
    public Map<String,Object> selectBycusId(@RequestParam("cname")String  cname,@RequestParam("cusId")Integer cusId, @RequestParam("offset")Integer offset, @RequestParam("limit")Integer limit) {
        System.out.println("-------CarAction------selectClientPage-----------");
        System.out.println("offset:"+offset);
        System.out.println("limit:"+limit);
        System.out.println("cname:"+cname);
        System.out.println("cusId:"+cusId);
        Map<String,Object> paramMap = new HashMap<String, Object>();
        paramMap.put("cname","%"+cname+"%");
        paramMap.put("cusId",cusId);
        paramMap.put("offset",offset);
        paramMap.put("limit",limit);
        Map<String,Object> map = evaluateService.selectBycusId(paramMap);
        System.out.println("查询结果："+map);
        return map;
    }

    @RequestMapping("/selectStarBycusId")
    @ResponseBody
    public Map<String, Object> selectStarBycusId(Integer cusId,Integer cId) {
        System.out.println("cusId:"+cusId+"     cId:"+cId);
        return evaluateService.selectStarBycusId(cusId,cId);
    }

}
