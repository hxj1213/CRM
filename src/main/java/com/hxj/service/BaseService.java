package com.hxj.service;


import com.hxj.entity.Manager;
import com.hxj.page.PageBean;

import java.util.Map;

/**
 * Created by com.hxj on 17-8-17.
 */
public interface BaseService<T> {

    Integer insert(T entity);

    Integer update(T entity);

    Integer delete(Integer id);

    Integer deleteList(String[] pks);

    T selectById(Integer id);

    PageBean<T> selectPage(PageBean<T> page);

    Integer selectMaxId();

    Integer checkName(T loginObj);

    String register(T loginObj);

    Integer login(T loginObj);

}
