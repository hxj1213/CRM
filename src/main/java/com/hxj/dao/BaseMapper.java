package com.hxj.dao;


import com.hxj.page.PageBean;

import java.util.List;

public interface BaseMapper<T>{

	Integer insert(T entity);
	
	Integer update(T entity);
	
	Integer delete(Integer id);
	
	Integer deleteList(String[] ids);//1,2,3,4
	
	T selectById(Integer id);
	
	List<T> selectPageList(PageBean<T> page);
	
	Integer selectTotalRows(PageBean<T> page);
	
	Integer selectMaxId();

	Integer checkName(T loginObj);

	Integer login(T loginObj);
	
}
