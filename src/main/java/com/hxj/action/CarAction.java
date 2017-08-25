package com.hxj.action;

import com.hxj.entity.Car;
import com.hxj.entity.Customer;
import com.hxj.page.PageBean;
import com.hxj.service.CarService;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.*;

/**
 * Created by hxj on 17-8-18.
 */
@Controller
@RequestMapping("/car")
public class CarAction extends BaseAction{

    private Map<String,Object> responseJson;

    public CarAction(){
        responseJson = new HashMap<String, Object>();
        responseJson.put("error",0);
    }

    @Resource
    private CarService carService;

    @RequestMapping("/save")
    @ResponseBody
    public String save(Car car){
        System.out.println("-------CarAction------save-----------");

        car.setPubtime(new Date());

        System.out.println("您保存的car为："+car.getCname()+" "+car.getCinfo()+"  "+car.getPubtime());

        Integer insert = carService.insert(car);
        System.out.println("添加："+insert);

        return "success";
    }

    @RequestMapping("/update")
    public String update(Car car){
        System.out.println("-------CarAction------update-----------");

        car.setCid(1);
        car.setCname("宝马");
        car.setCinfo("宝马(BMW)是享誉世界的豪华汽车品牌。宝马的车系有1、2、3、4、5、6、7、i、X、Z等几个系列，还有在各系基础上进行改进的M系（宝马官方的高性能改装部门）。");
        car.setPubtime(new Date());

        Integer update = carService.update(car);
        System.out.println("修改："+update);

        return "success";
    }

    @RequestMapping("/delete")
    public String delete(Integer id){
        System.out.println("-------CarAction------delete-----------");

        Integer delete = carService.delete(id);
        System.out.println("删除："+delete);

        return "success";
    }

    @RequestMapping("/selectById")
    @ResponseBody
    public Car selectById(Integer id){
        System.out.println("-------CarAction------selectById-----------");
        return carService.selectById(id);
    }

    @RequestMapping("/selectPage")
    @ResponseBody
    public Map<String,Object> selectPage(Integer page,Integer rows,String cname){
        System.out.println("-------CarAction------selectPage-----------");
        PageBean<Car> pageBean = new PageBean<Car>();
        if(page!=null){
            pageBean.setPageNow(page);
        }
        if(rows!=null){
            pageBean.setPageCount(rows);
        }
        Map<String,Object> paramMap = new HashMap<String, Object>();
        paramMap.put("cname","%"+cname+"%");
        pageBean.setConditions(paramMap);
        return carService.selectPage(pageBean).getMap();
    }

    @RequestMapping("/client/selectPage")
    @ResponseBody
    public Map<String,Object> selectClientPage(@RequestParam("offset")Integer offset,@RequestParam("limit")Integer limit){
        //limit=10&offset=0
        System.out.println("-------CarAction------selectClientPage-----------");
        System.out.println("offset:"+offset);
        System.out.println("limit:"+limit);
        PageBean<Car> pageBean = new PageBean<Car>();
        if(offset!=null){
            pageBean.setStart(offset);
        }
        if(limit!=null){
            pageBean.setPageCount(limit);
        }
        System.out.println(pageBean);
        return carService.selectPage(pageBean).getMap();
    }

    @RequestMapping("/selectMaxId")
    @ResponseBody
    public Integer selectMaxId(){
        System.out.println("-------CarAction------selectMaxId-----------");
        return carService.selectMaxId();
    }

    //批量添加------excel导入
    @RequestMapping("/insertList")
    @ResponseBody
    public Object insertList(HttpServletRequest request, @RequestParam("filename")String filename){
        System.out.println("-------CustomerAction------insertList-----------");
        String filePath = request.getServletContext().getRealPath(File.separator+"upload"+File.separator+filename);
        File file = new File(filePath);
        System.out.println("file:"+file);
        try {
            List<Car> cars = readFile(file);
            System.out.println(cars);
            Integer integer = carService.insertList(cars);
            System.out.println("添加："+integer);
            responseJson.put("msg","添加"+integer+"条数据成功！");
        }catch (Exception e){
            responseJson.put("error",1);
            responseJson.put("msg",e.getMessage());
            return responseJson;
        }
        return responseJson;
    }

    private List<Car> readFile(File file)throws Exception {

        InputStream ins = null;
        Workbook wb = null;
        ins = new FileInputStream(file);
        wb = WorkbookFactory.create(ins);
        ins.close();

        //3.得到Excel工作表对象
        Sheet sheet = wb.getSheetAt(0);
        System.out.println("sheet:" + sheet);
        //总行数
        int rowNum = sheet.getLastRowNum();
        System.out.println("总行数：" + rowNum);

        List<Car> carList = new ArrayList<Car>();

        for (int i = 2; i < rowNum - 1; i++) {
            Car car = new Car();
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
                        car.setCname(cell.getStringCellValue());
                        break;
                    case 1:
                        car.setCinfo(cell.getStringCellValue());
                        break;
                    case 2:
                        car.setPubtime(cell.getDateCellValue());
                        break;
                }
            }
            carList.add(car);
        }
        return carList;
    }

    @RequestMapping("/countCarByAll")
    @ResponseBody
    List<Map<String,Object>> countCarByAll(){
        return carService.countCarByAll();
    }

    @RequestMapping("/countCarByEvery")
    @ResponseBody
    List countCarByEvery(String what){
        return carService.countCarByEvery(what);
    }

}
