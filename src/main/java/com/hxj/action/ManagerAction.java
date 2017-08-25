package com.hxj.action;

import com.hxj.entity.Manager;
import com.hxj.service.ManagerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by hxj on 17-8-21.
 */
@Controller
@RequestMapping("/mag")
public class ManagerAction extends BaseAction{

    @Resource
    private ManagerService managerService;

    @RequestMapping("/login")
    @ResponseBody
    public String login(HttpServletRequest request,Manager manager){
        System.out.println("-------ManagerAction------------login----------");
        Integer id = managerService.login(manager);
        System.out.println("-------"+id);
        if(id!=null){
            request.getSession().setAttribute("managerId",manager.getMid());
            request.getSession().setAttribute("managerName",manager.getMloginName());
            return "success";
        }
        return "fail";
    }

    @RequestMapping("/register")
    @ResponseBody
    public String register(Manager manager){
        System.out.println("-------ManagerAction------------register----------");
        return managerService.register(manager);
    }


}
