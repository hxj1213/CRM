package com.hxj.service.impl;

import com.hxj.dao.*;
import com.hxj.page.PageBean;
import com.hxj.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.PostConstruct;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.List;

/**
 * Created by com.hxj on 17-8-17.
 */
public class BaseServiceImpl<T> implements BaseService<T> {

    protected BaseMapper<T> baseMapper;

    @Autowired
    protected CarMapper carMapper;

    @Autowired
    protected CustomerMapper customerMapper;

    @Autowired
    protected EvaluateMapper evaluateMapper;

    @Autowired
    protected ManagerMapper managerMapper;

    @PostConstruct //在构造方法之后  初始化方法之前执行
    private void initBaseMapper() throws Exception{
        System.out.println("------------initBaseMapper---------------");
        //this关键字指对象本身，这里指的是调用此方法的实现类
        System.out.println("-----this:"+this);
        System.out.println("-----父类基本信息:"+this.getClass().getSuperclass());
        ParameterizedType type = (ParameterizedType)this.getClass().getGenericSuperclass();
        System.out.println("-----父类和泛型的基本信息:"+type);
        //获得第一个参数的class
        Class clazz = (Class) type.getActualTypeArguments()[0];
        System.out.println("clazz------"+clazz);
        //转化为属性名(相关的Mapper子类的引用名) Supplier ----- supplierMapper
        String localField = clazz.getSimpleName().substring(0,1).toLowerCase()
                +clazz.getSimpleName().substring(1)+"Mapper";
        System.out.println("-----localField:"+localField);
        //getDeclaredField 不包括父类
        Field field = this.getClass().getSuperclass().getDeclaredField(localField);
        System.out.println("------field:"+field);
        System.out.println("------field对应的对象："+field.get(this));

        Field baseField = this.getClass().getSuperclass().getDeclaredField("baseMapper");
        System.out.println("=======baseField:"+baseField);
        System.out.println("=======baseField对应的对象:"+baseField.get(this));

        //field.get(this)获取当前this的field字段的值。例如：Supplier对象中，baseMapper所指向的对象为其子类型SupplierMapper对象，子类型对象已被spring实例化于容器中
        baseField.set(this, field.get(this));
        System.out.println("========baseField对应的对象:"+baseMapper);
    }

    public Integer insert(T entity) {
        System.out.println("----------BaseServiceImpl-------insert---------------"+baseMapper);
        System.out.println(entity);
        return baseMapper.insert(entity);
    }

    public Integer update(T entity) {
        System.out.println("----------BaseServiceImpl-------update---------------");
        return baseMapper.update(entity);
    }

    public Integer delete(Integer id) {
        System.out.println("----------BaseServiceImpl-------delete---------------");
        return baseMapper.delete(id);
    }

    public Integer deleteList(String[] pks) {
        System.out.println("----------BaseServiceImpl-------deleteList---------------");
        return baseMapper.deleteList(pks);
    }

    public T selectById(Integer id) {
        System.out.println("----------BaseServiceImpl-------select---------------");
        return baseMapper.selectById(id);
    }

    public PageBean<T> selectPage(PageBean<T> page) {
        System.out.println("----------BaseServiceImpl-------selectPage---------------");
        page.setTotalRows(baseMapper.selectTotalRows(page));
        List<T> datas = baseMapper.selectPageList(page);
        System.out.println("----datas----"+datas);
        page.setDatas(datas);
        return page;
    }

    public Integer selectMaxId() {
        System.out.println("----------BaseServiceImpl-------selectMaxId---------------");
        return baseMapper.selectMaxId();
    }

    public Integer checkName(T loginObj) {
        return baseMapper.checkName(loginObj);
    }

    public String register(T loginObj) {
        Integer number = baseMapper.checkName(loginObj);
        if(number!=null){
            return "repeat";
        }
        baseMapper.insert(loginObj);
        return "success";
    }

    public Integer login(T loginObj) {
        return baseMapper.login(loginObj);
    }
}
