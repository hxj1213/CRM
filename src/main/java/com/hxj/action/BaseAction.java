package com.hxj.action;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by com.hxj on 17-8-17.
 */
@Controller
@RequestMapping("/base")
public class BaseAction {

    /**
     * 自定义类型转换器
     */
    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder)throws Exception{
        binder.registerCustomEditor(
                Date.class,
                new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
    }

    ServletContext applicaition;

    @RequestMapping("/{folder}/{file}")
    public String goURL(@PathVariable String folder,@PathVariable String file){
        System.out.println(folder+"    "+file);
        return "forward:"+File.separator+"WEB-INF"+ File.separator+folder+File.separator+file+".jsp";
    }

}
