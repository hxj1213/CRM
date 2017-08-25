package com.hxj.action;

import com.hxj.entity.Customer;
import com.hxj.page.PageBean;
import com.hxj.service.CustomerService;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.*;

/**
 * Created by hxj on 17-8-18.
 */
@Controller
@RequestMapping("/customer")
public class CustomerAction extends BaseAction{

    private Map<String,Object> responseJson;

    public CustomerAction(){
        responseJson = new HashMap<String, Object>();
        responseJson.put("error",0);
    }

    @Resource
    private CustomerService customerService;

    @RequestMapping("/login")
    @ResponseBody
    public String login(HttpServletRequest request,Customer customer){
        System.out.println("-----------CustomerAction--------login---------------");
        Integer id = customerService.login(customer);
        System.out.println("------"+id);
        if(id!=null){
            request.getSession().setAttribute("cusId",id);
            request.getSession().setAttribute("cusName", customer.getCusLoginName());
            return "success";
        }
        return "fail";
    }

    @RequestMapping("/register")
    @ResponseBody
    public String register(Customer customer){
        System.out.println("-----------CustomerAction--------register---------------");
        System.out.println("customer:"+customer);
        return customerService.register(customer);
    }


    @RequestMapping("/save")
    @ResponseBody
    public String save(Customer customer){
        System.out.println("-------CustomerAction------save-----------");

        System.out.println("您保存的car为："+customer);

        Integer insert = customerService.insert(customer);
        System.out.println("添加："+insert);

        return "success";
    }

    @RequestMapping("/update")
    public String update(Customer customer){
        System.out.println("-------CustomerAction------update-----------");

        System.out.println("您修改的customer为："+customer);

        Integer update = customerService.update(customer);
        System.out.println("修改："+update);

        return "success";
    }

    @RequestMapping("/delete")
    public String delete(Integer id){
        System.out.println("-------CustomerAction------delete-----------");

        Integer delete = customerService.delete(id);
        System.out.println("删除："+delete);

        return "success";
    }

    @RequestMapping("/selectById")
    @ResponseBody
    public Customer selectById(Integer id){
        System.out.println("-------CustomerAction------selectById-----------");
        return customerService.selectById(id);
    }

    @RequestMapping("/selectPage")
    @ResponseBody
    public Map<String,Object> selectPage(Integer page,Integer rows,String cname){
        System.out.println("-------CustomerAction------selectPage-----------");
        PageBean<Customer> pageBean = new PageBean<Customer>();
        if(page!=null){
            pageBean.setPageNow(page);
        }
        if(rows!=null){
            pageBean.setPageCount(rows);
        }
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("cname","%"+cname+"%");
        pageBean.setConditions(map);
        return customerService.selectPage(pageBean).getMap();
    }

    @RequestMapping("/selectMaxId")
    @ResponseBody
    public Integer selectMaxId(){
        System.out.println("-------CustomerAction------selectMaxId-----------");
        return customerService.selectMaxId();
    }

    @RequestMapping("/checkName")
    @ResponseBody
    public Map<String,Object> checkName(Customer customer){
        System.out.println("-------CustomerAction------checkName-----------");
        Integer id = customerService.checkName(customer);
        responseJson.clear();
        responseJson.put("valid",!(id!=null && id>0));
        return responseJson;
    }

    @RequestMapping("/countProvince")
    @ResponseBody
    public Map<String,Integer> countProvince(){
        System.out.println("-------CustomerAction------countProvince-----------");
        return customerService.countProvince();
    }

    @RequestMapping("/countAge")
    @ResponseBody
    public Map<String,Integer> countAge(){
        System.out.println("-------CustomerAction------countAge-----------");
        return customerService.countAge();
    }

    @RequestMapping("/countGender")
    @ResponseBody
    public List<Integer> countGender(){
        System.out.println("-------CustomerAction------countGender-----------");
        return customerService.countGender();
    }


    //批量添加------excel导入
    @RequestMapping("/insertList")
    @ResponseBody
    public Object insertList(HttpServletRequest request,@RequestParam("filename")String filename){
        System.out.println("-------CustomerAction------insertList-----------");
        String filePath = request.getServletContext().getRealPath(File.separator+"upload"+File.separator+filename);

        File file = new File(filePath);
        System.out.println("file:"+file);

        try {
            List<Customer> customers = readFile(file);
            System.out.println(customers);
            Integer integer = customerService.insertList(customers);
            System.out.println("添加："+integer);
            responseJson.put("msg","添加"+integer+"条数据成功！");
        }catch (Exception e){
            responseJson.put("error",1);
            responseJson.put("msg",e.getMessage());
            return responseJson;
        }
        return responseJson;
    }


    private List<Customer> readFile(File file)throws Exception {

        InputStream ins = null;
        Workbook wb = null;
        ins = new FileInputStream(file);
        //ins= ExcelService.class.getClassLoader().getResourceAsStream(filePath);
        wb = WorkbookFactory.create(ins);
        ins.close();


        //3.得到Excel工作表对象
        Sheet sheet = wb.getSheetAt(0);
        System.out.println("sheet:" + sheet);
        //总行数
        int rowNum = sheet.getLastRowNum();
        System.out.println("总行数：" + rowNum);

        List<Customer> customerList = new ArrayList<Customer>();

        for (int i = 2; i < rowNum - 1; i++) {
            Customer customer = new Customer();
            //4.得到Excel工作表的行
            Row row = sheet.getRow(i);
            //总列数
            int colNum = row.getLastCellNum();
            System.out.println("总列数：" + colNum);
            for (int j = 0; j < colNum; j++) {
                //5.得到Excel工作表指定行的单元格
                Cell cell = row.getCell((short) j);
                System.out.print(cell + " ");
                switch (j) {
                    case 0:
                        customer.setCusname(cell.getStringCellValue());
                        break;
                    case 1:
                        if ("男".equals(cell.getStringCellValue())) {
                            customer.setCusgender(0);
                        } else if ("女".equals(cell.getStringCellValue())) {
                            customer.setCusgender(1);
                        } else {
                            throw new RuntimeException("导入失败，性别存在男女以外的值");
                        }
                        break;
                    case 2:
                        customer.setCusage(new Double(cell.getNumericCellValue()).intValue());
                        break;
                    case 3:
                        customer.setCusprovince(cell.getStringCellValue());
                        break;
                    case 4:
                        customer.setCusarea(cell.getStringCellValue());
                        break;
                    case 5:
                        customer.setCusphone(String.valueOf(new Double(cell.getNumericCellValue()).longValue()));
                        break;
                    case 6:
                        customer.setCusLoginName(cell.getStringCellValue());
                        break;
                    case 7:
                        customer.setCusLoginPass(cell.getStringCellValue());
                        break;
                }
            }
            customerList.add(customer);
        }
        return customerList;
    }


}
